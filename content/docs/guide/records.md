+++
title = "Records"
weight = 6
+++

Records let you define new data types with named fields.

## define-record-type

```scheme
(define-record-type <point>
  (make-point x y)
  point?
  (x point-x)
  (y point-y))
```

This defines:
- `make-point` — constructor
- `point?` — type predicate
- `point-x`, `point-y` — field accessors

```scheme
(define p (make-point 3 4))
(point? p)    ; => #t
(point-x p)   ; => 3
(point-y p)   ; => 4
```

## Mutable fields

Add a mutator by including a third element in the field spec:

```scheme
(define-record-type <counter>
  (make-counter value)
  counter?
  (value counter-value set-counter-value!))

(define c (make-counter 0))
(set-counter-value! c 42)
(counter-value c)  ; => 42
```

Fields without a mutator are immutable.

## Partial constructors

The constructor only needs to list the fields it initializes. Other fields
can be set via mutators:

```scheme
(define-record-type <person>
  (make-person name)
  person?
  (name person-name)
  (age person-age set-person-age!))
```

## Example: binary tree

```scheme
(define-record-type <tree>
  (make-tree value left right)
  tree?
  (value tree-value)
  (left  tree-left)
  (right tree-right))

(define (tree-member? x t)
  (cond
    ((not (tree? t)) #f)
    ((= x (tree-value t)) #t)
    ((< x (tree-value t)) (tree-member? x (tree-left t)))
    (else (tree-member? x (tree-right t)))))

(define t
  (make-tree 5
    (make-tree 3 #f #f)
    (make-tree 7 #f #f)))

(tree-member? 3 t)  ; => #t
(tree-member? 6 t)  ; => #f
```
