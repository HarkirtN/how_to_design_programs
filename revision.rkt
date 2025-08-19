;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname revision) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp")) #f)))
;;Finger exercises
;; intervals

    (define (in-interval-1? x) (and (< -3 x) (< x 0)))
       ;; ___________________________________________________
       ;; ----I=============I--------------------------------
       ;;    -3             0                 5

    (define (in-interval-2? x) (or (< x 1) (> x 2)))
       ;; ___________________________________________________
       ;; -------I=======I-----------------------------------
       ;;        1       2

    (define (in-interval-3? x) (not (and ( <= 1 x) (<= x 5))))
       ;; ____________________________________________________
       ;; =======I-----------------------------I==============
       ;;        1                             5

;;Exercise 4.2.3
;;(=  ( + (* 4 n) 2) 62)
;;(=  ( * (* n n) 2)102)
;;(=  ( + ( +( * ( * n n) 4) (* 6 n)) 2) 462)


;;this is illegal expected a clause and answer
(define n 4)
(cond
  [ (< n 10) 20]
  ;;[ (and (> n 20) (<= n 30))]
  [ else 1])

;;Exercise 4.4.2
  ;;i.e. to find netpay of grosspay $500 we need to find-tax-code
  
 (define (find-tax-code grosspay) (cond
   [(<= grosspay 240)0]
   [(<= grosspay 480) 0.15]
   [else 0.28]))

  ;;then * grosspay with tax to get total tax
  (define (total-tax grosspay) ( * (find-tax-code grosspay) grosspay))

  ;; then we can minus total tax with grosspay to get netpay
  (define (netpay grosspay) (-  grosspay (total-tax grosspay)))

(define (percentage-payback charges) (cond
                            [ (<= charges 500) 0.0025]
                            [(<= charges 1500) 0.005]
                            [(<= charges 2500) 0.0075]
                            [else 0.01]))

(define (payback charges) ( * (percentage-payback charges) charges))

  