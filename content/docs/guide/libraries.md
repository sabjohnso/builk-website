+++
title = "Libraries"
weight = 8
+++

Bilk Scheme implements the R7RS library system for organizing code into reusable
modules.

## define-library

A library has a name, imports, exports, and a body:

```scheme
(define-library (mylib math)
  (import (scheme base))
  (export square cube)
  (begin
    (define (square x) (* x x))
    (define (cube x) (* x x x))))
```

Library names are lists of identifiers, e.g. `(mylib math)`.

## import

Import a library to use its exports:

```scheme
(import (mylib math))
(square 5)  ; => 25
(cube 3)    ; => 27
```

### Selective import

Import only specific bindings:

```scheme
(import (only (scheme base) define if +))
```

### Renaming

Rename imports to avoid conflicts:

```scheme
(import (rename (mylib math) (square sq)))
(sq 5)  ; => 25
```

### Excluding

Import everything except specific bindings:

```scheme
(import (except (scheme base) define))
```

### Prefix

Add a prefix to all imported names:

```scheme
(import (prefix (mylib math) m:))
(m:square 5)  ; => 25
```

## export

The `export` declaration lists which bindings are visible to importers:

```scheme
(export square cube)          ; export by name
(export (rename internal-name external-name))  ; export with renaming
```

## Standard libraries

Bilk Scheme provides all 16 R7RS standard libraries:

| Library | Purpose |
|---------|---------|
| `(scheme base)` | Core forms and procedures |
| `(scheme case-lambda)` | `case-lambda` form |
| `(scheme char)` | Character operations |
| `(scheme complex)` | Complex number operations |
| `(scheme cxr)` | `caaar` through `cddddr` |
| `(scheme eval)` | `eval` and `environment` |
| `(scheme file)` | File I/O |
| `(scheme inexact)` | Inexact number operations |
| `(scheme lazy)` | `delay`, `force`, promises |
| `(scheme load)` | `load` |
| `(scheme process-context)` | `command-line`, `exit`, environment |
| `(scheme read)` | `read` |
| `(scheme repl)` | `interaction-environment` |
| `(scheme time)` | `current-second`, `current-jiffy` |
| `(scheme write)` | `display`, `write` |
| `(scheme r5rs)` | R5RS compatibility |

## Library file conventions

Library source files use the `.sld` extension and are discovered automatically.
A library named `(foo bar)` is found at `foo/bar.sld` on the library search
path.

## cond-expand

Use `cond-expand` to conditionally include code based on available features:

```scheme
(define-library (mylib compat)
  (import (scheme base))
  (cond-expand
    (bilk
      (begin (define (impl) "bilk")))
    (else
      (begin (define (impl) "other"))))
  (export impl))
```

## include

Include external source files into a library body:

```scheme
(define-library (mylib utils)
  (import (scheme base))
  (export helper)
  (include "utils-impl.scm"))
```
