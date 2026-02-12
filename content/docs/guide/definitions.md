+++
title = "Definitions & Functions"
weight = 2
+++

## Variables

Bind a name with `define`:

```scheme
(define x 42)
(define greeting "hello")
(+ x 8)  ; => 50
```

Mutate an existing binding with `set!`:

```scheme
(define counter 0)
(set! counter (+ counter 1))
counter  ; => 1
```

## Functions

Functions are defined with `define` and a parameter list:

```scheme
(define (square x)
  (* x x))

(square 5)  ; => 25
```

This is shorthand for binding a `lambda`:

```scheme
(define square
  (lambda (x) (* x x)))
```

## Multiple parameters

```scheme
(define (add a b)
  (+ a b))

(add 3 4)  ; => 7
```

## Variadic functions

A dotted parameter list captures extra arguments as a list:

```scheme
(define (first-and-rest first . rest)
  (list first rest))

(first-and-rest 1 2 3 4)  ; => (1 (2 3 4))
```

A single symbol captures all arguments:

```scheme
(define (all-args . args)
  args)

(all-args 1 2 3)  ; => (1 2 3)
```

## Closures

Functions close over their environment — they capture bindings from the scope
where they were created:

```scheme
(define (make-adder n)
  (lambda (x) (+ n x)))

(define add5 (make-adder 5))
(add5 10)  ; => 15
```

## Local bindings

### let

`let` introduces parallel local bindings:

```scheme
(let ((x 1)
      (y 2))
  (+ x y))  ; => 3
```

Bindings are evaluated in parallel — `y` cannot reference `x`:

```scheme
(let ((x 1)
      (y (+ x 1)))  ; ERROR: x is not yet bound
  y)
```

### let*

`let*` evaluates bindings sequentially:

```scheme
(let* ((x 1)
       (y (+ x 1)))
  y)  ; => 2
```

### letrec

`letrec` allows mutually recursive bindings:

```scheme
(letrec ((even? (lambda (n)
                  (if (= n 0) #t (odd? (- n 1)))))
         (odd?  (lambda (n)
                  (if (= n 0) #f (even? (- n 1))))))
  (even? 10))  ; => #t
```

## Named let

A `let` with a name creates a recursive loop:

```scheme
(let loop ((i 0))
  (when (< i 5)
    (display i)
    (display " ")
    (loop (+ i 1))))
; prints: 0 1 2 3 4
```

This is the idiomatic way to write loops in Scheme.

## begin

`begin` sequences multiple expressions, returning the value of the last:

```scheme
(begin
  (display "hello")
  (newline)
  42)  ; => 42 (after printing "hello\n")
```
