;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname designing_algorithms) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp") (lib "gui.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp") (lib "gui.rkt" "teachpack" "htdp")) #f)))
;; Designing algorithms

;;exercise 26.0.7
;;what is the trivally solvable problem for moving balls exercise?
  ;; different way to move the ball but wanting it to be from x to y

;; what is the corresponding solution?
  ;; a function that can generate the ball in canvas to move 

;; how do we generate new problems that are sovable compared to original?
  ;; make smaller solution first drawing and clearing a ball, then moving the ball, developing an out-of-bounds so that the next ball can move

;;is there one new problem or several that we generate?
  ;;several as mentioned above

;; is the solution to the smaller problems same with original or do we combine solutions?
  ;;the combination of all functions allow the balls to move from one area to the other as well as stop when all are out of bounds


;;exercise 26.0.8
;;what is the trivally solvable problem for quick-sort exercise?
  ;; sorting a list of numbers 
 
;; what is the corresponding solution?
  ;; a function that takes in a list and sort from ascending or descending order

;; how do we generate new problems that are sovable compared to original?
  ;; create the list into a smaller one and organise it in smaller and larger than index

;;is there one new problem or several that we generate?
  ;; several

;; is the solution to the smaller problems same with original or do we combine solutions?
  ;; it is the same on a smaller scale but will need to combine so that the input is equal to the ouput


;;exercise 26.1.2

(define list-num (list 2 5 9 3))

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


;;merge-sort : list -> list

;;make-singles : list -> listof one-items
;; breaking down each item into its own list
(define (make-singles n lst) (cond
                                [(empty? lst) empty]
                                [(< (length lst) n) (list lst)]
                                [else (cons (my-take lst n) (make-singles n (my-drop lst n)))]))

(define (my-take lst n) (if (> n 0)
                            (cons (first lst) (my-take (rest lst) (sub1 n))) '()))

(define (my-drop lst n) (if (> n 0) (my-drop (rest lst) (sub1 n)) lst))


;;test
(make-singles 1 list-num)
(make-singles 3 list-num)

;;merge-all-neighbours : listof one-items -> list
(define (merging list) (cond
                         [(empty? list) empty]
                         [else (append (first list) (merging (rest list)))]))

;;test
(merging (list (list 2) (list 5) (list 9) (list 3)))
(merging (list (list 2 5 9) (list 3)))

;;merge-sort
(define (sort-list alon) (cond
                           [(empty? alon) empty]
                           [(cons? alon) (insert (first alon) (sort-list (rest alon)))]))

(define (insert n alon) (cond
                          [(empty? alon) (cons n empty)]
                          [(< n (first alon)) (cons n alon)]
                          [(>= n (first alon)) (cons (first alon) (insert n (rest alon)))]))

(define (merge-sort list) (cond
                            [(empty? list) empty]
                            [else (merging (make-singles 1 (sort-list list)))]))

;;test
(merge-sort (list 4 7 1 1 9))
