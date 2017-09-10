#lang racket

(require "ADT/field-ADT.rkt")

(define game (mk-field-ADT 20 20))

(game 'step!)

(game 'display-field)
