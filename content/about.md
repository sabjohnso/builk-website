+++
title = "About Wile"
toc = true
+++

## What is wile?

Wile is an R7RS Scheme implementation written in OCaml. It compiles Scheme
source to bytecode and executes it on a stack-based virtual machine — there is
no interpreter mode. Every `eval` compiles to bytecode first, then executes.

Wile aims to be a modern, batteries-included Scheme with the developer tools
you'd expect from a mainstream language: an LSP server, a debugger, a profiler,
a package manager, and an interactive REPL with syntax highlighting and
structural editing.

## Architecture

The compilation pipeline has four stages:

```
Source → Reader → Expander → Compiler → VM
```

- **Reader** — parses text into S-expressions with source locations
- **Expander** — hygienic macro expansion (`syntax-rules`, `define-record-type`, `guard`, quasiquote)
- **Compiler** — compiles expanded syntax to bytecode (12 instructions)
- **VM** — a stack-based accumulator machine that executes bytecode

The VM supports first-class continuations (stack-copying `call/cc`),
`dynamic-wind`, and guaranteed tail-call optimization.

## Design philosophy

**Compilation only.** There is no interpreter. Even interactive REPL input is
compiled to bytecode before execution. This keeps the execution model uniform
and means optimizations benefit all code paths.

**R7RS first.** Wile implements the full R7RS standard including all 16
`(scheme ...)` libraries, the library system (`define-library`, `import`,
`export`), hygienic macros, and first-class continuations.

**Batteries included.** 36 bundled SRFIs, a full numeric tower (fixnum through
complex), and developer tools (LSP, DAP, profiler) ship with the compiler.

**Embeddable.** Multiple independent Scheme instances can coexist in a single
process. Embedding APIs are provided for both OCaml and C.

## Implementation

Wile is implemented in OCaml (37 modules, ~21k lines) with a test suite of
1600+ tests across 40 test files. It requires OCaml 5.3.0 with the BER
MetaOCaml variant and uses GMP (via zarith) for arbitrary-precision arithmetic.

The 12 bytecode instructions are: `Halt`, `Const`, `Lookup`, `Define`,
`SetBang`, `Push`, `Jump`, `JumpFalse`, `Call`, `TailCall`, `Return`, and
`MakeClosure`.

## License

Wile is released under the [MIT License](https://opensource.org/licenses/MIT).

## Source code

The source is hosted on GitHub: [github.com/wile-scheme/wile](https://github.com/wile-scheme/wile)
