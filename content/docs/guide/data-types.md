+++
title = "Data Types"
weight = 3
+++

Wile supports all R7RS data types plus extensions from bundled SRFIs.

## Pairs and lists

A pair holds two values — `car` and `cdr`:

```scheme
(cons 1 2)        ; => (1 . 2)
(car (cons 1 2))  ; => 1
(cdr (cons 1 2))  ; => 2
```

A proper list is a chain of pairs ending in `'()`:

```scheme
(list 1 2 3)                ; => (1 2 3)
(cons 1 (cons 2 (cons 3 '())))  ; same thing
```

Common list operations:

```scheme
(car '(a b c))          ; => a
(cdr '(a b c))          ; => (b c)
(length '(1 2 3))       ; => 3
(append '(1 2) '(3 4))  ; => (1 2 3 4)
(reverse '(1 2 3))      ; => (3 2 1)
(list-ref '(a b c) 1)   ; => b
```

## Vectors

Vectors are fixed-size, mutable, indexed arrays:

```scheme
(vector 1 2 3)            ; => #(1 2 3)
(make-vector 5 0)         ; => #(0 0 0 0 0)
(vector-ref #(a b c) 1)   ; => b
(vector-length #(1 2 3))  ; => 3
```

```scheme
(define v (vector 10 20 30))
(vector-set! v 1 99)
v  ; => #(10 99 30)
```

## Strings

Strings are mutable sequences of characters:

```scheme
(string-length "hello")             ; => 5
(string-ref "hello" 0)             ; => #\h
(substring "hello world" 6 11)     ; => "world"
(string-append "foo" "bar")        ; => "foobar"
(string-upcase "hello")            ; => "HELLO"
(string->list "abc")               ; => (#\a #\b #\c)
(list->string '(#\h #\i))          ; => "hi"
```

## Characters

Characters represent Unicode code points:

```scheme
#\a                   ; lowercase a
#\space               ; space character
#\newline             ; newline
(char->integer #\A)   ; => 65
(integer->char 955)   ; => #\λ
(char-alphabetic? #\a)  ; => #t
(char-upcase #\a)     ; => #\A
```

## Bytevectors

Bytevectors hold raw bytes (unsigned 8-bit integers):

```scheme
(bytevector 1 2 3)               ; => #u8(1 2 3)
(make-bytevector 4 0)            ; => #u8(0 0 0 0)
(bytevector-u8-ref #u8(10 20) 1) ; => 20
(bytevector-length #u8(1 2 3))   ; => 3
```

## Hash tables

Hash tables provide key-value lookup (from SRFI 69):

```scheme
(import (srfi 69))

(define ht (make-hash-table))
(hash-table-set! ht 'name "wile")
(hash-table-set! ht 'version 1)
(hash-table-ref ht 'name)     ; => "wile"
(hash-table-exists? ht 'name) ; => #t
(hash-table-keys ht)          ; => (name version)
```

## Character sets

Character sets represent collections of characters (from SRFI 14):

```scheme
(import (srfi 14))

(char-set-contains? char-set:letter #\a)  ; => #t
(char-set-contains? char-set:digit #\5)   ; => #t
```

## Booleans

```scheme
#t        ; true
#f        ; false
(not #t)  ; => #f
(not #f)  ; => #t
(not 0)   ; => #f  (0 is truthy in Scheme)
```

## Symbols

Symbols are interned identifiers, often used as keys:

```scheme
(symbol? 'hello)           ; => #t
(symbol->string 'hello)    ; => "hello"
(string->symbol "world")   ; => world
(eq? 'foo 'foo)            ; => #t  (same object)
```

## The empty list and void

```scheme
(null? '())    ; => #t
(list? '())    ; => #t
```

`void` is the return value of side-effecting forms like `define`, `set!`, and
`display`. It is not printed in the REPL.
