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

;;symbols
(define (reply s) (cond
                    [(symbol=? s 'GoodMorning) 'Hi]
                    [(symbol=? s 'HowAreYou?) 'Fine]
                    [(symbol=? s 'GoodAfternoon) 'INeedANap]
                    [(symbol=? s 'GoodEvening) 'BoyAmITired]))

;;check guess
(define (check-guess guess target) (cond
                                     [(symbol=? (< guess target)) 'TooSmall]
                                     [(symbol=? (= guess target)) 'Perfect]
                                     [(symbol=? (> guess target)) 'TooLarge]))

;;check colour
(define (check-colour target1 target2 guess1 guess2) (cond
                                                       [(symbol=? ( and (= guess1 target1) (= guess2 target2))) 'Perfect]
                                                       [(symbol=? (or (= guess1 target1) (= guess2 target2))) 'OneColourAtCorrectPosition]
                                                       [(symbol=? (or (= guess1 target2) (= guess2 target1))) 'OneColourOccurs]
                                                       [else 'NothingCorrect]))
;; structures
;; structures are like arrays i.e. list and you can use this to extract information later on 
;;(define a-posn (make-posn 3 4))

;;(define (distance-to-0 a-posn) (sqrt (+ ( sqr (posn-x a-posn)) (sqr (posn-y a-posn)))))

(define-struct sandwhich (bread sauce cheese))
(make-sandwhich 'freyas 'mustard 'tastycheese)

;; so when you call for cheese you write
(sandwhich-cheese (make-sandwhich 'freyas 'mustard 'tastycheese))
;; it will return 'tastycheese

;; same would go for ohone book entry first define-structure : entry i.e name phone address
(define-struct entry (name phonenumber address))

;; then next would be inputing informtion i.e. make-entry joe 0214 litestreet
(make-entry 'joe 'unknown 'litestreet)

;; to call for phonenumber
(entry-phonenumber (make-entry 'joe 'unknown 'litestreet))




  