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
(define x 3)
(define z (set! x 5))

;;then change the original definition which is the left-hand-side
(define x 5)
(define z (void))

;; set! is void a invisible value to indicate the evaluation is complete

;;exercise 35.1.2
(define x 1)
(define y 1)
(local ((define u (set! x (+ x 1)))
        (define v (set! y (- y 1))))
  (* x y))

;;right-hand-side
(define x 1)
(define y 1)
(local ((define u (set! x 2))
        (define v (set! y 0)))
 ;; (* x y))
  (* 2 0))

;;left-hand-side which is the variables
(define x 2)
(define y 0)
(local ((define u (void))
        (define v (void)))
  (* x y))

;;exercise 35.2
