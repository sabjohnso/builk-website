+++
title = "REPL"
weight = 1
+++

Start the REPL by running `wile` with no arguments:

```sh
wile
```

## Features

- **Syntax highlighting** with two built-in themes (dark and light)
- **Rainbow parentheses** — depth-based color cycling for matching parens
- **Paredit** — structural editing that keeps parentheses balanced
- **Multi-line input** — automatic detection of incomplete expressions
- **Tab completion** — completes Scheme identifiers and REPL commands
- **History** — persistent across sessions, saved to `~/.wile_history`
- **Emacs keybindings** — Ctrl-A/E, Ctrl-B/F, Ctrl-K, Ctrl-U, Alt-Left/Right
- **Library watching** — in package projects, rebuilds stale libraries in the background

## REPL commands

Commands are prefixed with a comma:

| Command | Description |
|---------|-------------|
| `,help` / `,h` | Show available commands |
| `,quit` / `,q` | Exit the REPL |
| `,load <file>` | Load and evaluate a Scheme file |
| `,env` | List all bound names in the global environment |
| `,libs` | List loaded/registered libraries |
| `,available` | List all discoverable libraries on disk |
| `,exports <lib>` | Show exports of a library, e.g. `,exports (scheme base)` |
| `,deps <lib>` | Show dependency tree, e.g. `,deps (srfi 1)` |
| `,reload <lib>` | Reload a library from source |
| `,build` | Trigger library rebuild |
| `,theme <name>` | Switch theme: `dark`, `light`, `none`, or a file path |
| `,paredit` | Toggle structural editing mode |

## Paredit mode

Paredit keeps parentheses balanced automatically. When enabled:

- Typing `(` inserts `()` and places the cursor inside
- Typing `)` moves past the closing paren instead of inserting
- Backspace will not delete an unmatched paren
- `"` handles string delimiters in balanced pairs

Structural operations:

| Operation | Description |
|-----------|-------------|
| Slurp forward | Absorb the next s-expression into the current list |
| Slurp backward | Absorb the previous s-expression |
| Barf forward | Eject the last s-expression from the current list |
| Barf backward | Eject the first s-expression |
| Wrap | Wrap the next s-expression in parentheses |
| Splice | Remove the enclosing parentheses |
| Raise | Replace the enclosing list with the current s-expression |

Toggle paredit on or off with `,paredit`.

## Themes

Switch between built-in themes or load a custom theme file:

```
,theme dark
,theme light
,theme none
,theme /path/to/my-theme.scm
```

You can also set the default theme with the `WILE_THEME` environment variable.

Settings (theme, paredit mode) persist across sessions in `~/.wile/config`.

## Keyboard shortcuts

| Key | Action |
|-----|--------|
| Ctrl-A | Move to start of line |
| Ctrl-E | Move to end of line |
| Ctrl-B / Ctrl-F | Move backward/forward one character |
| Alt-Left / Alt-Right | Move backward/forward one word |
| Ctrl-K | Kill from cursor to end of line |
| Ctrl-U | Kill from cursor to start of line |
| Ctrl-W | Kill previous word |
| Up / Down | Navigate history |
| Tab | Complete identifier or command |
| Ctrl-D | Exit (on empty line) |
