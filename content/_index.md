---
title: wile
toc: false
---

{{< hextra/hero-headline >}}
  An R7RS Scheme Compiler
{{< /hextra/hero-headline >}}

{{< hextra/hero-subtitle >}}
  Compiles Scheme to bytecode and runs it on a fast stack-based VM.&nbsp;<br class="sm:block hidden" />
  Full numeric tower, hygienic macros, 36 SRFIs, and developer tooling built in.
{{< /hextra/hero-subtitle >}}

<div class="mt-6 mb-6">
{{< hextra/hero-button text="Get Started" link="docs/getting-started" >}}
</div>

{{< hextra/feature-grid >}}

  {{< hextra/feature-card
    title="R7RS Compliant"
    subtitle="All 16 `(scheme ...)` standard libraries, hygienic macros, first-class continuations, and the full R7RS library system."
    icon="check-circle"
  >}}

  {{< hextra/feature-card
    title="36 Bundled SRFIs"
    subtitle="Lists, strings, char-sets, hash tables, regex, bitwise operations, and more — ready to import."
    icon="collection"
  >}}

  {{< hextra/feature-card
    title="Developer Tooling"
    subtitle="Language Server Protocol (LSP), Debug Adapter Protocol (DAP), and a runtime profiler with flame graph output."
    icon="terminal"
  >}}

  {{< hextra/feature-card
    title="Compiles to Bytecode"
    subtitle="Every `eval` compiles first — no interpreter mode. Ahead-of-time compilation to FASL or standalone executables."
    icon="lightning-bolt"
  >}}

  {{< hextra/feature-card
    title="Embeddable"
    subtitle="Embed Scheme in OCaml or C applications. Multiple independent instances per process."
    icon="puzzle"
  >}}

  {{< hextra/feature-card
    title="Interactive REPL"
    subtitle="Syntax highlighting, rainbow parentheses, paredit, multi-line editing, history, and tab completion."
    icon="terminal"
  >}}

{{< /hextra/feature-grid >}}
