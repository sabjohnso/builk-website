+++
title = "SRFI Reference"
weight = 4
+++

Wile Scheme bundles 36 SRFIs (Scheme Requests for Implementation). Import them with
`(import (srfi N))`.

## Built-in SRFIs

These SRFIs are implemented as native primitives for performance:

| SRFI | Title | Import |
|------|-------|--------|
| [1](https://srfi.schemers.org/srfi-1/) | List Library | `(import (srfi 1))` |
| [13](https://srfi.schemers.org/srfi-13/) | String Libraries | `(import (srfi 13))` |
| [14](https://srfi.schemers.org/srfi-14/) | Character-set Library | `(import (srfi 14))` |
| [69](https://srfi.schemers.org/srfi-69/) | Basic Hash Tables | `(import (srfi 69))` |
| [115](https://srfi.schemers.org/srfi-115/) | Scheme Regular Expressions | `(import (srfi 115))` |
| [151](https://srfi.schemers.org/srfi-151/) | Bitwise Operations | `(import (srfi 151))` |

## Library SRFIs

These SRFIs are implemented in Scheme and loaded from `.sld` files:

| SRFI | Title | Import |
|------|-------|--------|
| [2](https://srfi.schemers.org/srfi-2/) | AND-LET\*: an AND with local bindings | `(import (srfi 2))` |
| [8](https://srfi.schemers.org/srfi-8/) | receive: Binding to formals of values | `(import (srfi 8))` |
| [11](https://srfi.schemers.org/srfi-11/) | Syntax for receiving multiple values | `(import (srfi 11))` |
| [16](https://srfi.schemers.org/srfi-16/) | Syntax for procedures of variable arity | `(import (srfi 16))` |
| [26](https://srfi.schemers.org/srfi-26/) | Notation for specializing parameters | `(import (srfi 26))` |
| [28](https://srfi.schemers.org/srfi-28/) | Basic format strings | `(import (srfi 28))` |
| [31](https://srfi.schemers.org/srfi-31/) | A special form rec for recursive evaluation | `(import (srfi 31))` |
| [41](https://srfi.schemers.org/srfi-41/) | Streams | `(import (srfi 41))` |
| [48](https://srfi.schemers.org/srfi-48/) | Intermediate format strings | `(import (srfi 48))` |
| [111](https://srfi.schemers.org/srfi-111/) | Boxes | `(import (srfi 111))` |
| [113](https://srfi.schemers.org/srfi-113/) | Sets and Bags | `(import (srfi 113))` |
| [117](https://srfi.schemers.org/srfi-117/) | Queues based on lists | `(import (srfi 117))` |
| [125](https://srfi.schemers.org/srfi-125/) | Intermediate hash tables | `(import (srfi 125))` |
| [128](https://srfi.schemers.org/srfi-128/) | Comparators | `(import (srfi 128))` |
| [132](https://srfi.schemers.org/srfi-132/) | Sort Libraries | `(import (srfi 132))` |
| [133](https://srfi.schemers.org/srfi-133/) | Vector Library (R7RS-compatible) | `(import (srfi 133))` |
| [145](https://srfi.schemers.org/srfi-145/) | Assumptions | `(import (srfi 145))` |
| [156](https://srfi.schemers.org/srfi-156/) | Syntactic combiners for binary predicates | `(import (srfi 156))` |
| [158](https://srfi.schemers.org/srfi-158/) | Generators and Accumulators | `(import (srfi 158))` |
| [162](https://srfi.schemers.org/srfi-162/) | Comparators sublibrary | `(import (srfi 162))` |
| [175](https://srfi.schemers.org/srfi-175/) | ASCII character library | `(import (srfi 175))` |
| [189](https://srfi.schemers.org/srfi-189/) | Maybe and Either | `(import (srfi 189))` |
| [195](https://srfi.schemers.org/srfi-195/) | Multiple-value boxes | `(import (srfi 195))` |
| [210](https://srfi.schemers.org/srfi-210/) | Procedures and syntax for multiple values | `(import (srfi 210))` |
| [214](https://srfi.schemers.org/srfi-214/) | Flexvectors | `(import (srfi 214))` |
| [219](https://srfi.schemers.org/srfi-219/) | Define higher-order lambda | `(import (srfi 219))` |
| [223](https://srfi.schemers.org/srfi-223/) | Generalized binary search procedures | `(import (srfi 223))` |
| [228](https://srfi.schemers.org/srfi-228/) | Composing comparators | `(import (srfi 228))` |
| [234](https://srfi.schemers.org/srfi-234/) | Topological sorting | `(import (srfi 234))` |
| [235](https://srfi.schemers.org/srfi-235/) | Combinators | `(import (srfi 235))` |

## Usage example

```scheme
(import (srfi 1)    ; list library
        (srfi 13)   ; string library
        (srfi 69))  ; hash tables

;; SRFI 1: list operations
(iota 5)                    ; => (0 1 2 3 4)
(zip '(a b c) '(1 2 3))    ; => ((a 1) (b 2) (c 3))
(partition even? '(1 2 3 4 5))  ; => (2 4) (1 3 5)

;; SRFI 13: string operations
(string-join '("hello" "world") " ")  ; => "hello world"
(string-contains "hello world" "world")  ; => 6
(string-trim-both "  hello  ")  ; => "hello"

;; SRFI 69: hash tables
(define ht (make-hash-table))
(hash-table-set! ht 'x 42)
(hash-table-ref ht 'x)  ; => 42
```
