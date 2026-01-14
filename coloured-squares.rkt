;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname coloured-squares) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp") (lib "gui.rkt" "teachpack" "htdp") (lib "graphing.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp") (lib "gui.rkt" "teachpack" "htdp") (lib "graphing.rkt" "teachpack" "htdp")) #f)))
;; coloured - squares guessing game
;; the colours that can be chosen
(define COLORS (list 'black 'white 'red 'blue 'green 'gold 'pink 'orange 'purple 'navy))

;;the number of colors
(define COL# (length COLORS))

;;example1:
;;(master)
;;(master-check 'red 'red)
;; NothingCorrect
;;(master-check 'black 'pink)
;;'OneColorOccurs ...

;;example2:
;;(master)
;;(master-check 'red 'red)
;;'Pefect

;; target1, target2 : color
;; the two variables represent the two colors that the first player chose
(define target1 (first COLORS))
(define target2 (first COLORS))

;;master : -> void
;; effect set target1 and target2 to randomly chosen items in COLORS
(define (master)
  (begin
    (set! target1 (list-ref COLORS (random COL#)))
    (set! target2 (list-ref COLORS (random COL#)))))

;;exercise 37.1.2
;; abstract function random-pick that extracts the repeated expression from master
;; random-pick : list -> random item
(define (random-pick list1) (list-ref COLORS (random COL#)))

(define (master2)
  (begin
    (set! target1 (random-pick COLORS))
    (set! target2 (random-pick COLORS))))

;;exercise 37.1.3
;; modify color guessing program so the final output is perfect and list of the number of guess player made

(define (check-color guess1 guess2 target1 target2) (cond
                                                      [(and (symbol=? guess1 target1) (symbol=? guess2 target2)) 'Perfect]
                                                      [(or (symbol=? guess1 target1) (symbol=? guess2 target2)) 'OneColorAtCorrectPosition]
                                                      [(or (symbol=? guess1 target2) (symbol=? guess2 target1)) 'OneColorOccurs]
                                                      [else 'NothingCorrect]))

(define (master-check guess1 guess2) (check-color guess1 guess2 target1 target2))

;;(define (invert0 alox0) (local (;;accumalator ... invert function reverses the order of the items on the list it should not forget anything,
                                ;; therefore we need to accumalate the items 'rev encounters
                              ;;  (define (rev alox accumalator)
                              ;;    (cond
                              ;;      [(empty? alox) ...] ;;if alox is empty than it is whatever rev's answer/ouput which it accumalator
                              ;;      [else
                              ;;       ... (rev (rest alox) ;; this is an auxillary function
                              ;;                ... (first alox) ... accumalator)...]))) ;; expression that keeps the accumalation process that rev is about to 'forget'
                    ;;      (rev alox0 ...))) ;; accumalator receives alox0, so accumaltor is empty when it recurs then it encouter extra item (first alox), to remeber we add 'cons'

(define (count-attempts function) (cond
                                    [(not (symbol=? 'Perfect function)) (+ 1 (count-attempts function))]
                                    [else 1]))

;;test
(count-attempts (master-check 'red 'red))