;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fingerexercises_3) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp")) #f)))
;;Finger exercises 3

;;checked functions

;;profit : number -> number
(define (profit ticket-price) (- (revenue ticket-price) (cost ticket-price)))
(define (revenue ticket-price) (* (attendees ticket-price) ticket-price))
(define (cost ticket-price) (+ 180 (* 0.04 (attendees ticket-price))))
(define (attendees ticket-price) (+ 120( / 15 .10(- 5.00 ticket-price))))

(define (checked-profit p) (cond
                             [(number? p) (profit p)]
                             [else (error 'checked-profit "expected number")]))

;;distance-to-0 : posn or number -> number
(define (distance-to-0 d) (cond
                            [(number? d) (distance-to-0 d)]
                            [(posn? d) (sqrt (+ (sqr (posn-x d) (posn-y d))))]))

(define (check-distance-to-0 d) (cond
                            [(number? d) (distance-to-0 d)]
                            [(posn? d) (distance-to-0 d)]
                            [else (error 'check-distance-to-0 "expected number or posn")]))

;; perimeter : shape -> number
(define-struct square (posn length))
(define-struct circle (centre radius))

(define (perimeter a-shape) (cond
                             [(square? a-shape) ( * (square-length a-shape) 4)]
                             [(circle? a-shape) ( * pi ( * 2 (circle-radius a-shape)))]))

(define (check-perimeter p) (cond
                              [(square? p) (perimeter p)]
                              [(circle? p) (perimeter p)]
                              [else (error 'check-perimeter "expected shape")]))

;;syntax and semantics
;;Notes:
       ;; three forms of definitions : Boolean expression (and /or statements with cond infront)
                                    ;; Variable definitions ( define variable expression ) the difference between that and function defs is where '()' are placed after 'define'
                                    ;; Structure definitions contain constructor (make-struct), selectors, predicates (c?) i.e. (define-struct shape ( variable x y z))

;; with variable definitions you want to define/outline the variable first prior to adding them into an expression i.e. first (define radius 5)
                                                                                                                   ;;   then (define diameter (* 2 radius))
                                                                                                                   ;;   then (define circumference (* 3.14 diameter))

;; predicates (?) can be applies to any value and return true or false depending on the match i.e symbol=? ('...) will only match with ('...) as since symbol are just atomic
;; structures with (') in the beggining


;; Lists
(define a-list (cons 'x (cons 'y (cons 'z empty))))
(define (add-up-3 a-list) (+ (first (rest (rest a-list)))))
;; goes from innermost to outer bracket i.e (first (rest l)) for (cons 10 (cons 20 (cons 5 empty))) = 20 so you are looking at first value of the rest of the bracket
;; as you keep seeing 'rest' you will need to 'jump' into the next bracket i.e same example with (first (rest (rest l))) = 5
;; almost reading it opposite to the function

(define-struct pair (left right))
;;(define (our-cons a-value a-list) (make-pair a-value a-list))
(define (our-first a-pair) (pair-left a-pair))
(define (our-rest a-pair) (pair-right a-pair))
(define (our-cons? x) (pair? x))
;; each definition checks that we have a list on the right hand side

;; our-cons we can refine to ensure that there is a continued list made, see below
(define (our-cons a-value a-list) (cond
                                    [(empty? a-list) (make-pair a-value a-list)]
                                    [(our-cons? a-list) (make-pair a-value a-list)]
                                    [else (error 'our-cons "expected list an second argument")]))

;;Lists of arbitrary length require a definition that refers to itself this is called recursive or self-referential
(define (list-of-symbols a-list)(cons 'bow (cons 'arrow (cons 'ball empty))))

;;data definition for list of boolean
;;list of booleans is either 1) empty OR 2) (cons b lob) where b is boolean condition, lob is list of booleans 
                      ;; [(empty? a-list) (cons a-list empty)]
                      ;; [(cons? a-list) (lob (cons a-list empty))]

;; to check inventory list for any doll
(define (contains-dolls? a-list) (cond
                                   [(empty? a-list) false]
                                   [else (cond
                                           [(or (symbol=? 'doll (first a-list)) (contains-dolls? (rest a-list))) true])]))

;;test
(contains-dolls? (cons 'arrow (cons 'doll empty)))

(define (contains? ball los)(cond
                                [(empty? los) false]
                                [else (cond
                                        [(or (symbol=? 'ball (first los)) (contains? 'ball (rest los))) true])]))

(contains? 'ball (cons 'bow (cons 'arrow (cons 'ball empty))))



;; Notes about second cond clause  
;; needs an additional cond clause because we are asking a question of the (first) item so we need nested condition
;; then (rest) to then exit out of the recursion; the OR simplifies the second 'else'
;; where as if it were to produce a number or create duplicate list it will not need a second cond clause

(define (many-symbols los) (cond
                             [(empty? los) empty]
                             [else (+ 1 (many-symbols (rest los)))]))

(define (many-numbers lon) (cond
                             [(empty? lon) empty]
                             [else (number? (first lon)(+ 1 (many-numbers (rest lon))))]))

;; they differ because the symbol could be anything therefore can be generalised to adding one and going through the (rest) list
;; whereas number you can place a predicate to check whether it is infact a number then +1 and move onto (rest lon)

;;to check whether all prices are below $1 - keyword 'ALL'
;; dollar-store? : list -> boolean
         (define (dollar-store? lon) (cond
                                       [(empty? lon) true]
                                       [else (cond
                                               [(< 1(first lon)) false]
                                               [else (dollar-store? (rest lon))])]))

;;to check whether a list of temperatures are all within range keyword 'ALL' which means we need to develop a function that detects those not in range
;; and exit if met
;; check-range1 : lot -> boolean

;;first draft 
          (define (check-range1 lot) (cond
                                       [(empty? lot) true]
                                       [else (cond
                                               [(or ( > 5 (first lot)) (< 95 (first lot))) false]
                                               [else (check-range1 (rest lot))])]))

;;or develop auxillary function for checking temperature
      (define (check-temperature temperature) (or (> 5 temperature) (< 95 temperature)))

;;then refined check-range1
            (define (check-range2 lot) (cond
                                         [(empty? lot) 'empty]
                                         [else (cond
                                                 [(check-temperature (first lot)) false]
                                                 [else (check-range2 (rest lot))])]))

;; create a function goes through a list of numbers and produces corresponding number 
  (define (convert lod) (cond
                          [(empty? lod) 0]
                          [else (+
                                 (* 10 (convert (rest lod)))
                                   (first lod))]))

;;test
   (convert (cons 1 (cons 2 (cons 3 (cons 4 (cons 199 empty))))))
;; [1, 2, 3, 4, 199] = 9914321
;; 199 x 10 = 1990
;; (1990 x 10) + (4 x 10)                                       = 19900 + 40           = 19940
;; (19900 x 10) + (40 x 10) + (3 x 10)                          = 199000 + 400 + 30     = 199430
;; (199000 x 10) + (400 x 10) + (30 x 10) + (2 x 10)            = 1990000 + 4000 + 300 + 20 = 1994320
;; second last bracket stops *10 then you just add (first lod)  = 1990000 + 4000 + 300 + 20 + 1 = 1994321

(define target 123)
(define (check-guess3 lod) (cond
                                    [(< target (+ (* 10 (check-guess3 (rest lod))) (first lod))) 'TooSmall]
                                    [(= target(+ (* 10 (check-guess3 (rest lod))) (first lod))) 'Perfect]
                                    [(> target ( + (* 10 ( check-guess3 (rest lod))) (first lod))) 'TooLarge]))
;; add-up-list : lon -> number
(define (add-up-list1 lon) (cond
                            [(empty? lon) 0]
                            [else (+ (first lon)
                                     (add-up-list1 (rest lon)))]))

(define (add-up-list2 lon) (cond
                             [(empty? lon) 0]
                             [else (+ (first lon)
                                      (add-up-list2 (rest lon)))]))

;; delta : list -> scheme symbol 
(define (delta lon1 lon2) (cond
                            [(and (empty? lon1) (empty? lon2)) 'empty]
                            [else (cond
                                     [(< (add-up-list1 lon1) (add-up-list2 lon2)) 'positive]
                                     [else 'negative])]))
;; test
(define list-a (cons 1 (cons 2 empty)))

(define list-b empty)

(add-up-list1 list-a)
(add-up-list2 list-b)
(delta list-a list-b)

;;average-price : lot -> number
;; to compute the average price by dividing the sum by number of toys

;;first auxillary functions
;; sum-of-toys : list -> number
(define (sum-of-toys lot) (cond
                            [(empty? lot) 0]
                            [else (+ (first lot) (sum-of-toys (rest lot)))]))

(define (number-of-toys lot) (cond
                               [(empty? lot) 0]
                               [else (+ 1 (number-of-toys (rest lot)))]))

   (define (checked-average-price lot) (cond
                                      [(cons? lot) (/ (sum-of-toys lot-price) (number-of-toys lot-price))]
                                      [else (error 'average-price "expected list")]))

            (define (average-price lot-price) (checked-average-price lot-price))


;;test
(define lot-price (cons 5.00 (cons 5.00 (cons 10.00 empty))))
(define lot-nothing empty)

(sum-of-toys lot-price)
(number-of-toys lot-price)


;;(average-price lot-nothing)

;;draw-circles : posn lon -> boolean
;; to check whether all circles in the list can be drawn keyword 'All'

(define (draw-circles posn lon) (cond
                                  [(empty? lon) 'empty]
                                  [(not (and (draw-circle posn (first lon) 'red)(draw-circles (rest lon)))) false]
                                  [else (error 'draw-circles "not all circles can fit")])
;;test

(start 300 300)


