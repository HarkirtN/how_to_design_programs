;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname practice#9) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp")) #f)))
;; continuation
;; Exercise 11.4.3
(define (product-from-minus-11 n) (cond
                                    [(= n -11) 1]
                                    [else (* n (product-from-minus-11 (sub1 n)))]))

;;add into tabulate function ???????
(define (f x)(+
              (* 3 (* x x))
                (+ (* -6 x) -1)))

;;auxillary function first
(define (from-20 n) (cond
                      [(= n 20) 1]
                      [else (* n (from-20 (sub1 n)))]))

;; add
(define (tabulate-f20 n) (cond
                           [(zero? n) empty]
                           [else (cons (make-posn n (f (from-20 n))) (tabulate-f20 (sub1 n)))]))

;;test
(tabulate-f20 21)