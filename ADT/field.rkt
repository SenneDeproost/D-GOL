#lang r6rs

#|
Senne Deproost
FIELD
|#

(library
 (field)
 (export new ref set! borders width height)
 (import
  (rnrs base)
  (rnrs control)
  (srfi :9)
  (only (racket base) null do)
  (prefix (ADT matrix) matrix:)
  )

 (define-record-type field
   (make w h s)
   matrix?
   (w width width?)
   (h height height?)
   (s storage storage!))

 (define (new width height)
   (make width height (matrix:new width height)))

 (define (ref field colom row)
   (matrix:ref (storage field) colom row))

 (define (set! field colom row data)
   (matrix:set! (storage field) colom row data))

 (define (borders field)
   (define w (width field))
   (define h (height field))
   (define matrix (storage field))

   (define top    (cons 'top    (make-vector w null)))
   (define bottom (cons 'bottom (make-vector w null)))
   (define left   (cons 'left   (make-vector h null)))
   (define right  (cons 'right  (make-vector h null)))

   (let horizontal
     ((x 0))
     (unless (= x w)
       (vector-set! (cdr top)    x  (matrix:ref matrix x 0))
       (vector-set! (cdr bottom) x  (matrix:ref matrix x (- h 1)))
       (horizontal (+ x 1))))

   (let vertical
     ((y 0))
     (unless (= y h)
       (vector-set! (cdr left)   y (matrix:ref matrix 0       y))
       (vector-set! (cdr right)  y (matrix:ref matrix (- w 1) y))
       (vertical (+ y 1))))


   (list top right bottom left))





 )
