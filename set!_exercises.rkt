;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname set!_exercises) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp") (lib "gui.rkt" "teachpack" "htdp") (lib "graphing.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp") (lib "gui.rkt" "teachpack" "htdp") (lib "graphing.rkt" "teachpack" "htdp")) #f)))
;;using memory
;; functions can be complex in that they require the program to remember values to function
;; i.e. address book GUI that adds or changes value of phone number 
;; or hangman game needs to have recognises the number of incorrect entries to then determine win or loss of game

;;using set! also known as assignment
;;(set! var exp)
;; has an effect on the evaluation where it replaces all values of var with new value

;;example
(define x 3)
(local ((define z (set! x (+ x 2))))
  x)

;; work through it using left-hand-side and right-hand-side

;;first right-hand-side
;;(define x 3)
;;(define z (set! x 5))

;;then change the original definition which is the left-hand-side
;;(define x 5)
;;(define z (void))

;; set! is void a invisible value to indicate the evaluation is complete

;;exercise 35.1.2
(define x8 1)
(define y9 1)
(local ((define u (set! x8 (+ x8 1)))
        (define v (set! y9 (- y9 1))))
  (* x8 y9))

;;right-hand-side
;;(define x 1)
;;(define y 1)
;;(local ((define u (set! x 2))
;;        (define v (set! y 0)))
 ;; (* x y))
;;  (* 2 0))

;;left-hand-side which is the variables
(define x1 2)
(define y1 0)
(local ((define u (void))
        (define v (void)))
  (* x y1))

;;exercise 35.2
(define x2 1)
(define y2 1)
(begin (set! x (+ x 1))
       (set! y2 (- y2 1))
       (* x y2))

;;(define x 1)
;;(define y 1)
;;(begin (set! x 2)
     ;;  (set! y 0)
     ;;  (* 2 0))

;;compared to nesting where order of additon and subtraction are important
;; and nesting implies some ordering of evaluation inner to outer bracket
(define a3 5) (* (+ a3 1) (- a3 1))

(define a4 5) (* (+ 5 1) (- 5 1))
(define a5 5) (* 6 4)
            ;; = 20

;;exercise 35.2.2
(define x6 3)
(define y7 5)
(local (( define z x))
  (begin (set! x y7)
         (set! y7 z)
         (list x y7)))

;;using begin we evaluate inorder
;;(define x 3)
;;(define y 5)
;;(local ((define z x))
;;  (begin (set! x 5)
    ;;     (set! y 5)
    ;;     (list 5 5)))

;; x contains the initial value of y
;; but y does not equal to initial value of x after the two set! expressions as all x's were replaced in the first set! with y = 5

;;exercise 35.3.1
;;(define (f x y) (begin
                 ;; (set! x y) y)) ;; says the set! needs a mutable value and x cannot be modified

;; exercise 35.3.2
(define x0 3)
(define (increase-x)
  (begin (set! x0 (+ x0 1))
          x0))

(increase-x)
(increase-x)
(increase-x)

;; result
;;((define (increase-x)
;;  (begin (set! x0 (+ 3 1))
;;          4)))

;;(define x0 4)
;;(define (increase-x)
;;  (begin (set! x0 (+ x0 1))
 ;;         (void)))

;;exercise 35.3.3
(define x00 0)
(define (switch-x)
  (begin
    (set! x00 (- x00 1))
    x00))

(switch-x)
(switch-x)
(switch-x)

;;result
;;(define (switch-x)
;; (begin
;;    (set! x (- 0 1))
;;    -1))

;; then change variable and it will subtract one everytime you call switch-x
;;(define x -1)
;;(define (switch-x)
;;  (begin
;;    (set! x (- x 1))
;;    (void)))
