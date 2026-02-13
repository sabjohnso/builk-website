+++
title = "LSP Server"
weight = 2
+++

Bilk Scheme includes a Language Server Protocol (LSP) server for editor integration.

## Starting the server

```sh
bilk lsp
```

By default the server communicates over stdin/stdout. To use a TCP socket:

```sh
bilk lsp --port 5007
```

## Capabilities

| Feature | Description |
|---------|-------------|
| **Diagnostics** | Real-time compilation and macro-expansion errors as you type |
| **Hover** | Shows binding type (variable, core form, macro, unbound) |
| **Completion** | Symbol name completion with kind classification |
| **Go to definition** | Jump to the binding site of any identifier |
| **Find references** | Locate all uses of a binding |
| **Document symbols** | List all top-level definitions in the current file |
| **Semantic tokens** | Full semantic highlighting (keywords, strings, numbers, comments, variables, functions, parameters) |

## Editor configuration

See [Getting Started — Editor setup]({{< relref "/docs/getting-started#editor-setup" >}})
for VS Code, Emacs, and Neovim configuration examples.

The key is to point your editor's LSP client at `bilk lsp` as the server
command for Scheme files.

## How it works

The LSP server performs a full recompilation on each document change. This gives
accurate diagnostics for syntax errors, undefined variables, arity mismatches,
and macro expansion failures.

Semantic tokens classify every token in the file, enabling editors to provide
richer highlighting than regex-based grammars. Token types include:

- `keyword` — special forms (`define`, `if`, `lambda`, etc.)
- `function` — procedure references
- `parameter` — function parameters
- `variable` — other bindings
- `string`, `number`, `comment` — literals

Token modifiers include `definition` (for binding sites) and `readonly` (for
immutable bindings).
