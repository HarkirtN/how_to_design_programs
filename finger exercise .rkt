;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |finger exercise |) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp")) #f)))
;; Finger exercises
;; (define no brackets is a variable ( function (what is it going to do) argument (what does it need)))
;; i.e.
  (define base-price 5.0)
  (define fixed-cost 180)
  (define cost-of-attendee 0.04)
  (define attendees-per-dollar (/ 15 0.1))
  (define base-cost 120)

;; (define (function - what is it going to do / argument - what it needs or already know) .. output - what is it going to giev you)
;; i.e.
  (define (area-of-disc r) ( * 3.14  ( * r r)))
  (define (area-of-ring outer inner) ( - (area-of-disc outer) (area-of-disc inner)))
  (define (find-celsius farenheit) ( * ( - farenheit 32) 0.56))
  (define (find-f n ) (+ ( * n n ) 10))
  (define (find-grosspay hours) (* 12 hours))
  (define (find-tax grosspay) (* grosspay 0.15))
  (define (netpay hours) (- (find-grosspay hours) (find-tax (find-grosspay hours))))(netpay 1)
  (define (sum-of-coins p n d q) ( / ( * 1 p) ( * 5 n ) (* 10 d) (* 25 q) 100 ))




