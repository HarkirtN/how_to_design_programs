;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname section18) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
;;intermezzo 3
;; local definitions allow you to bind two definitions together to help recognise the connection. This is a easier way to understand
;; the function as opposed to trying to write multiple auxillary functions together.
  ;; local is consist of keyword "local" then different definitions

;;right-hand side expression 
;;(local ((define (f x) (+ x 5))     (define (g a-list) (cond
                                              ;;  [(empty? a-list) empty]
                                              ;;  [else (cons (f (first a-list) (g (rest a-list))))])))

;;body of local expression
            ;; (g (list 1 2 3)))

;;exercise 18.1.1
;; idenitfy locally defined variables, functions, the right-hand side, body of local-expression

;;(local ((define x (* y 3))) (* x x))
;; x is the variable
;; (define x (* y 3)) is the right-hand side
;; (* x x) is the body

(local ((define (f x) (g x (+ x 1)))
        (define (g x y) (f (+ x y))))
  (+ (f 10) (g 10 20)))
;; variables are x and y
;; functions are f and g
;; the above are right-hand side
;; (+ (f 10) (g 10 20) is the body expression

;;exercise 18.1.2
;;(local ((define x 10) (y (+ x x))) y)
;; there is no function definition for y

(local ((define (f x) (+ (* x x) (* 3 x) 15))
        (define x 100)
        (define f@100 (f x)))
  (f@100 (f x)))
;; expected only one expression - missing bracket


(define (D x y)       (local ((define x2 (* x x))
                              (define y2 (* y y)))   (sqrt (+ x2 y2))))
(+ (D 0 1) (D 3 4))
;; which means that every "D" value/argument to be evaluated using the local expression
;; therefore (D 0 1) will be *0 0 + *1 1 and then sqrt = 1
  ;; (D 3 4) = *3 3 + *4 4 then sqrt = 5
     ;; adding (D 0 1) and (D 3 4) is essentially 1 + 5

(local ((define (odd? n) (cond
                          [(zero? n) false]
                          [else (even? (sub1 n))]))
         (define (even? n) (cond
                             [(zero? n) true]
                             [else (odd? (sub1 n))])))
  (even? 1))
;;evaluate to false because even 1 goes to (odd? (1-0)) = odd? 0
  ;; odd? 0 is false

;;NOTE: local expression are meant to encapsulate a collection of function for one purpose - if needing to use the functions in other places local is not neccessary

;;exercise 18.1.6
;; you can add sort function auxiallry definitions together as a locally defined sort
(define (sort1 alon) (local ((define (sort1 alon) (cond
                                                 [(empty? alon) empty]
                                                 [(cons? alon) (insert (first alon) (sort (rest alon)))]))
                           (define (insert n alon) (cond
                                                     [(empty? alon) (list n)]
                                                     [else (cond
                                                             [(> n (first alon)) (cons (n alon))]
                                                             [else (cons (first alon) (insert n (rest alon)))])])))
                      (sort1 alon)))


;;exercise 18.1.8
(define (draw-polygon alop) (local ((define (connect-dots alop) (cond
                                                                  [(empty? (rest alop)) true]
                                                                  [else (and (draw-solid-line (first alop) (second alop) 'red) (connect-dots (rest alop)))]))
                                    (define (last alop) (cond
                                                          [(empty? (rest alop)) (first alop)]
                                                          [else (last (rest alop))])))
                              
                           (draw-polygon (connect-dots (cons (last alop) alop)))))

;; having to use two natural recursions to look thrugh a list will require a local defintions that initiates a search first
;;i.e. trying to search a list of records for a star-name but wanting to see if the the name occurs twice in the list
(define-struct star (name instrument))

(define alos (list (make-star 'chris 'saxophone)
                   (make-star 'robby 'trumpet)
                   (make-star 'matt 'violin)
                   (make-star 'robby 'guitar)
                   (make-star 'matt 'radio)))

(define (last-occurence s alos) (cond
                                  [(empty? alos) false]
                                  [else (local ((define r (last-occurence s (rest alos))))
                                          (cond
                                            [(star? r) r]
                                            [(symbol=? s (star-name (first alos))) (first alos)]
                                            [else false]))]))

;;exercise 18.1.11
;; (last-occurence 'matt (list (make-star 'matt 'violin) (make-star 'matt 'radio)))
;;local expressions lifted once because rest of list is only one

;;exercise 18.1.12
;;maxi : non-empty alon -> number
;; to determine the largest number in alon

(define (maxi alon) (cond
                      [(empty? (rest alon)) (first alon)]
                      [else (local (( define n (maxi (rest alon))))
                              (cond
                              [(> (first alon) n ) (first alon)]
                              [else n]))]))

