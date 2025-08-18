;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |finger exercise |) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp")) #f)))
;; Finger exercises

;; (define no brackets is a variable ( function (what is it going to do) argument (what does it need/already know)))
;; i.e.
  (define base-price 5.0)
  (define fixed-cost 180)
  (define cost-of-attendee 0.04)
  (define attendees-per-dollar-discount (/ 15 0.10))
  (define base-cost 120)

;; (define (function - what is it going to do / argument - what it needs or already know) .. output - what is it going to give you)
;; i.e.
  (define (area-of-disc r) ( * 3.14  ( * r r)))
  (define (area-of-ring outer inner) ( - (area-of-disc outer) (area-of-disc inner)))
  (define (find-celsius farenheit) ( * ( - farenheit 32) 0.56))
  (define (find-f n ) (+ ( * n n ) 10))
  (define (find-grosspay hours) (* 12 hours))
  (define (find-tax grosspay) (* grosspay 0.15))
  (define (netpay hours) (- (find-grosspay hours) (find-tax (find-grosspay hours))))
  (define (sum-of-coins p n d q) ( / ( * 1 p) ( * 5 n ) (* 10 d) (* 25 q) 100 ))
  (define (attendees ticket-price) ( + base-cost( * attendees-per-dollar-discount (- base-price ticket-price))))
  (define (revenue ticket-price) ( * (attendees ticket-price) ticket-price))
  (define (cost ticket-price) (+ base-cost (* 0.04 (attendees ticket-price))))
  

;; composing functions
;; i.e.
(define (profit ticket-price) (- ( revenue ticket-price) (cost ticket-price)))

;; area-of-pipe : number, number, number -> number
;; (define (area-of-pipe radius length thickness) (* length ( * 3.14 (* 2 ( + radius thickness)))))
(define (circumference radius thickness) ( * 3.14 ( * 2 ( + radius thickness))))
(define (area-of-pipe length circumference) ( * length circumference))
(area-of-pipe 10 (circumference 2 1))

;; height-of-rocket : number -> number
;; (define (speed distance time) ( / distance time ))
;; (define (height-of-rocket time) ( * 0.5 ( * (velocity time) (speed time))))
;; (define (velocity time) (/ displacement time))

(define displacement ...)
(define (velocity seconds) (* seconds displacement))
(define (height-of-rocket seconds) (* 0.5 (velocity seconds)))
(height-of-rocket 10)



