;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |scheme grammar|) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp")) #f)))
;; Exercise 7.5.1

;; scheme-value -> number, v is a number
(define (area-of-disk v) (* pi ( sqr v)))
(define (checked-area-of-disk v) (cond
                                   [(number? v) ( and (>= v 0) (area-of-disk v))]
                                   [else (error 'checked-area-of-disk "number expected")]))
;;vector :structure -> number
(define-struct vec (x y))
(define (checked-make-vec s) (cond
                               [(number? s) (>= s 0)]
                               [else (error 'checked-make-vec "number expected")]))

;; variable definitions
(define monkeys 4)
(define zoo (* 3 monkeys))
(define hours 30)
(define pay (+ 12 hours))
(define distance-of-moon (* pi (* monkeys zoo )))