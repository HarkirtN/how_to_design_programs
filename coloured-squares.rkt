;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname coloured-squares) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp") (lib "gui.rkt" "teachpack" "htdp") (lib "graphing.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp") (lib "gui.rkt" "teachpack" "htdp") (lib "graphing.rkt" "teachpack" "htdp")) #f)))
;; coloured - squares guessing game
;; the colours that can be chosen
(define COLORS (list 'black 'white 'red 'blue 'green 'gold 'pink 'orange 'purple 'navy))

;;the number of colors
(define COL# (length COLORS))

;;example1:
(master)
(master-check 'red 'red)
;; NothingCorrect
(master-check 'black 'pink)
;;'OneColorOccurs ...

;;example2:
(master)
(master-check 'red 'red)
;;'Pefect

