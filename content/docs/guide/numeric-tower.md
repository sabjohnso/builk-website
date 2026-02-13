+++
title = "Numeric Tower"
weight = 4
+++

Wile Scheme implements the full R7RS numeric tower. Numbers are automatically promoted
to wider types as needed.

## The five numeric types

From narrowest to widest:

| Type | Description | Examples |
|------|-------------|----------|
| Fixnum | Machine-word integers | `0`, `42`, `-7` |
| Bignum | Arbitrary-precision integers (GMP) | `(expt 2 100)` |
| Rational | Exact fractions | `1/3`, `22/7` |
| Flonum | IEEE 754 double-precision | `3.14`, `1e10` |
| Complex | Real + imaginary | `3+4i`, `0+1i` |

## Automatic promotion

When an operation mixes numeric types, the result is promoted to the wider
type:

```scheme
(+ 1 1/2)            ; => 3/2      (fixnum + rational → rational)
(+ 1 2.0)            ; => 3.0      (fixnum + flonum → flonum)
(+ 1 1+2i)           ; => 2+2i     (fixnum + complex → complex)
(* 1/2 3)            ; => 3/2      (rational × fixnum → rational)
(+ 1/2 0.5)          ; => 1.0      (rational + flonum → flonum)
```

## Exact vs. inexact

Fixnums, bignums, and rationals are exact. Flonums are inexact. Complex numbers
can be either, depending on their components.

```scheme
(exact? 1/3)              ; => #t
(inexact? 3.14)           ; => #t
(exact->inexact 1/3)      ; => 0.3333333333333333
(inexact->exact 0.5)      ; => 1/2
```

Integer division produces exact rationals, not truncated integers:

```scheme
(/ 1 3)    ; => 1/3  (not 0 or 0.333...)
(/ 22 7)   ; => 22/7
```

## Rational arithmetic

Rationals are always in lowest terms:

```scheme
(+ 1/2 1/3)    ; => 5/6
(- 1/2 1/3)    ; => 1/6
(* 2/3 3/4)    ; => 1/2
(/ 3/4 2/3)    ; => 9/8
(numerator 5/6)    ; => 5
(denominator 5/6)  ; => 6
```

## Complex numbers

Complex numbers are written as `a+bi`:

```scheme
3+4i                ; complex literal
(make-rectangular 3 4)  ; same thing
(+ 1+2i 3+4i)      ; => 4+6i
(* 0+1i 0+1i)      ; => -1   (i² = -1)
(magnitude 3+4i)    ; => 5.0
(angle 0+1i)        ; => 1.5707963267948966
(real-part 3+4i)    ; => 3
(imag-part 3+4i)    ; => 4
```

## Arbitrary precision

Bignums grow without overflow:

```scheme
(expt 2 100)
; => 1267650600228229401496703205376

(+ (expt 10 50) 1)
; => 100000000000000000000000000000000000000000000000000001
```

When a bignum fits in a machine word, it is automatically stored as a fixnum.

## Numeric predicates

```scheme
(number? 42)        ; => #t
(integer? 1)        ; => #t
(rational? 1/3)     ; => #t
(real? 3.14)        ; => #t
(complex? 1+2i)     ; => #t
(exact? 1/3)        ; => #t
(inexact? 1.0)      ; => #t
(zero? 0)           ; => #t
(positive? 5)       ; => #t
(negative? -3)      ; => #t
(finite? 1.0)       ; => #t
(infinite? +inf.0)  ; => #t
(nan? +nan.0)       ; => #t
```

## Math functions

```scheme
(abs -5)           ; => 5
(min 3 1 4)        ; => 1
(max 3 1 4)        ; => 4
(gcd 12 8)         ; => 4
(lcm 4 6)          ; => 12
(floor 3.7)        ; => 3.0
(ceiling 3.2)      ; => 4.0
(round 3.5)        ; => 4.0
(truncate 3.7)     ; => 3.0
(sqrt 16)          ; => 4
(expt 2 10)        ; => 1024
```

Trigonometric and transcendental functions:

```scheme
(sin 0)    ; => 0
(cos 0)    ; => 1
(exp 1)    ; => 2.718281828459045
(log 1)    ; => 0
(atan 1 1) ; => 0.7853981633974483
```
