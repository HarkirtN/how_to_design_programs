;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |traffic light|) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp")) #f)))
;;simple pictures
(start 300 300)

(draw-solid-line (make-posn 1 1) (make-posn 5 5) 'red)

(draw-solid-rect (make-posn 20 10) 50 200 'blue)

(draw-circle (make-posn 200 10) 50 'red)

(draw-solid-disk (make-posn 200 10) 50 'green)

(stop)

;; dimensions of traffic light
(define WIDTH 50)
(define HEIGHT 160)
(define BULB-RADIUS 20)
(define BULB-DISTANCE 10)

;;the positions of the bulb
(define X-BULB (quotient WIDTH 2))
(define Y-RED (+ BULB-DISTANCE BULB-RADIUS))
(define Y-YELLOW (+ Y-RED BULB-DISTANCE (* 2 BULB-RADIUS)))
(define Y-GREEN (+ Y-YELLOW BULB-DISTANCE (* 2 BULB-RADIUS)))

;;draw the light with the red bulb turned on
;;(start WIDTH HEIGHT)
;;(draw-solid-disk (make-posn X-BULB Y-RED) BULB-RADIUS 'red)
;;(draw-circle (make-posn X-BULB Y-YELLOW) BULB-RADIUS 'yellow)
;;(draw-circle (make-posn X-BULB Y-GREEN) BULB-RADIUS 'green)
 ;;(stop)

;;Exercise 6.2.2
;; *first practice
;;(define (clear-bulb colour) (cond
;;                              [(symbol=? ( and (draw-solid-disk (make-posn X-BULBS Y-RED) BULB-RADIUS 'green) (= colour 'green))) clear-solid-disk]
;;                              [(symbol=? ( and (draw-solid-disk (make-posn X-BULBS Y-RED) BULB-RADIUS 'yellow) (= colour 'yellow))) clear-solid-disk]
 ;;                             [(symbol=? ( and (draw-solid-disk (make-posn X-BULBS Y-RED) BULB-RADIUS 'red) (= colour 'red))) clear-solid-disk]))

;;required to provide functions for each traffic light bulb 'on' phase
(define (light-on colour) (cond
                          [(symbol=? colour 'red) (draw-solid-disk (make-posn X-BULB Y-RED) BULB-RADIUS 'red)]
                          [(symbol=? colour 'yellow) (draw-solid-disk (make-posn X-BULB Y-YELLOW) BULB-RADIUS 'yellow)]
                          [(symbol=? colour 'green) (draw-solid-disk (make-posn X-BULB Y-GREEN) BULB-RADIUS 'green)]))

;;required to provide functions for each traffic light bulb 'off' phase
(define (light-off colour) (cond
                             [(symbol=? colour 'red) (and (draw-circle (make-posn X-BULB Y-RED) BULB-RADIUS 'red) (clear-solid-disk 'red))]
                             [(symbol=? colour 'yellow) (and (draw-circle (make-posn X-BULB Y-YELLOW) BULB-RADIUS 'yellow) (clear-solid-disk 'yellow))]
                             [(symbol=? colour 'green) (and (draw-circle (make-posn X-BULB Y-GREEN) BULB-RADIUS 'green) (clear-solid-disk 'green))]))

;; combine (and (exp1) (exp2)) to create an effect of turning off the corresponding colour
(define (clear-bulb colour) (cond
                              [(symbol=? colour 'red) (and (light-on 'red) (light-off 'red) (light-off 'yellow) (light-off 'green))]
                              [(symbol=? colour 'yellow) (and (light-off 'red) (light-on 'yellow) (light-off 'yellow) (light-off 'green))]
                              [(symbol=? colour 'green) (and (light-off 'red) (light-off 'yellow) (light-on 'green) (light-off 'green))]))


;; draw bulb exercise function is to turn on the traffic light
(define (draw-bulb colour) (cond
                              [(symbol=? colour 'red)(and (light-off 'red) (light-on 'red) (light-off 'yellow) (light-off 'green))]
                              [(symbol=? colour 'yellow) (and (light-off 'red) (light-off 'yellow) (light-on 'yellow) (light-off 'green))]
                              [(symbol=? colour 'green) (and (light-off 'red) (light-off 'yellow) (light-on 'green))]))

;; switch function clear bulb of first colour and draw the second bulb
(define (switch colour1 colour2) (cond
                                   [(and (symbol=? colour1 'red) (symbol=? colour2 'yellow)) (and (clear-bulb 'red) (draw-bulb 'yellow))]
                                   [(and (symbol=? colour1 'red) (symbol=? colour2 'green)) (and (clear-bulb 'red) (draw-bulb 'green))]
                                   [(and (symbol=? colour1 'green) (symbol=? colour2 'red)) (and (clear-bulb 'green) (draw-bulb 'red))]
                                   [(and (symbol=? colour1 'green) (symbol=? colour2 'yellow)) (and (clear-bulb 'green) (draw-bulb 'yellow))]
                                   [(and (symbol=? colour1 'yellow) (symbol=? colour2 'red)) (and (clear-bulb 'yellow) (draw-bulb 'red))]
                                   [(and (symbol=? colour1 'yellow) (symbol=? colour2 'green)) (and (clear-bulb 'yellow) (draw-bulb 'green))]))

;;next switch traffic light current colour to next one
(define (next current-colour) (cond
                                [(and (symbol=? current-colour 'red) (switch 'red 'green)) 'green]
                                [(and (symbol=? current-colour 'yellow) (switch 'yellow 'red)) 'red]
                                [(and (symbol=? current-colour 'green) (switch 'green 'yellow)) 'yellow]))

(start WIDTH HEIGHT)
;;(draw-bulb 'red)
(next 'red)
