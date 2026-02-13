+++
title = "Getting Started"
weight = 1
+++

This guide walks you through installing Bilk Scheme and writing your first
Scheme program.

## Prerequisites

Bilk Scheme requires:

- **OCaml 5.3.0** with the BER MetaOCaml variant (`ocaml-variants.5.3.0+BER`)
- **opam** (the OCaml package manager)
- **GMP** (GNU Multiple Precision Arithmetic Library)

Install GMP for your platform:

{{< tabs items="Debian/Ubuntu,macOS" >}}

  {{< tab >}}
  ```sh
  sudo apt install libgmp-dev
  ```
  {{< /tab >}}

  {{< tab >}}
  ```sh
  brew install gmp
  ```
  {{< /tab >}}

{{< /tabs >}}

## Installation

Clone the repository and create a local opam switch:

```sh
git clone https://github.com/bilk-scheme/bilk.git
cd bilk
opam switch create . ocaml-variants.5.3.0+BER
eval $(opam env)
```

Install dependencies:

```sh
opam install . --deps-only --with-test -y
```

Build and install:

```sh
dune build
dune install
```

Verify the installation:

```sh
bilk -e '(display "ready")'
```

You should see `ready` printed to the terminal.

## The REPL

Start the interactive REPL by running `bilk` with no arguments:

```sh
bilk
```

Try evaluating some expressions:

```scheme
> (+ 1 2)
3
> (define (square x) (* x x))
> (square 12)
144
> (map square '(1 2 3 4 5))
(1 4 9 16 25)
```

The REPL supports syntax highlighting, rainbow parentheses, multi-line input,
tab completion, and history. Type `,help` to see available REPL commands, or
`,paredit` to toggle structural editing mode.

## Running a file

Create a file called `hello.scm`:

```scheme
(import (scheme base)
        (scheme write))

(define (greet name)
  (display "Hello, ")
  (display name)
  (display "!")
  (newline))

(greet "world")
```

Run it:

```sh
bilk hello.scm
```

```
Hello, world!
```

You can also evaluate a single expression from the command line:

```sh
bilk -e '(for-each display (list 3 "+" 4 "=" (+ 3 4)))'
```

## Compiling programs

Bilk Scheme can compile Scheme source ahead of time. There are two targets:

**FASL bytecode** — a portable binary format:

```sh
bilk compile hello.scm -o hello.fasl
bilk run hello.fasl
```

**Standalone executable** — a self-contained binary:

```sh
bilk compile hello.scm --exe -o hello
./hello
```

## Shebang scripts

Add a shebang line to make a Scheme file directly executable:

```scheme
#!/usr/bin/env bilk
(import (scheme base)
        (scheme write)
        (scheme process-context))

(for-each
  (lambda (arg)
    (display arg)
    (newline))
  (command-line))
```

```sh
chmod +x script.scm
./script.scm arg1 arg2
```

## Editor setup

Bilk Scheme includes a Language Server Protocol (LSP) server that provides
diagnostics, go-to-definition, find-references, hover, and completion.

Start the LSP server with:

```sh
bilk lsp
```

Configure your editor to use `bilk lsp` as the language server command for
Scheme files.

{{< tabs items="VS Code,Emacs,Neovim" >}}

  {{< tab >}}
  Install a generic LSP client extension (such as
  [vscode-langservers](https://marketplace.visualstudio.com/items?itemName=APerezGrael.generic-lsp-client)
  or configure via `.vscode/settings.json`):

  ```json
  {
    "languageServerExample.trace.server": "verbose",
    "[scheme]": {
      "editor.formatOnSave": false
    }
  }
  ```

  Point the LSP client at `bilk lsp` as the server command for `scheme` files.
  {{< /tab >}}

  {{< tab >}}
  Using [eglot](https://github.com/joaotavora/eglot) (built into Emacs 29+):

  ```elisp
  (add-to-list 'eglot-server-programs
               '(scheme-mode . ("bilk" "lsp")))
  ```

  Then run `M-x eglot` in a Scheme buffer.
  {{< /tab >}}

  {{< tab >}}
  Using [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig):

  ```lua
  vim.lsp.config('bilk', {
    cmd = { 'bilk', 'lsp' },
    filetypes = { 'scheme' },
    root_markers = { '.git' },
  })

  vim.lsp.enable('bilk')
  ```
  {{< /tab >}}

{{< /tabs >}}

## Next steps

You now have Bilk Scheme installed and know how to run, compile, and edit Scheme code.
Explore the [Guide]({{< relref "/docs/guide" >}}) for in-depth coverage of
macros, the numeric tower, libraries, and developer tools.
