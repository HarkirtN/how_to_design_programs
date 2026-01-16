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


;;first attempt
;;(define (make-status-word a-word) (cond
                                   ;; [(zero? (length a-word)) empty]
                                   ;; [else (cons '_ (make-status-word (length a-word)) sub1)]))

(define (make-status-word a-word) (cond
                                    [(zero? (length a-word)) empty]
                                    [else (cons '_ (make-status-word (rest a-word)))]))
;;test - it works !!!
(make-status-word '(i s))
(make-status-word '(h e l l o ))

;;hangman : -> void
;; effect initialise the chosen-word, status-word, and body-part-left
(define (hangman)
  (begin
    (set! chosen-word (list-ref WORDS (random (length WORDS))))
    (set! status-word (make-status-word WORDS))
    (set! body-parts-left PARTS)))

;; hangman-guess : letter -> response
;; to determine whether the player has won, lost or continue to play
;; if no progress, which body-part is lost
;; effect:
;; 1. the guess represent progress which updates status word
;; 2. if not it shortens the body-parts-left list by one

;;(define (hangman-guess guess) (cond
                              ;;  ['guess revealed new info
                                                       ;;(cond
                                                           ;; [guess completed the search for the word]
                                                           ;; [guess did not complete the search
                                                                 ;;  (begin
                                                                 ;;    (set! status-word ...))])]
                              ;;  [guess did not reveal new information:
                              ;;         (begin
                              ;;           (set! body-parts-left ...)
                              ;;          ...)]))

;; revel-list : word word letter -> word
;; to compute the new status word
(define (reveal-list chosen-word status-word guess)
  (local ((define (reveal-one chosen-letter status-letter)
            (cond
              [(symbol=? chosen-letter guess) guess]
              [else status-letter])))
    (map reveal-one chosen-word status-word)))

;;hangman-guess full definition
(define (hangman-guess guess) (local ((define new-status (reveal-list chosen-word status-word guess)))
                                (cond
                                  [(equal? new-status status-word) ;; compare if they are same using equal
                                   (local ((define next-part (first body-parts-left))) ;;retrieve the first body-parts-left prior to set! it premanently
                                     (begin
                                       (set! body-parts-left (rest body-parts-left)) ;;alter the the list as one will be removed 
                                       (cond
                                         [(empty? body-parts-left) (list "you lost" chosen-word)] ;; response for losing the game which meant all body-parts are drawn
                                         [else (list "sorry" next-part status-word)])))] ;; a body-part is drawn and reminder of status word provided
                                  [else
                                   (cond
                                     [(equal? new-status chosen-word) "you won"] ;; compare if the current status is same as chosen, you've won 
                                     [else (begin
                                             (set! status-word new-status) ;; change the status word if you've got one right 
                                             (list "right guess" status-word))])]))) ;; update the status word

;; NOTE a pattern is to update the list, word, book prior to output for user - so change memory then reveal
;; if you need something from the list before it gets altered place it in a local where you retrieve the item

;; modify the program so that it keeps track of all guesses
;; if player enters the same guess twice it will respond "you have used this guess before"
(define (keep-track guess chosen-word) (cond
                                         [(symbol=? guess ((list-ref chosen-word) 0)) "you've guessed this before"]
                                         [else (keep-track (rest chosen-word))]))

;;test
(keep-track 'e (list 'h 'e 'l 'l 'o))
