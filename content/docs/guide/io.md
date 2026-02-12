+++
title = "I/O & Ports"
weight = 10
+++

Wile uses the R7RS port model for input and output. Ports represent streams of
characters or bytes.

## Standard ports

Three ports are open by default:

```scheme
(current-input-port)   ; stdin
(current-output-port)  ; stdout
(current-error-port)   ; stderr
```

## Output

```scheme
(display "hello")        ; write in human-readable form
(write "hello")          ; write in Scheme notation: "hello"
(newline)                ; write a newline
(write-char #\a)         ; write a single character
(write-string "hello")   ; write a string
```

`display` omits quotes on strings and backslashes on characters.
`write` produces output that `read` can parse back.

## Input

```scheme
(read-char)       ; read one character (or eof-object)
(peek-char)       ; look ahead without consuming
(read-line)       ; read until newline
(read-string 5)   ; read exactly 5 characters
(read)            ; read a Scheme datum
(char-ready?)     ; check if input is available
```

## File I/O

Open files explicitly:

```scheme
(define in (open-input-file "data.txt"))
(define line (read-line in))
(close-input-port in)

(define out (open-output-file "output.txt"))
(display "hello" out)
(close-output-port out)
```

Or use the convenience wrappers that handle closing automatically:

```scheme
(call-with-input-file "data.txt"
  (lambda (port)
    (read-line port)))

(call-with-output-file "output.txt"
  (lambda (port)
    (display "hello" port)))
```

## Redirecting standard ports

Temporarily rebind the current input or output port:

```scheme
(with-input-from-file "data.txt"
  (lambda ()
    (read-line)))  ; reads from data.txt

(with-output-to-file "output.txt"
  (lambda ()
    (display "hello")))  ; writes to output.txt
```

## String ports

Read from or write to in-memory strings:

```scheme
(define in (open-input-string "(+ 1 2)"))
(read in)  ; => (+ 1 2)

(define out (open-output-string))
(display 42 out)
(display " hello" out)
(get-output-string out)  ; => "42 hello"
```

## Binary I/O

Read and write raw bytes with bytevector ports:

```scheme
(read-u8)                    ; read one byte
(peek-u8)                    ; look ahead one byte
(write-u8 65)                ; write byte 65 (ASCII 'A')
(read-bytevector 10 port)    ; read 10 bytes
(write-bytevector bv port)   ; write bytevector
```

## End of file

All read operations return an EOF object when the input is exhausted:

```scheme
(let ((ch (read-char port)))
  (if (eof-object? ch)
      (display "done")
      (begin
        (write-char ch)
        (loop))))
```

## Flushing

Output may be buffered. Force it to the underlying stream with:

```scheme
(flush-output-port)
(flush-output-port (current-error-port))
```

## Reading all lines

A common pattern for processing a file line by line:

```scheme
(call-with-input-file "data.txt"
  (lambda (port)
    (let loop ((line (read-line port)))
      (unless (eof-object? line)
        (display line)
        (newline)
        (loop (read-line port))))))
```
