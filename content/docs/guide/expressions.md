+++
title = "Expressions & Values"
weight = 1
+++

Scheme programs are made of expressions. Every expression evaluates to a value.

## Atoms

The simplest expressions are literal values — atoms:

```scheme
42            ; fixnum (integer)
3.14          ; flonum (floating-point)
#t            ; boolean true
#f            ; boolean false
"hello"       ; string
#\a           ; character
'foo          ; symbol
```

## Lists and S-expressions

Scheme code and data share the same syntax: the S-expression. A list is written
with parentheses:

```scheme
'(1 2 3)             ; a list of three numbers
'(a b c)             ; a list of three symbols
'(1 "two" #t)        ; lists can contain mixed types
'()                  ; the empty list
```

## Evaluation

An unquoted list is a function call. The first element is the operator and the
rest are arguments:

```scheme
(+ 1 2)              ; => 3
(* 3 4)              ; => 12
(string-length "hi") ; => 2
(list 1 2 3)         ; => (1 2 3)
```

Use `quote` (or the `'` shorthand) to prevent evaluation:

```scheme
(quote (+ 1 2))      ; => (+ 1 2)  — a list, not 3
'(+ 1 2)             ; same thing
```

## Nesting

Expressions nest naturally:

```scheme
(+ (* 2 3) (- 10 4))  ; => 12
(string-append "hello" " " "world")  ; => "hello world"
```

## Truthiness

In Scheme, only `#f` is false. Everything else — including `0`, `""`, and
`'()` — is true:

```scheme
(if 0 "true" "false")    ; => "true"
(if "" "true" "false")   ; => "true"
(if '() "true" "false")  ; => "true"
(if #f "true" "false")   ; => "false"
```

## Type predicates

Every type has a predicate that tests membership:

```scheme
(number? 42)       ; => #t
(string? "hi")     ; => #t
(boolean? #f)      ; => #t
(symbol? 'foo)     ; => #t
(char? #\a)        ; => #t
(pair? '(1 2))     ; => #t
(null? '())        ; => #t
(procedure? +)     ; => #t
```

## Equality

Scheme has three equality predicates with different semantics:

```scheme
(eq? 'a 'a)               ; => #t  (identity — same object)
(eqv? 42 42)              ; => #t  (equivalence — same value for simple types)
(equal? '(1 2) '(1 2))    ; => #t  (structural — deep comparison)
```

Use `equal?` when in doubt. Use `eq?` or `eqv?` when you need to distinguish
identity from structural equality.
