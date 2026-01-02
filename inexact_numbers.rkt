;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname inexact_numbers) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp") (lib "gui.rkt" "teachpack" "htdp") (lib "graphing.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp") (lib "gui.rkt" "teachpack" "htdp") (lib "graphing.rkt" "teachpack" "htdp")) #f)))
;;inexact numbers
;; mantissa is a base number
;; exponent determines the power of 10 factor
;; usually the numbers will be expressed m x 10^x i.e 1200 is 12 x 10^2
;; this is a way to represent numbers with four digits between 0 to 9999

(define-struct inex (mantissa sign exponent))

;; create-inex : N N N -> inex
;; to create an inex after checkin it meets criteria
(define (create-inex m s e) (cond
                              [(and (<= 0 m 99) (<= 0 e 99) (or (= s +1) (= s -1))) (make-inex m s e)]
                              [else (error 'make-inex "(<= 0 m 99), +1 or -1 or (<= 0 e 99) expected")]))

;;inex-to-num : inex -> number
;; to convert the inex into numerical equivalent
(define (inex-to-num an-inex) (* (inex-mantissa an-inex) (expt 10 (* (inex-sign an-inex) (inex-exponent an-inex)))))

;; 1200 turned into scheme expression (create-inex 12 +1 2)
;; keeping in mind (create-inex 120 +1 1) is illegal because 120 is above 99 - so would send an error message

(create-inex 50 -1 20)
(create-inex 5 -1 19)

;;test
(inex-to-num (make-inex 50 -1 20)) ;; 0.0000000000000000005
( = (inex-to-num (make-inex 50 -1 20)) (inex-to-num (make-inex 5 -1 19))) ;; true

(define MIN-POSITIVE (make-inex 1 -1 99))
(define MAX-POSITIVE (make-inex 99 +1 99))

;; some inex have gaps between the representation such as (create-inex 12 +1 2) 1200 AND (create-inex 13 +1 2) 1300 there is no room for inbetweens
;; therefore the numbers like 1201 to 1299 will be rounded up or down


;; arthimatics
;; addition if the value is above the mantissa limit we set ours to 99 then you divide mantissa by 10 and add 1 to the exponent
;; i.e (55 x 10^0) + (55 x 10^0) = 110, but we cant do (create 11 +1 0) given the parameters
;; instead (create-inex 11 +1 1)

