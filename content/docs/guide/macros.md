+++
title = "Macros"
weight = 7
+++

Wile supports hygienic macros via `syntax-rules`. Macros transform code at
compile time without the accidental-capture bugs of traditional Lisp macros.

## define-syntax

Define a macro with `define-syntax` and `syntax-rules`:

```scheme
(define-syntax my-when
  (syntax-rules ()
    ((my-when test body ...)
     (if test (begin body ...)))))

(my-when #t
  (display "hello")
  (newline))
; prints: hello
```

The first argument to `syntax-rules` is a list of literal identifiers (often
empty). The remaining forms are pattern/template pairs.

## Pattern matching

Patterns match against the input syntax. `...` (ellipsis) matches zero or more
repetitions:

```scheme
(define-syntax my-list
  (syntax-rules ()
    ((my-list)        '())
    ((my-list x ...)  (list x ...))))

(my-list 1 2 3)  ; => (1 2 3)
```

## Multiple rules

A macro can have several patterns, tried in order:

```scheme
(define-syntax my-and
  (syntax-rules ()
    ((my-and)          #t)
    ((my-and x)        x)
    ((my-and x y ...)  (if x (my-and y ...) #f))))

(my-and 1 2 3)  ; => 3
(my-and 1 #f 3) ; => #f
```

## Literal keywords

The literals list specifies identifiers that must match literally rather than
acting as pattern variables:

```scheme
(define-syntax my-cond
  (syntax-rules (else)
    ((my-cond (else body ...))
     (begin body ...))
    ((my-cond (test body ...) clause ...)
     (if test
         (begin body ...)
         (my-cond clause ...)))))
```

Here `else` is a literal — it matches only the identifier `else`, not an
arbitrary expression.

## Hygiene

Wile's macros are hygienic: bindings introduced by a macro cannot conflict
with bindings at the use site.

```scheme
(define-syntax swap!
  (syntax-rules ()
    ((swap! a b)
     (let ((tmp a))
       (set! a b)
       (set! b tmp)))))

(define tmp 99)
(define x 1)
(define y 2)
(swap! x y)
x    ; => 2
y    ; => 1
tmp  ; => 99  (not affected — hygiene protects it)
```

The `tmp` inside the macro expansion is distinct from the `tmp` at the call
site.

## let-syntax and letrec-syntax

For macros with limited scope:

```scheme
(let-syntax
    ((double (syntax-rules ()
               ((double x) (+ x x)))))
  (double 21))  ; => 42
; double is not visible here
```

`letrec-syntax` allows the macros to reference each other.

## Common patterns

### Swap

```scheme
(define-syntax swap!
  (syntax-rules ()
    ((swap! a b)
     (let ((tmp a))
       (set! a b)
       (set! b tmp)))))
```

### While loop

```scheme
(define-syntax while
  (syntax-rules ()
    ((while test body ...)
     (let loop ()
       (when test
         body ...
         (loop))))))
```

### Assert

```scheme
(define-syntax assert
  (syntax-rules ()
    ((assert expr)
     (unless expr
       (error "assertion failed" 'expr)))))
```
