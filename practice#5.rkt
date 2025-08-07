;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname practice#5) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp")) #f)))
;; Symbolic information
;; Reply : symbol -> symbol
;; to determine a reply for a greeting

(define ( reply s) (cond
                     [(symbol=? s 'HowAreYou?) Good]
                     [ (symbol=? s 'HowAreYou?) Fine]
                     [( symbol=? s 'HowAreYou?) NotGood]
                     [(symbol=? s 'HowAreYou?) Sad]))

;;Exercise 5.1.2 check-guess
;; check-guess : number number -> symbol
;; to determine the target with the least amount of guesses
( define (check-guess guess target) cond
   [(symbol=? guess ...)(symbol=? target ...) 'TooSmall]
   [(symbol=? guess ...) (symbol=? target ...) 'Perfect]
   [(symbol=? guess ...) (symbol=? target ...) 'TooLarge])

;;test example - thinking through
;;___________________________________________________
;;I-------II-------A------------------II-------------I
;;0      25000    47000               78900          99999

;;first condition tested A= target = 47000, person guessed 100 which is input
;;(define (check-guess 100 47000) cond
  ;;[(symbol=? <= guess 250000) (symbol=? 47000 target) 'TooSmall]
  ;;[(symbol=? = guess 47000) (symbol=? 47000 target) `Perfect]
  ;;[(symbol=? >= guess 78900) (symbol=? 47000 target) `TooLarge]))


;; test example
;; the computer will need to check the guess against the target, so revised function is:

(define ( check-guess guess target) cond
  [(< guess target) 'TooSmall]
  [(= guess target) 'Perfect]
  [(> guess target) 'TooLarge])

;;However there needs to be some parameters for the guesses
(define ( check-guess guess target) cond
  [( and( < guess target) ( <= guess 0) (>= 99999 guess))'TooSmall]
  [( and (= guess target) (<= guess 0) (>= 99999 guess))'Perfect]
  [( and (> guess target) (<= guess 0) (>= 99999 guess))'TooLarge])

;;Exercise 5.1.3
;; digits are the user's guesses 
;; guess is the number determined by three digit combo
;; target is the randomly chosen number 
;;(define (check-guess-1 guess target) cond
;;  [( and(symbol=? guess 123) (< target guess) 'TooSmall]...

(define (guess O T H) ( + (* O 1) (* T 10) (* H 100)))

(define (check-guess-3 O T H target)
  (cond
    [(< (guess O T H) target) 'TooSmall]
    [(= (guess O T H) target) 'Perfect]
    [(> (guess O T H) target) 'TooLarge]))

(guess-with-gui-3 check-guess-3)
;; cannot call the name, only write what you have i.e. integers
;; treat each equation as an isolated equation, but have the definitions written out first 