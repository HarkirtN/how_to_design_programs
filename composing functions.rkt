;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |composing functions|) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp")) #f)))
;; pennies : pennies -> pennies
;; Just because I made the others.
(define (pennies x) x)

;; nickels : nickels -> pennies
(define (nickels x) (* x 5))

;; dimes : dimes -> pennies
(define (dimes x) (* x 10))

;; quarters : quarters -> pennies
(define (quarters x) (* x 25))

;; sum-coins : list of coins -> pennies total
(define (sum-coins p n d q) (+ (pennies p) (nickels n) (dimes d) (quarters q)))

;; format-dollars : integer -> string
;; (format-dollars (sum-coins 1 2 3 4))
(define (format-dollars i) (/ i 100))


;; profit : number -> number
;; profit = revenue - cost
(define ( profit ticket-price) ( - (revenue ticket-price) (cost ticket-price)))
(define ( profit p) (- (revenue p) (cost p)))

;; revenue : number -> number
;; revenue = ticket price x attendees
(define (revenue ticket-price) (* (attendees ticket-price) ticket price))
(define ( revenue p) ( * p attendees) )

;;cost : number -> number
;; cost = standard price for performance + attendees with associated $0.04
(define (cost ticket-price) ( + 180 (* 0.04 attendees ticket price)))
(define ( cost p) (+ 180 ( * 0.04 attendees p)

;; attendees : number -> number
;; attendees = depends on ticket price
(define (attendees ticket-price) (+ 120 (* (/ 15 0.10) (- 5.00 ticket-price))))

