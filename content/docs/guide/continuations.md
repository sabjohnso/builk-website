+++
title = "Continuations"
weight = 9
+++

Wile supports first-class continuations via stack-copying `call/cc`.

## call/cc

`call-with-current-continuation` (abbreviated `call/cc`) captures the current
point of execution as a procedure. Calling that procedure jumps back to the
captured point:

```scheme
(call/cc
  (lambda (k)
    (k 42)))
; => 42
```

The continuation `k` represents "what would have happened next." Calling
`(k 42)` abandons the current computation and returns `42` to the caller of
`call/cc`.

## Non-local exit

A common use is early return from a computation:

```scheme
(define (find-first pred lst)
  (call/cc
    (lambda (return)
      (for-each
        (lambda (x)
          (when (pred x) (return x)))
        lst)
      #f)))

(find-first even? '(1 3 5 4 7))  ; => 4
(find-first even? '(1 3 5 7))    ; => #f
```

## Multiple values

`call-with-values` passes multiple return values between procedures:

```scheme
(call-with-values
  (lambda () (values 1 2 3))
  (lambda (a b c) (+ a b c)))
; => 6
```

Use `values` to return multiple values and `call-with-values` to receive them.

## dynamic-wind

`dynamic-wind` ensures that setup and cleanup code runs even when control flow
is disrupted by continuations:

```scheme
(dynamic-wind
  (lambda () (display "enter\n"))
  (lambda () (display "body\n") 42)
  (lambda () (display "exit\n")))
; prints:
;   enter
;   body
;   exit
; => 42
```

The three arguments are:
- **before** — called on entry (including re-entry via continuation)
- **thunk** — the main computation
- **after** — called on exit (including escape via continuation)

## Example: exception-like behavior

Before Scheme had `guard`, `call/cc` was used for exception handling:

```scheme
(define (divide a b)
  (call/cc
    (lambda (escape)
      (when (zero? b)
        (escape "division by zero"))
      (/ a b))))

(divide 10 3)  ; => 10/3
(divide 10 0)  ; => "division by zero"
```

For real error handling, use [`guard`]({{< relref "errors" >}}) instead.
