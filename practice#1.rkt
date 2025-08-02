;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname practice#1) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp")) #f)))
(define base-price 5.0)

(define fixed-cost 180)

(define cost-of-attendee 0.04)

(define attendees-per-dollar-discount (/ 15 0.1))

(define base-attendance 120)

;; profit : number -> number
(define (profit ticket-price) (- (revenue ticket-price) (cost ticket-price)))

;; revenue : number -> number 
(define (revenue ticket-price) (* (attendees ticket-price) ticket-price))

;; cost : number -> number 
(define (cost ticket-price) (+ fixed-cost (* cost-of-attendee (attendees ticket-price))))

;; attendees : number -> number 
(define (attendees ticket-price) (+ base-attendance (* attendees-per-dollar-discount (- base-price ticket-price))))


