;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname traffic-light-v2) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp") (lib "gui.rkt" "teachpack" "htdp") (lib "graphing.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp") (lib "gui.rkt" "teachpack" "htdp") (lib "graphing.rkt" "teachpack" "htdp")) #f)))
;; traffic light simulation
; dimensions of traffic light
(define WIDTH 50)
(define HEIGHT 160)
(define BULB-RADIUS 20)
(define BULB-DISTANCE 10)

;;the positions of the bulb
(define X-BULB (quotient WIDTH 2))
(define Y-RED (+ BULB-DISTANCE BULB-RADIUS))
(define Y-YELLOW (+ Y-RED BULB-DISTANCE (* 2 BULB-RADIUS)))
(define Y-GREEN (+ Y-YELLOW BULB-DISTANCE (* 2 BULB-RADIUS)))

(define (light-on colour) (cond
                          [(symbol=? colour 'red) (draw-solid-disk (make-posn X-BULB Y-RED) BULB-RADIUS 'red)]
                          [(symbol=? colour 'yellow) (draw-solid-disk (make-posn X-BULB Y-YELLOW) BULB-RADIUS 'yellow)]
                          [(symbol=? colour 'green) (draw-solid-disk (make-posn X-BULB Y-GREEN) BULB-RADIUS 'green)]))

;; example demonstartes a function that consumes large piece of data and modifies memory
(define colour 'red)

;;switch : N ->
;; switches the traffic light N times
;; holds each colour for 3 seconds
(define (switch N) (cond
                     [(= N 0) (void)]
                     [else (begin (sleep-for-a-while 3)
                                  (next)
                                  (switch (- N 1)))]))

;;generative recursion
;; switch-forever : -> void
;; switches the colours of traffic light forever
(define (switch-forever)
 (begin (sleep-for-a-while 3)
        (next)
        (switch-forever)))

;;next : colour -> colour
(define (next) (cond
                        [(symbol=? 'red colour) (light-on (set! colour 'green))]
                        [(symbol=? 'yellow colour) (light-on (set! colour 'red))]
                        [else (light-on (set! colour 'yellow))]))

;; test
(start 300 300)
(begin (and (draw-solid-disk (make-posn X-BULB Y-RED) BULB-RADIUS 'red)
            (draw-circle (make-posn X-BULB Y-YELLOW) BULB-RADIUS 'yellow)
            (draw-circle (make-posn X-BULB Y-GREEN) BULB-RADIUS 'green))
(switch 4))