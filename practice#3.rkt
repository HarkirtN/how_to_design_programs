;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname practice#3) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp")) #f)))
;; Exercise 4.1.1 Booleans
(and (> 4 3) (<= 10 100))
;;true

(or (> 4 3) (= 10 100))
;; true 

(not (= 2 3))
;; true



;;Exercise 4.1.2
(= (* 4 4) 4)
;; false

;; Functions that test conditions
 ;;is-between-5-6? : number -> boolean
  ;; to determine when n is between 5 and 6
   (define (is-between-5-6? n) (and (> 5 n) (< 6 n)))

;;Interval boundaries
 ;; is-between-5-6-or-over-10? : number -> boolean
  ;; to determine whether n is between 5 and 6
   ;; or larger than or equal to 10
    (define (is-between-5-6-or-over-10? n) (or (is-between-5-6? n) (>= n 10)))



;; Exercise 4.2.2
 ;; in-interval-1? : number -> boolean
  ;; to determine whether n is between -3 and 0
   (define (in-interval-1? x) (and (< -3 x) (< x 0)))
   (in-interval-1? -2)
     ;; true

;; in-interval-3? : number -> boolean
 ;; to determine whether x is NOT between 1 and 5
  (define (in-interval-3? x) (not ( and( <= 1 x) (<= x 5))))
  (in-interval-3? -2)
    ;;true

;;Exercise 4.2.3 
 (define (equation1 n)(= (+ (* 4 n) 2) 62))


;; Exercise 4.2.4
 ;; test expression :
  ;;(farenheit -> celsius 32)
   ;; expected result 0

;;test expression :
 ;;(farenheit -> celsius 212)
  ;; expeected result 100

   ;; Then (= (farenheit -> celsius 32) 0) and (= (farenheit -> celsius 212) 100)



;; Exercise 4.3 conditionals functions
 ;; (cond [question answer) ... [question answer])
  ( define n 5)
  ( cond [ (< n 10 ) 20]
       [* 10 n]
       [ else 555])
       ;; this is illegal because second line has no answer


(cond
  [ ( <= n 1000) .040]
  [ ( <= n 5000) .045]
  [ ( <= n 10000) .055]
  [ ( > n 10000) .060])

  ;; Using the above conditions 
   ;; (n 500)
    ;; expected value is .040

  ;; ( n 2800)
   ;; expected value is 0.045

  ;; ( n 15000)
   ;; expected value is 0.060




