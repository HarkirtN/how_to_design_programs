;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname practice#4) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp")) #f)))
;; Exercise 4.4.2
;; Data analysis determining tax in 3 different cases
   ;; 1) 0 -> 240 = 0% tax
   ;; 2) 240 -> 480 = 15% tax
   ;; 3) >480 = 28% tax
     ;; to find netpay from hours worked = grosspay (* 12 hours) - tax

;; data definition
;; tax : number -> number
;; to determine tax which is dependent on grosspay

;; netpay : number -> number
;; to determine netpay once grosspay identified

;; function body
;;(define (grosspay hours) (* 12 hours))

;;(define (tax grosspay) (cond
                         ;;[(and (<= 0 grosspay) (<= grosspay 240)) 0]
                         ;;[(and (<= 240 grosspay) (<= grosspay 480)) 0.15]
                         ;;[( < 480 grosspay) 0.28]
                         ;;))

;;(define (netpay tax) (- grosspay (* grosspay tax)))


;; Simplified
(define (grosspay hours) (* 12 hours))

(define (tax grosspay) (cond
                         [(<= grosspay 240) 0]
                         [(<= grosspay 480) 0.15]
                         [else 0.28]))

;; (define (netpay tax) (- grosspay (* grosspay tax)))
(define (netpay hours) (- (grosspay hours) (tax (grosspay hours))))


;;Exercise 4.4.3
;;Data analysis determining the pay-back from a percentage of what was charged annually
;; four different cases to determine percentage-of-payback
   ;; 1) 0 -> 500 = 0.25% of charge
   ;; 2) 500 -> 1500 = 0.50% of charge
   ;; 3) 1500 -> 2500 = 0.75% of charge
   ;; 4) > 2500 = 1.0% of charge
     ;; to find payback need calculate the percentage-of-payback off the amount charged

;; Data definiton
;; percentage-of-payback : number -> number
;; to determine percentage-of-payback dependent on the amount charged

;; payback : number -> number
;; to determine total payback from percentage-of-payback and amount charged

;; Function body
(define (percentage-of-payback charges) (cond
                                         [ (and (<= 0 charges) ( <= charges 500)) 0.0025]
                                         [ (and (<= 500 charges) (<= charges 1500)) 0.0050]
                                         [ (and ( <= 1500 charges) (<= charges 2500)) 0.0075]
                                         [ ( < 2500 charges) 0.01]))

(define (payback-total charges) (* charges (percentage-of-payback charges)))

;; (define (payback-total percentage-of-payback) (* charges (* percentage-of-payback 0.01)))
;; Test example 400 charge = 0.25 percentage-of-payback * 1/100 * 400 charge

;; Simiplified
;;(define (percentage-of-payback-2 charges) (cond
  ;;                                       [ (<= charges 500) 0.25]
    ;;                                     [ (<= charges 1500) 0.50]
      ;;                                   [ (<= charges 2500) 0.75]
        ;;                                 [else 1.0]))

;; (define (payback-total-2 charges) (* charges (* percentage-of-payback 0.01)))

;; learning is to find the common denomiator when we are composing functions. Then common denominator is the known value/variable
;; inner brackets to determine order of the equation DO NOT assume the prior functions habve been calculated
