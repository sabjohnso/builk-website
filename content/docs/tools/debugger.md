+++
title = "Debugger"
weight = 3
+++

Wile Scheme includes a Debug Adapter Protocol (DAP) server for step-through debugging.

## Starting a debug session

```sh
wile debug program.scm
```

By default the DAP server communicates over stdin/stdout. To use a TCP socket:

```sh
wile debug program.scm --port 5008
```

## Features

### Breakpoints

Set breakpoints at specific line numbers. Breakpoints are verified when first
encountered during execution.

### Stepping

| Mode | Description |
|------|-------------|
| **Step in** | Stop at the next call, descending into functions |
| **Step over** | Stop at the next call at the same or lower depth |
| **Step out** | Stop when returning to the caller |
| **Continue** | Resume execution until the next breakpoint |
| **Pause** | Break at the next call site |

### Stack inspection

View the full call stack with procedure name, file, line, and column for each
frame.

### Variable inspection

Inspect local and global variables in each stack frame. Composite values
(pairs, vectors, records) can be expanded for hierarchical inspection.

### Expression evaluation

Evaluate arbitrary Scheme expressions in the context of any stack frame or the
global environment.

## Editor integration

Any DAP-compatible editor can connect to the Wile Scheme debugger:

- **VS Code** — use a generic DAP extension or configure `launch.json`
- **Emacs** — use [dape](https://github.com/svaante/dape)
- **Neovim** — use [nvim-dap](https://github.com/mfussenegger/nvim-dap)

Configure the debug adapter to run `wile debug <file>` as the launch command.
