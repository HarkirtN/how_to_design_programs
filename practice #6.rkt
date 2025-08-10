;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |practice #6|) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp")) #f)))
;;Exercise 6

;;(define posn-y (make-posn ...))
;; define _no bracket_variable ( function arguments)

;; pixells give x, y posn = two values  operation is "make posn" then give values
 ;; posn-x extracts x coordinate & posn-y extracts y
 ;; geometry squrt ( + (expt x 2) (expt y 2)) is how we calculate distance 
   ;;(define (distance-to-0 a-posn) ...)

;; distance-to-0 : posn -> number
  ;; we need x and y coordinate
  ;;(posn-x a-posn) ;; to find x
  ;;(posn-y a-posn) ;; to find y
;;(posn-x a-posn) = 7
;;(posn-y a-posn) = 0

;;(define (posn-x posn) ...)
;; (define ( function (what is it going to do) argument (what does it need)) ... output (what is it going to give you). 
;;(define (posn-y posn) ...)
;;(define (make-posn x y))

;;(define a-posn (make-posn ...))
;; define _no bracket_variable ( function arguments)


;; add this to the equation
 ;;(define (distance-to-0 a-posn) ( sqrt (+ (sqr (posn-x a-posn) (squr (posn-y a-posn))))))
(define (distance-to-0 a-posn)
  (sqrt
   (+ (sqr (posn-x a-posn))
      (sqr (posn-y a-posn)))))

(define a-pos (make-posn 4 4))

(define x (posn-x a-pos))

(distance-to-0 a-pos)

(define-struct pos (x y))

(define b-pos (make-pos 2 2))
b-pos
(pos-x b-pos)
(pos-y b-pos)

(define-struct sandwich (bread cheese meat))
(define u 0)

(make-sandwich 'SOURDOUGH 'BREE 'HAM)
(sandwich-cheese (make-sandwich 'SOURDOUGH 'BREE 'HAM))
(make-pos 2 2)


