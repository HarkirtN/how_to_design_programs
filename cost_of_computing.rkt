;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname cost_of_computing) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp") (lib "gui.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp") (lib "gui.rkt" "teachpack" "htdp")) #f)))
;;running time

;;looking at different functions and working out the run time
(define (how-many a-list) (cond
                            [(empty? a-list) 0]
                            [else (+ (how-many (rest a-list)) 1)]))

;;looking at run time by hand-evaluation
(how-many (list 'a 'b 'c))
;; = (+ (how-many (list 'b 'c)) 1)
;; = (+ (+ (how-many (list 'c)) 1 ) 1)
;; = (+ (+ ( + (how-many empty) 1) 1) 1)
;; 3

;;abstract running time is the relationship between the size of the input and number of natural recursions

(define (contains-doll? a-list) (cond
                                  [(empty? a-list) false]
                                  [else (cond
                                          [(symbol=? 'doll (first a-list)) true]
                                          [else (contains-doll? (rest a-list))])]))

;;hand evaluation
(contains-doll? (list 'doll 'robot 'ball 'game 'pokemon))
;; =  [(symbol=? 'doll (list 'doll))) true ]
;; =  [else (contains-doll? (list 'robot 'ball 'game 'pokemon)]
;; = true

(contains-doll? (list 'ball 'robot 'game 'pokemon 'doll))
;; =  [(symbol=? 'doll (list 'ball))) false ]
;; =  [else (contains-doll? (list 'robot 'game 'pokemon 'doll)]

;; =  [(symbol=? 'doll (list 'robot))) false ]
;; =  [else (contains-doll? (list 'game 'pokemon 'doll)]

;; =  [(symbol=? 'doll (list 'game))) false ]
;; =  [else (contains-doll? (list 'pokemon 'doll)]

;; =  [(symbol=? 'doll (list 'pokemon))) false ]
;; =  [else (contains-doll? (list 'doll)]

;; =  [(symbol=? 'doll (list 'doll))) true]
;; =  [else (contains-doll? (list empty)]

;;= true
;; it has done one recursion
;; takes about five times to find doll at the end of the list but that's worst case scenario
;; but it's good practice to consider on average likelihood to find 'doll, so somewhere in the middle of a list
;; therefore input of N items is half of that = N/2, it may recur half as often as the number of items

(define (sort-list alon) (cond
                           [(empty? alon) empty]
                           [else (insert (first alon) (sort-list (rest alon)))]))

(define (insert n alon) (cond
                          [(empty? alon) (cons n empty)]
                          [(< n (first alon)) (cons n alon)]
                          [(>= n (first alon)) (cons (first alon) (insert n (rest alon)))]))

;;hand-evaluation
(sort-list (list 3 1 2))
;; = [(empty? list) empty]
;; = (insert 3 (sort-list (list 1 2)))

;; = [(empty? list) empty]
;; = (insert 3 (insert 1 (sort-list (list 2))))

;; = [(empty? list) empty]
;; = (insert 3 (insert 1 (insert 2 (sort-list (list empty)))))

;; = [(empty? list) (cons 2 empty)]
;; = (insert 3 (insert 1) (cons 2 empty))

;; = [(empty? list) false]
;; = (insert 3 (cons 1 (cons 2 empty))

;; = [(empty? list) false]
;; = (insert 3 (list 1 2 empty))

;; = [(empty? list) false]
;; = (list 1 2 (cons 3 empty))

;; = (list 1 2 3)
;; one recursion but two functions are evaluated simultaneously we can say the running time is equivalent to N^2

(define (maxi alon) (cond
                      [(empty? (rest alon)) (first alon)]
                      [else (cond
                              [(> (maxi (rest alon)) (first alon)) (maxi (rest alon))]
                              [else (first alon)])]))

(maxi (list 0 1 2 3))
;; = [(> (maxi (list 1 2 3)) 0) (maxi (list 1 2 3))]
;; = [else 0]

;; = [(> (maxi (list 2 3)) 1) (maxi (list 2 3))]
;; = [else 1]

;; = [(> (maxi (list 3)) 2) (maxi (list 3))]
;; = [else 2]

;; = [(> (maxi (list empty)) 3) empty]
;; = [else 3]

;;requires 2 recursions in the first line so we are the doubling (x 2) and also returning the expression = 2^ N