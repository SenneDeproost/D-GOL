#lang racket

(require data/spmatrix)

(provide mk-field-ADT)

(define (mk-field-ADT width height)

(define field
  (build-matrix width height (lambda (a b) (random 0 2)))
  )

(define (for-each-entry f)
(matrix-fold
  field
  (lambda (a b) void)
  (lambda (a b c d) (f a b c d))
  '()
  )
)

(define (count-neighbors x y)
  (define n 0)
  (define (inc!) (set! n (+ n 1)))

  (define (neighbor? x y)
    (= (matrix-ref field x y) 1))

  (define (count x y)
    (when
        (and (not (< x 0))
             (not (< y 0))
             (not (>= x 5))
             (not (>= y 5)))
      (when (neighbor? x y) (inc!))))

  (count (- x 1) (- y 1))
  (count    x    (- y 1))
  (count (+ x 1) (- y 1))
  (count (- x 1)    y   )
  (count (+ x 1)    y   )
  (count (- x 1) (+ y 1))
  (count    x    (+ y 1))
  (count (+ x 1) (+ y 1))

  n

  )

(define (alive! x y)
(matrix-set! field x y 1))

(define (dead! x y)
(matrix-set! field x y 0))



(define (execute-rules! x y)
(define alive? (= (matrix-ref field x y) 1))
(define n (count-neighbors x y))
(cond ((and alive? #t)
(cond
  ((< n 2)
    (dead! x y))
  ((or (= n 2) (= n 3))
    (void))
  ((> n 3)
    (dead! x y))
  ))
(else
  (when (= n 3)
    (alive! x y)
  ))))


(define (step!)
(for-each-entry (lambda (a b c d) (execute-rules! a b)))
)

(define (dispatch msg)
(cond
  ((eq? msg 'step!) (step!))
  ((eq? msg 'display-field) (display-matrix field))
  (else
    (error msg " is an ilegal message to field-ADT.")
    )
  )
)

dispatch
)
