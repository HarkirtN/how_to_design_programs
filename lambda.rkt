;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname lambda) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp") (lib "gui.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp") (lib "gui.rkt" "teachpack" "htdp")) #f)))
;;lambda
;; is a shorthand for local expressions
;;i.e. (local ((define (a-new-name x ...) expression))
        ;; a-new-name)

;; = (lambda (x ...) expression)

(define-struct ir (name price))
(define (filter1 rel-op list TH) (cond
                                   [(empty? list) empty]
                                   [(rel-op (first list) TH) (cons (first list) (filter1 rel-op (rest list) TH))]
                                   [else (filter1 rel-op (rest list) TH)]))

(filter1 (lambda (ir p) (< (ir-price ir) p))
                        (list (make-ir 'doll 10)) 8)

;; = (filter1 (local ((define (<ir ir p) (< (it-price ir) p)))
              ;;  <ir) (list (make-ir 'doll 10)) 8)

;;in other words lambda is just like defining a function - but used only once and not for recursive
;;functions within i.e. conditional statements

(lambda (x y) (x y y))
;; (lambda  () 10) it requires a variable given empty
(lambda (x) x)
(lambda (x y) x)
;;(lambda x 10) requires a variable and then expression
;;NOTE as long as there is a variable variable then expression it is legal

;;exercise 1
((lambda (x y) (+ x (* x y)))
 1 2) ;; so x is assigned to 1 and y assigned to 2 =  3

;;exercise 2
((lambda (x y) (+ x (local ((define x (* y y)))
                      (+ 3 (* 3 x) (/ 1 x)))))
 1 2) ;; = 16.25

;;exercise 3
((lambda (x y) ( + x ((lambda (x) (+ (* 3 x) (/ 1 x)))
                      (* y y))))
 1 2) ;; = trick is that it places (* y y) into x so essentially carry out
      ;; x = (* y y) -> x = 4, then carry out the equation for x = 13.25

