+++
title = "Control Flow"
weight = 5
+++

## Conditionals

### if

The basic conditional — evaluates one of two branches:

```scheme
(if (> 3 2) "yes" "no")  ; => "yes"
(if #f "yes" "no")        ; => "no"
```

The else branch is optional:

```scheme
(if (> 3 2) (display "yes"))  ; prints "yes"
```

### cond

`cond` tests multiple conditions in order:

```scheme
(define (classify n)
  (cond
    ((negative? n) "negative")
    ((zero? n)     "zero")
    ((positive? n) "positive")))

(classify -5)  ; => "negative"
(classify 0)   ; => "zero"
```

The `=>` arrow syntax passes the test result to a procedure:

```scheme
(cond
  ((assv 'b '((a 1) (b 2) (c 3))) => cdr)
  (else #f))
; => 2
```

### case

`case` compares a key against literal values using `eqv?`:

```scheme
(define (day-type day)
  (case day
    ((monday tuesday wednesday thursday friday) "weekday")
    ((saturday sunday) "weekend")
    (else "unknown")))

(day-type 'saturday)  ; => "weekend"
```

### when and unless

`when` executes a body only if the test is true:

```scheme
(when (> 3 2)
  (display "yes")
  (newline))
```

`unless` is the negation:

```scheme
(unless (= x 0)
  (display (/ 1 x)))
```

## Logical operators

`and` and `or` short-circuit and return the deciding value:

```scheme
(and 1 2 3)      ; => 3
(and 1 #f 3)     ; => #f
(or #f #f 3)     ; => 3
(or 1 2 3)       ; => 1
```

## Recursion

Recursion is the primary way to express iteration in Scheme:

```scheme
(define (factorial n)
  (if (<= n 1)
      1
      (* n (factorial (- n 1)))))

(factorial 10)  ; => 3628800
```

## Tail calls

Wile guarantees tail-call optimization. A call in tail position reuses the
current stack frame, allowing unbounded recursion:

```scheme
(define (factorial n)
  (let loop ((i n) (acc 1))
    (if (<= i 1)
        acc
        (loop (- i 1) (* acc i)))))

(factorial 100000)  ; works — no stack overflow
```

## Named let loops

Named `let` is the idiomatic looping construct:

```scheme
(let loop ((i 0) (sum 0))
  (if (> i 100)
      sum
      (loop (+ i 1) (+ sum i))))
; => 5050
```

## do

`do` provides an explicit loop with initialization, step, and termination:

```scheme
(do ((i 0 (+ i 1))
     (sum 0 (+ sum i)))
    ((> i 100) sum))
; => 5050
```

Each variable has an init value and a step expression. The loop terminates
when the test evaluates to true, returning the result expression.

## Higher-order iteration

`map`, `for-each`, and `filter` (from SRFI 1) apply a function to each
element:

```scheme
(map square '(1 2 3 4 5))
; => (1 4 9 16 25)

(for-each display '(1 2 3))
; prints: 123

(import (srfi 1))
(filter odd? '(1 2 3 4 5))
; => (1 3 5)
```

## apply

`apply` calls a function with arguments from a list:

```scheme
(apply + '(1 2 3 4 5))  ; => 15
(apply max '(3 1 4 1 5)) ; => 5
```
