;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname section25) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp") (lib "gui.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp") (lib "gui.rkt" "teachpack" "htdp")) #f)))
;;section 25 quickly sorting
;; uses the first item on the list as a pivot then the rest of the list is compared
;; if its small it will be arrange to one side and larger than pivot then to the other side

;;i.e.
(list 11 9 2 18 12 14 4 1)
;;quick sort works like this
(list 9 2 4 1) (list 11) (list 18 12 14)
                ;; pivot

;;then it will continue to sort using the first item
(list 2 4 1 ) (list 9)
              ;; pivot

(list 1) (list 2) (list 4) (list 9) ;;= appended (list 1 2 4 9)
         ;; pivot 2

;;same for other side
(list 18 12 14)
(list 12 14) (list 18) ;;= appended (list 12 14 18)
             ;;pivot

;;altogether
(list 1 2 4 8 11 12 14 18)

;;to write this as generative functions where smaller function allow us to solve the bigger problem
(define (quickly-sort alon) (cond
                              [(empty? alon) empty]
                              [else (append (quickly-sort (small-items-of-pivot alon (first alon))) (list (first alon))
                                             (quickly-sort (large-items-of-pivot alon (first alon))))]))

(define (small-items-of-pivot alon threshold) (cond
                                                [(empty? alon) empty]
                                                [else (if (< (first alon) threshold) (cons (first alon) (small-items-of-pivot (rest alon) threshold))
                                                                            (small-items-of-pivot (rest alon) threshold))]))

(define (large-items-of-pivot alon threshold) (cond
                                                [(empty? alon) empty]
                                                [else (if (> (first alon) threshold) (cons (first alon) (large-items-of-pivot (rest alon) threshold))
                                                                            (large-items-of-pivot (rest alon) threshold))]))

;;test
(quickly-sort (list 11 9 2 18 12 14 4 1)) ;; = (list 1 2 4 8 11 12 14 18)

;;exercise 25.2.3
;;use sort function for a smaller list as there is no need for "divide/conquer" use linear search
(define (quick-small alon) (cond
                             [(empty? alon) empty]
                             [else (insert-small (first alon) (quick-small (rest alon)))]))

(define (insert-small alon threshold) (cond
                                        [(empty? alon) (cons threshold empty)]
                                        [else (cond
                                                [(>= threshold (first alon)) (cons threshold (alon))]
                                                [(< threshold (first alon)) (cons (first alon) (insert-small threshold (rest alon)))])]))

;;to keep duplicate within the list
(define (equal-items-of-pivot alon) (cond
                                     [(empty? alon) empty]
                                     [(= (first alon) (first alon)) (cons (first alon) (equal-items-of-pivot (rest alon)))]))

;;test
;;(equal-items-of-pivot (list 3 6 3 7 1 1))

(define (keep-same alon) (cond
                           [(empty? alon) empty]
                           [else (append (equal-items-of-pivot (small-items-of-pivot alon (first alon))) (keep-same (rest alon)))]))

;;(keep-same (list 3 6 3 7 1 1))

;;exercise 25.2.5
;; use filter to define small and large items as one liners
(define (filter1 rel-op alon t) (cond
                                  [(empty? alon) empty]
                                  [else (cond
                                          [(rel-op (first alon) t) (cons (first alon) (filter1 rel-op (rest alon) t))]
                                          [else (filter1 rel-op (rest alon) t)])]))

(define (smaller-number alon TH) (filter1 < alon TH))

;;test
(smaller-number (list 3 6 3 7 1 1) 3)

;;OR
(define (filter2 rel-op) (local ((define (func-abs alist t) (cond
                                                              [(empty? alist) empty]
                                                              [else (cond
                                                                      [(rel-op (first alist) t) (cons (first alist) (func-abs (rest alist) t))]
                                                                      [else (func-abs (rest alist) t)])])))
                           func-abs))

(define smallest-nums (filter2 <))

;;test
;;doesnt work
(smallest-nums (list 5 6 3 2 19 5))

;;(define small (lambda (x y) (< x y)))

;;(quicksort '(3 4 5 6 7) (lambda (x y) (= x 6)))

;;(define even '( 2 3 6 10 1 1))
;;(filter (lambda (x) (zero? (remainder x 2))) even) which provide all even numbers

;; trying to experiment with filter
(define (filter-list predicate? list) (cond
                                       [(empty? list) empty]
                                       [else (cond
                                               [(predicate? (first list))(cons (first list) (filter-list predicate? (rest list)))]
                                               [else (filter-list predicate? (rest list))])]))


;;test
;;(filter-list (lambda (x y) (< x y)) (list 3 2 1 1 7 3))


