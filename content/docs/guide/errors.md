+++
title = "Error Handling"
weight = 11
+++

Wile provides R7RS exception handling with `guard`, `raise`, and error objects.

## Raising errors

Use `error` to signal an error with a message and optional irritant values:

```scheme
(error "division by zero")
(error "index out of range" 'vector-ref 10)
```

Use `raise` to throw any value as an exception:

```scheme
(raise "something went wrong")
(raise (list 'my-error 42))
```

## guard

`guard` catches exceptions with `cond`-like clauses:

```scheme
(guard (exn
        ((string? exn) (string-append "caught: " exn))
        ((error-object? exn) (error-object-message exn)))
  (error "file not found" "data.txt"))
; => "file not found"
```

The variable `exn` is bound to the raised value. Each clause tests a condition;
the first matching clause handles the exception. If no clause matches, the
exception is re-raised.

## Error objects

`error` creates structured error objects with a message and irritants:

```scheme
(guard (exn
        ((error-object? exn)
         (list (error-object-message exn)
               (error-object-irritants exn))))
  (error "bad value" 42 "expected positive"))
; => ("bad value" (42 "expected positive"))
```

Error object predicates:

```scheme
(error-object? exn)       ; is it an error object?
(error-object-message exn)    ; the message string
(error-object-irritants exn)  ; list of extra values
(file-error? exn)         ; was it a file-related error?
(read-error? exn)         ; was it a read/parse error?
```

## Guarding specific errors

```scheme
(define (safe-divide a b)
  (guard (exn
          ((error-object? exn) #f))
    (/ a b)))

(safe-divide 10 3)  ; => 10/3
(safe-divide 10 0)  ; => #f
```

## Cleanup with dynamic-wind

Combine `guard` with `dynamic-wind` to ensure resources are released:

```scheme
(define (with-file filename proc)
  (let ((port (open-input-file filename)))
    (dynamic-wind
      (lambda () #f)
      (lambda () (proc port))
      (lambda () (close-input-port port)))))

(guard (exn
        ((file-error? exn) "file error"))
  (with-file "data.txt"
    (lambda (port)
      (read-line port))))
```

## Re-raising

If no clause matches in `guard`, the exception propagates to the next handler.
You can also explicitly re-raise:

```scheme
(guard (exn
        ((file-error? exn)
         (display "file error handled\n"))
        (else (raise exn)))  ; re-raise anything else
  (error "not a file error"))
; raises "not a file error" to the outer handler
```
