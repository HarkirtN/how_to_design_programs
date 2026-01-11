;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname traffic-light-set!) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp") (lib "gui.rkt" "teachpack" "htdp") (lib "graphing.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp") (lib "gui.rkt" "teachpack" "htdp") (lib "graphing.rkt" "teachpack" "htdp")) #f)))
;; state-variable templates finger exercises

;;data definition - traffic-light is either 'red, 'yellow, or 'greem

;;state-variables are the current-light
;; to keep track of the current-light
(define current-light 'red)

;; contract : next -> void

;;purpose : the function will change the current light colour and produce void once completed

;;effect: change current-light colour from 'red to 'green, 'green to 'yellow and 'yellow to 'red

;;examples
;;if current colour is 'red then evaluate (next) then current-light is 'green
;;if current colour is 'green then evaluate (next) then current-light is 'yellow
;;if current colour is 'yellow then evaluate (next) then current-light is 'red

;;template
(define (temp)
  (cond
    [(symbol=? current-light 'green) (set! current-light ...)]
    [(symbol=? current-light 'yellow) (set! current-light ...)]
    [(symbol=? current-light 'red) (set! current-light ...)]))

;; definition for next
(define (next)
  (cond
    [(symbol=? current-light 'green) (set! current-light 'yellow)]
    [(symbol=? current-light 'yellow) (set! current-light 'red)]
    [(symbol=? current-light 'red) (set! current-light 'green)]))

;;tests
(begin (set! current-light 'green) (next) (symbol=? current-light 'yellow))
(begin (set! current-light 'yellow) (next) (symbol=? current-light 'red))
(begin (set! current-light 'red) (next) (symbol=? current-light 'green))

(start 300 300)
(begin (current-light 'red)
       (next))