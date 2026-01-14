;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname hangman) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp") (lib "gui.rkt" "teachpack" "htdp") (lib "graphing.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp") (lib "gui.rkt" "teachpack" "htdp") (lib "graphing.rkt" "teachpack" "htdp")) #f)))
;; hangman
;; A letter is a symbol in 'a ..'z plus

;; A word is a (listof letter)

;; A body-part is one of the following
(define PARTS '(head body right-arm left-arm right-leg left-leg))

;;constants
;;some guessing words
(define WORDS '((h e l l o) (w o r l d) (i s) (a) (s t u p i d) (p r o g r a m)))

;; the number of words you can choose from
(define WORDS# (length WORDS))

;;chosen-word : word
;; the word the player needs to gues
(define chosen-word (first WORDS))

;;status-word : word
;; represents which letter the player has and hasn't guessed
(define status-word (first WORDS))

;;body-parts-left : (listof PARTS)
;; the list of body parts availble
(define body-parts-left PARTS)

;;hangman : -> void
;; effect initialise the chosen-word, status-word, and body-part-left
(define (hangman)
  (begin
    (set! chosen-word (list-ref WORDS (random (length WORDS))))
    (set! status-word ...)
    (set! body-parts-left PARTS)))

(define (make-status-word a-word) (cond
                                    [(zero? (length a-word)) empty]
                                    [else (cons '_ (make-status-word (length a-word)) sub1)]))

(make-status-word '(i s))