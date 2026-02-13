+++
title = "Wile Scheme"
toc = false
+++

{{< hextra/hero-headline >}}
  Wile Scheme
{{< /hextra/hero-headline >}}

{{< hextra/hero-subtitle >}}
  An R7RS Scheme compiler that targets a fast stack-based VM.&nbsp;<br class="sm:block hidden" />
  Full numeric tower, hygienic macros, 36 SRFIs, and developer tooling built in.
{{< /hextra/hero-subtitle >}}

<div class="mt-6 mb-6 flex flex-wrap gap-4 justify-center">
{{< hextra/hero-button text="Get Started" link="docs/getting-started" >}}
<a href="docs/" class="inline-flex items-center px-6 py-2.5 text-sm font-medium rounded-full border border-current transition-colors hover:bg-gray-100 dark:hover:bg-neutral-800">Documentation →</a>
</div>

{{< hextra/hero-section >}}
  <h2 class="text-2xl sm:text-3xl font-bold tracking-tight mt-12 mb-6 text-center">See It in Action</h2>
{{< /hextra/hero-section >}}

{{< tabs items="Basics,Macros,Numeric Tower,Libraries" >}}

  {{< tab >}}
  ```scheme
  (define (fizzbuzz n)
    (let loop ((i 1))
      (when (<= i n)
        (cond
          ((= 0 (modulo i 15)) (display "FizzBuzz"))
          ((= 0 (modulo i 3))  (display "Fizz"))
          ((= 0 (modulo i 5))  (display "Buzz"))
          (else                 (display i)))
        (newline)
        (loop (+ i 1)))))

  (fizzbuzz 20)
  ```
  {{< /tab >}}

  {{< tab >}}
  ```scheme
  ;; Hygienic macros with syntax-rules
  (define-syntax when
    (syntax-rules ()
      ((when test body ...)
       (if test (begin body ...)))))

  (define-syntax swap!
    (syntax-rules ()
      ((swap! a b)
       (let ((tmp a))
         (set! a b)
         (set! b tmp)))))

  (define x 1)
  (define y 2)
  (swap! x y)
  (display x)  ; => 2
  ```
  {{< /tab >}}

  {{< tab >}}
  ```scheme
  ;; Full numeric tower: fixnum, rational, flonum, complex
  (+ 1/2 1/3)           ; => 5/6
  (- 1/2 1/3)           ; => 1/6
  (* 0+1i 0+1i)         ; => -1  (i² = -1)
  (+ 1+2i 3+4i)         ; => 4+6i
  (/ 3+4i 5+10i)        ; => 11/25-2/25i
  (exact->inexact 1/3)  ; => 0.3333333333333333
  ```
  {{< /tab >}}

  {{< tab >}}
  ```scheme
  ;; R7RS define-library with import/export
  (define-library (mylib utils)
    (import (scheme base)
            (scheme write))
    (export double greet)
    (begin
      (define (double x) (* x 2))
      (define (greet name)
        (display "Hello, ")
        (display name)
        (newline))))

  (import (mylib utils))
  (display (double 21))  ; => 42
  (greet "world")        ; => Hello, world
  ```
  {{< /tab >}}

{{< /tabs >}}

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
