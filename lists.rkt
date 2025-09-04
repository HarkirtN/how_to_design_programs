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
;; to provide conditions that allow the computer to exit out of loop
;; i.e. empty (base case) holds true as it suggest end of list and should exit out

(define (dollar-store? a-list) (cond
                                [(empty? a-list) true]

;; then if the first is above $1 then there is no point looking into the (rest a-list) so should catch this by : < 1 (first a-list) return false
                                [( cond
                                     [(< 1 (first a-list) false]

;; last condition should be the recursive for (rest a-list)
                                     [else (dollar-store? (rest a-list))]

  ;;test example : (dollar-store? (cons .75 (cons .95 (cons .25 empty))))
    ;;test example : (not (dollar-store? (cons .75 (cons 1.95 (cons .25 empty)))))


;; Exercise 9.5.4
 ;; to check range is within 5 - 95 degrees
  ;; check-range1 : list of temperatures -> boolean 
   ;; template : (define (check-range1 a-list) (cond
                                ;;[(empty? a-list) false]
                                ;;[else ... (first a-list) (check-range1 (rest a-list)) ...]))

;;going back to helping the computer exit the loop
(define (check-range1 a-list) (cond
                                [(empty? a-list) true]
                                
;;parameters for each list ( and (<= 5 a-list) (>= 95 a-list)) to return false
                                [(and (<= 5 (first a-list)) (>= 95 (first a-list))) false]

;;then if first a-list member is actually true it will continue to the recursive definition
;; ( check-range1 (rest a-list))
                                  [else (check-range1 (rest a-list))]


      ;; test example :(check-range1 (cons 10 (cons 20 (cons 75 empty))))
      ;; test example :(check-range1 (cons 100 (cons 10 empty)))


;;Exercise 9.5.6
;; to compute the difference between two inventory lists and return positive if there is an increase or negative if a decrease 

    ;;First create auxillary functions the add the values of a-list and b-list
      (define (sum-of-a-list a-list) (cond
                                [(empty? a-list) 0]
                                [ else ( + (first a-list) 
                                      (sum-of-a-list (rest a-list)))]))

      (define (sum-of-b-list b-list) (cond
                                 [(empty? b-list) 0]
                                 [ else (+ (first b-list) (sum-of-b-list (rest b-list)))]))

;; to find the difference and return positive or negative
      (define (delta a-list b-list) (cond
                                [(empty? a-list b-list) true]
                                [(> (sum-of-a-list) (sum-of-b-list)) positive]
                                [ else negative]))

;;Functions that produce lists
      ;;hours -> wages : list-of-numbers -> list-of-numbers
      ;; to create a list of weekly wages from a list of hours worked by employees
      (define (wages hours) (* 12 hours))
      
      (define (hours-to-wages a-list) (cond
                                        [(empty? a-list) empty]
                                        [else (cons (wages (first a-list)) (hours-to-wages (rest a-list)))]))

;;Exercise 10.1.2
  ;; no employee should work more than 100 hours, to return error message if one of them does
    (define (check-hours hours) (cond
                                   [(> 100 a-list)]
                                   [else (error 'a-list "hours exceed legal requirement")]))

    ;; redefine hours-to-wages definition
    (define (hours-to-wages a-list) (cond
                                      [(empty? a-list) 0]
                                      [else (cons (check-hours (first a-list)) (hours-to-wages (rest a-list)))]))
;;Exercise 10.1.3
    ;;convert list if farenheit to celisius list of numbers

    ;;define the function that converts convertfc : list of numbers -> list of numbers = f -> c
    (define (convert-to-celsius farenheit) (( * (- farenheit 32) (5/9))))
    
    (define (convert-list f-list) (cond
                                          [(empty? f-list) empty]
                                          [else (cons (convert-to-celsius (first f-list))(convert-list (rest f-list)))]))
;;Exercise 10.1.5
    ;; eliminate items (toys) from list that exceeds/equal to number (ua)
    ;; eliminate-exp : list of toys -> list of toys

      ;;develop auxillary function i.e. too-expensive
      (define ua ...)
      (define (too-expensive toy) (<= ua toy))

       ;;template for creating list from a list
        ;;(define (eliminate-exp lotp) (cond
                                         ;;[(empty? t-list) true]
                                         ;;[ else (first lotp) ... (rest lotp)...]))

      (define (eliminate-exp lotp) (cond
                                     [(empty? lotp) true]
                                     [else (cons (too-expensive (first lotp))) (eliminate-exp (rest lotp))]))