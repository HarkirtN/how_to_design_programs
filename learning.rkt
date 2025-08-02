;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname learning) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp")) #f)))
(define (area-of-disc r)
(* 3.14 (* r r)))

(define (area-of-ring outer inner) (- (area-of-disc outer) (area-of-disc inner)))

(define (celsius farenheit) ( * (- farenheit 32) 0.56))

(define (f n) (+ (* n n) 10))

(define (wage h) (* 12 h))

(define (tax grosspay) (* grosspay 0.85))
  
(define (netpay hours) (tax (wage hours)))

(define (sum-of-coins p n d q) (/ (+ (* 1 p) (* 5 n) (* 10 d) (* 25 q)) 100))

