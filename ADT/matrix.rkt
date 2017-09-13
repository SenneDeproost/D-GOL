#lang r6rs

#|
Senne Deproost
MATRIX
|#

(library
 (matrix)
 (export new)
 (import
  (rnrs base)
  (rnrs control)
  (srfi :9)
  )

 (define null '())

 (define-record-type matrix
   (make w h s)
   matrix?
   (w width width?)
   (h height height?)
   (s storage storage!))

 (define (new width height)
   (define n (* width height))
   (make width height (make-vector n null)))

 (define (ref matrix colom row)
   (define x (width matrix))
   (define offset (+ (* row x) colom))
   (vector-ref (storage matrix) offset))

 (define (set! matrix colom row data)
   (define x (width matrix))
   (define offset (+ (* row x) colom))
   (vector-set! (storage matrix) offset data))
 
 )
