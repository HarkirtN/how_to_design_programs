;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lists) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp")) #f)))
;; exercise 9.1.1
;;scheme list

(cons 'mercury empty)

(cons 'venus
      (cons 'mercury empty))

(cons 'earth (cons'venus
                  (cons 'mercury empty)))

(cons 'mars
      (cons 'earth
                  (cons 'venus
                               (cons 'mercury empty))))

(cons 'saturn
      (cons 'mars
                (cons 'earth
                          (cons 'venus
                                (cons 'mercury empty)))))

(cons 'jupiter
      (cons 'saturn
            (cons 'mars
                  (cons 'earth
                        (cons 'venus
                              (cons 'mercury empty))))))

(cons 'neptune
      (cons 'jupiter
            (cons 'saturn
                  (cons 'mars
                        (cons 'earth
                              (cons 'venus
                                    (cons 'mercury empty)))))))

(cons 'uranus
      (cons 'neptune
            (cons 'jupiter
                  (cons 'saturn
                        (cons 'mars
                              (cons 'earth
                                    (cons 'venus
                                          (cons 'mercury empty))))))))

;;Exercise 9.1.2
;;following list is called 'l'
(cons 10
      (cons 20
            (cons 5 empty)))

;;(rest l) ;;empty
;;(first (rest l)) ;; 5
;;(rest (rest l)) ;; empty
;;(first (rest (rest l))) ;; 5
;;(rest (rest (rest l)))  ;; empty

;; Exercise 9.1.3
;; add-up-3 : list-3-numbers -> number
;;(define list-3-numbers (cons x
                             ;;(cons y
                                   ;;(cons z empty))))

;;(define (add-up-3 list-3-numbers) ( + (first list-3-numbers)
                                       ;; ( + (first (rest list-3-numbers)
                                                  ;;   (+ (first (rest (rest list-3-numbers))))))))
;;test
(define list-3-numbers (cons 4
                             (cons 5
                                   (cons 5 empty))))
;;(add-up-3 list-3-numbers)
;; first and rest are selectors within cons structure
(define-struct pair (left right))

 (define (cons-list a-value a-list) (cond
                                     [(empty? a-list) (make-pair a-value a-list)]
                                     [(cons-list? a-list) (make-pair a-value a-list)]
                                     [else (error 'cons-list "list as second argument expected")]))

  (define (cons-first a-pair) (pair-left a-pair))

   (define (cons-rest a-pair) (pair-right a-pair))

    (define (cons-list? x) (pair? x))

;;Exercise 9.2.1
;;all inventory belongs to list-of-symbols
(define list-of-symbols (cons 'clown
                              (cons 'bow
                                    (cons 'arrow
                                          (cons 'ball empty)))))

;;data definition of arbitrary list of booleans
(define (list-of-booleans b bos) (cons b bos))

;;Exercise 9.3.1
;;(define (contains-doll? a-list) (cond
                                 ;; [(empty? a-list) false]
                                  ;;[else (cond
                                        ;;   [(symbol=? 'doll (first a-list)) true]
                                           ;;[else (contains-doll? (rest a-list))])]))

;;test
;;(contains-doll? (cons 'bow (cons 'arrow (cons 'ball empty))))

;;Exercise 9.3.2
;;reformulate definition contains-doll? where second cond-clause is combined with first
(define (contains-doll? a-list) (cond
                                  [(empty? a-list) false]
                                  [else (cond
                                          [(or (symbol=? 'doll (first a-list)) (contains-doll? (rest a-list)))true])]))

(define (contains-symbol? s-list) (cond
                                    [(empty? s-list) false]
                                    [else (cond
                                            [ (or (symbol? (first s-list)) (contains-symbol? (rest s-list))) true ])]))

(define (sum a-list) (cond
                       [(empty? a-list) 0]
                       [else ( + (first a-list) (sum (rest a-list)))]))

(define (many-symbols a-list) (cond
                                [(empty? a-list) 0]
                                [ else ( + ( many-symbols (rest a-list)) 1)]))

(define (many-numbers a-list) (cond
                                [(empty? a-list) 0]
                                [else ( + ( number? (first a-list))
                                                    (many-numbers (rest a-list)))]))

;;Exercise 9.5.3
(define (dollar-store? a-list) (cond
                                [(empty? a-list) true]
                                [( cond
                                     [(> 1 (first a-list) true) (dollar-store? (rest a-list)) true]
                                     [else false])]))

;;test example : (dollar-store? (cons .75 (cons .95 (cons .25 empty))))

;;test example : (not (dollar-store? (cons .75 (cons 1.95 (cons .25 empty)))))


;; Exercise 9.5.4
 ;; to check range is within 5 - 95 degrees
  ;; check-range1 : list of temperatures -> boolean 
   ;; template : (define (check-range1 a-list) (cond
                                ;;[(empty? a-list) false]
                                ;;[else ... (first a-list) (check-range1 (rest a-list)) ...]))

;;parameters for each list ( and (<= 5 a-list) (>= 95 a-list)) to return true


;; break this down because i will be checking 'true' for each (first a-list) statements
  ;; (<= 5 (first a-list) true)
  ;; (>= 95 (first a-list) true)


;;then if both are true you can look into the rest of the list and create a recursive definition
;; ( check-range1 (rest a-list))

  (define (check-range1 a-list) (cond
                                [(empty? a-list) false]
                                [(and (<= 5 (first a-list) (>= 95 (first a-list))))true]
                                (check-range1 (rest a-list))) true]
                                  [else false])]))


  (check-range1 (cons 10 (cons 20 (cons 75 empty))))
  (check-range1 (cons 100 (cons 10 empty)))
