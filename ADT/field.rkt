#lang r6rs

#|
Senne Deproost
FIELD
|#

(library
 (field)
 (export new)
 (import
  (rnrs base)
  (rnrs control)
  (srfi :9)
  (only (racket base) null)
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

 )
