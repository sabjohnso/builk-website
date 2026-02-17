+++
title = "Remote REPL"
weight = 2
+++

Bilk provides a remote REPL that lets you run a persistent Scheme session on one
machine and interact with it from another. Three subcommands work together:

- **`bilk serve`** — start a REPL server
- **`bilk attach`** — connect to a running server
- **`bilk connect`** — SSH bootstrap: start a server on a remote host and auto-attach

## `bilk serve`

Start a persistent REPL server:

```sh
bilk serve
bilk serve --port 9000 --name my-session --auto-checkpoint
```

The server holds a live Scheme instance and accepts client connections over TCP.
It stays alive when clients disconnect, so long-running computations and
accumulated state are preserved.

On startup the server prints a machine-readable line to stdout:

```
BILK CONNECT <port> <base64-key>
```

This line is consumed by `bilk connect` for SSH bootstrapping. The encryption
key is generated fresh for each session.

### Options

| Flag | Default | Description |
|------|---------|-------------|
| `--port PORT` | 7890 | TCP port to listen on |
| `--name NAME` | `"default"` | Session name (used for display and checkpoint naming) |
| `--bind ADDRESS` | `127.0.0.1` | Network address to bind to |
| `--insecure` | off | Disable encryption (only allowed on loopback) |
| `--auto-checkpoint` | off | Automatically checkpoint state on client disconnect |
| `--session-timeout SECS` | 86400 (1 day) | Session timeout in seconds |

### Security

By default, all traffic is encrypted with **ChaCha20-Poly1305** authenticated
encryption. A 256-bit key is generated per session and shared with the client
via the `BILK CONNECT` line (or the `BILK_KEY` environment variable for
`bilk attach`).

The handshake performs **mutual authentication**: the server challenges the
client with a random nonce, the client proves knowledge of the key via
HMAC-SHA256, and the server proves back. Both sides reject unauthenticated
peers.

The `--insecure` flag disables encryption but is only allowed when binding to a
loopback address (`127.0.0.1` or `::1`).

## `bilk attach`

Connect to a running server:

```sh
bilk attach localhost:7890
bilk attach 192.168.1.10:9000 --theme light --paredit
```

The client provides the full local REPL experience — syntax highlighting,
rainbow parentheses, paredit, tab completion, multi-line editing, and history —
with zero-latency keystrokes. Only complete expressions are sent to the server
for evaluation.

The encryption key is read from the `BILK_KEY` environment variable (set
automatically by `bilk connect`).

### Options

| Flag | Default | Description |
|------|---------|-------------|
| `--theme THEME` | `dark` | Color theme: `dark`, `light`, `none`, or a file path |
| `--paredit` | off | Enable paredit structural editing |

### Client-local vs server-side commands

REPL comma commands are split between client and server:

**Client-local** (handled instantly, no server round-trip):

| Command | Description |
|---------|-------------|
| `,quit` / `,q` | Disconnect and exit |
| `,help` / `,h` | Show available commands |
| `,paredit` | Toggle structural editing |
| `,theme <name>` | Switch color theme |
| `,clear` | Clear terminal and scrollback |

**Server-side** (sent to the server for execution):

| Command | Description |
|---------|-------------|
| `,checkpoint [name]` | Save a named session checkpoint |
| `,revert [name]` | Restore a saved checkpoint |
| `,checkpoints` | List all available checkpoints |
| `,save-session <file>` | Save all checkpoints to a file |
| `,load-session <file>` | Load checkpoints from a file |
| `,env` | List global bindings |
| `,libs` | List loaded libraries |
| `,exports <lib>` | Show library exports |
| `,deps <lib>` | Show library dependencies |
| `,reload <lib>` | Reload a library |
| `,load <file>` | Load a Scheme file |

## `bilk connect`

SSH bootstrap: start a server on a remote host and automatically attach:

```sh
bilk connect user@host
bilk connect user@host --serve-port 9000 --auto-checkpoint --name dev
bilk connect user@host -p 2222
```

This spawns an SSH session to the remote host, runs `bilk serve` there, reads
the `BILK CONNECT` line from the remote process, and auto-attaches as a local
client. The encryption key is passed through the SSH channel and never touches
the network in plaintext.

### Options

| Flag | Default | Description |
|------|---------|-------------|
| `--port PORT` / `-p PORT` | 22 | SSH port on the remote host |
| `--serve-port PORT` | 7890 | Port for `bilk serve` on the remote |
| `--auto-checkpoint` | off | Enable auto-checkpoint on disconnect |
| `--name NAME` | `"default"` | Session name on the remote |
| `--session-timeout SECS` | 86400 (1 day) | Session timeout on the remote |

The `--insecure` and `--bind` flags are never forwarded to the remote server.

## Typical workflow

```sh
# Start a session on a remote dev machine
bilk connect dev@build-server --auto-checkpoint --name experiment

# ... work interactively, define functions, load libraries ...

# Disconnect (Ctrl-D or ,quit) — state is auto-checkpointed

# Later, reconnect to the same server
bilk attach build-server:7890

# Revert to a previous checkpoint if needed
,revert experiment
```
