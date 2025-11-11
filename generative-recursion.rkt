;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname generative-recursion) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp") (lib "gui.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp") (lib "gui.rkt" "teachpack" "htdp")) #f)))
;; algorithms

(define-struct ball (x y delta-x delta-y))
;; x and y are currentt positions of the ball
;; delta x and y are how far the ball will move in each direction

;;draw-and-clear : a-ball -> boolean (true)
;;draw, sleep, clears a ball
(define (draw-and-clear a-ball) (and (draw-solid-disk (make-posn (ball-x a-ball) (ball-y a-ball)) 5 'red)
                                     (sleep-for-a-while DELAY)
                                     (clear-solid-disk (make-posn (ball-x a-ball) (ball-y a-ball)) 5 'red)))
;;move-ball : ball -> ball
(define (move-ball a-ball) (make-ball (+ (ball-x a-ball) (ball-delta-x a-ball))
                                      (+ (ball-y a-ball) (ball-delta-y a-ball))
                                      (ball-delta-x a-ball)
                                      (ball-delta-y a-ball)))

;;canvas
(define WIDTH 100)
(define HEIGHT 100)
(define DELAY 1)

;;to move the ball multiple time
;;(start WIDTH HEIGHT)
;;(define the-ball (make-ball 100 200 -50 -50))
;;(and (draw-and-clear the-ball) (draw-and-clear (move-ball the-ball)))

;; out-of-bounds? : a-ball -> boolean
;; determines whether ball is out of canvas 
(define (out-of-bounds? a-ball) (not
                                 (and (<= 0 (ball-x a-ball) WIDTH)
                                      (<= 0 (ball-y a-ball) HEIGHT))))

;;move-until-out : a-ball -> true
;;it must check that the ball is not out-of-bounds first
;;if false for first statement then will draw/clear the ball then move it
;; use recursion to do this over again

(define (move-until-out a-ball) (cond
                                  [(out-of-bounds? a-ball) true]
                                  [else (and (draw-and-clear a-ball) (move-until-out (move-ball a-ball)))]))
;;test
;;(start WIDTH HEIGHT)
;;(move-until-out (make-ball 10 20 -5 +17))
;;(stop)

;;exercise 25.1.1
(define (map1 f alon) (cond
                             [(empty? alon) empty]
                             [else (cons (f (first alon)) (map1 f (rest alon)))]))

(define (filter? predicate alon) (cond
                                   [(empty? alon) empty]
                                   [else (cond
                                           [(predicate (first alon)) (cons (first alon) (filter? predicate (rest alon)))]
                                           [else (filter? predicate (rest alon))])]))

;;maybe lambda
;;move-balls : listof balls -> balls
;;move a list of balls on the canvas using filter and map function

;;example 
(define list-of-balls (list (make-ball 10 20 -5 +5)(make-ball 20 -30 -5 +5)(make-ball 30 40 -5 +5)(make-ball 40 50 -5 +5)(make-ball 50 60 -5 +5)))
;;= (move-balls list-of-balls)


;;test
;;(start WIDTH HEIGHT)
;;(map1 move-until-out list-of-balls)

;;(filter? out-of-bounds? list-of-balls)


;;first attempt (define (move-ball list) (local ((define b (filter?? out-of-bounds? list) (cond
                                                                         ;; [(empty? list) empty]
                                                                         ;; [else (cond
                                                                                 ;; [(out-of-bounds? (first list)) (cons (first list) (filter?? out-of-bounds? (rest list)))]
                                                                                 ;; [else (filter?? out-of-bounds (rest list))])]))
                                ;; (define m (map11 move-ball list) (cond
                                                                  ;; [(empty? alon) empty]
                                                                  ;; [else (cons (f (first alon)) (map1 f (rest alon)))])))
;;_______________________________________________________________________________________________________________________________________________________________________________
                          ;; (cond
                          ;;   [(empty? list) empty]
                          ;;   [b true]
                          ;;   [else m]

;;attempt two
;;trial with just filter? which create a listof X that holds the predicate
(define (move-balls alist) (local ((define (filter? predicate alon) (cond
                                                                      [(empty? alon) empty]
                                                                      [else (cond
                                                                               [(predicate (first alon)) (cons (first alon) (filter? predicate (rest alon)))]
                                                                               [else (filter? predicate (rest alon))])]))
                                   
                                   (define (move-one-ball a-ball) (and (draw-and-clear a-ball) (move-one-ball (move-ball a-ball))))
                                   (define (map-all f alist) ((cond
                                                                [(empty? alist) empty]
                                                                [else (cons (move-one-ball (first alist)) (map-all move-one-ball (rest alist)))]))))
;;___________________________________________________________________________________________________________________________________________________________________________________
                             [(cond
                                [(empty? alist) (stop)]
                                [else (and (filter? (map-all move-one-ball alist)) (stop))])]))
  
;;test
(start WIDTH HEIGHT)
(move-balls list-of-balls)