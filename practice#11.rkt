;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname practice#11) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp")) #f)))
;;composing functions
;;sort a list in a descending order
;; auxiallry function to insert the first element in the right order
(define (insert n alon) (cond
                          [(empty? alon) (cons n empty)]
                          [else (cond
                                  [(>= n (first alon)) (cons n alon)]
                                  [(< n (first alon)) (cons (first alon)(insert n (rest alon)))])]))

(define (sort alon) (cond
                      [(empty? alon) empty]
                      [(cons? alon)(insert (first alon)(sort (rest alon)))]))

;;exercise 12.2.1
(define-struct mail (from date message))

(define (insert-date n alon) (cond
                               [(empty? alon) (cons n empty)]
                               [else (cond
                                       [(>= n (mail-date (first alon))) (cons n alon)]
                                       [(< n (mail-date (first alon))) (cons (mail-date (first alon)) (insert-date n (rest alon)))])]))

(define (sort-date alon) (cond
                           [(empty? alon) empty]
                           [(cons? alon) (insert-date (mail-date (first alon)) (sort-date (rest alon)))]))



;; function for alphabetical order of message
(define (insert-alpha n alol) (cond
                                [(empty? alol) (cons n empty)]
                                [else
                                 (cond
                                        [(string>=? n (mail-from (first alol))) (cons n alol)]
                                        [(string<? n (mail-from (first alol))) (cons (mail-from (first alol)) (insert-alpha n (rest alol)))])]))

(define (sort-alpha alol) (cond
                            [(empty? alol) empty]
                            [(cons? alol)(insert-alpha (mail-from (first alol)) (sort-alpha (rest alol)))]))

;;Exercise 12.2.2
;;search-sorted: number list -> boolean
(define (search-sorted n alon) (cond
                                 [(empty? alon) false]
                                 [else (or (= (first alon) n) (search-sorted n (rest alon)))]))


;;test
(search-sorted 7 (cons 3 (cons 7 (cons 8 empty))))

;; Exercise 12.4
;;Draw a poly gon

;;auxillary code for connecting dots, however they do not connect the first posn with last - another function will need to be made
(define (connect-dots alop) (cond
                               [(empty? (rest alop)) true]
                               ;; return true and exit because it cannot draw with empty as a polygon always needs a posn
                               [else (and (draw-solid-line (first alop) (second alop) 'red) (connect-dots (rest alop)))]))

;;second is finding the last posn
(define (last alop) (cond
                      [(empty? (rest alop)) (first alop)]
                      [else (last (rest alop))]))

;;then add altogether
(define (draw-polygon alop) (connect-dots (cons (last alop) alop)))

;;exercise 12.3.1
;;modify draw polygon so it adds the first element with last
;;auxillary function
(define (add-at-end alop) (cond
                            [(empty? alop) true]
                            [else (cons (make-posn (last alop) (first alop)) (rest alop))]))
;;test
(add-at-end (cons (make-posn 10 20) (cons (make-posn 3 4) (cons (make-posn 6 6) empty))))

;;modified draw-polygon
(define (draw-polygon2 alop) (connect-dots (cons (add-at-end alop) alop)))

;;exercise 12.3.2
(define (connect-dots2 alop) (cond
                               [(empty? (rest alop)) true]
                               [else (and
                                      (and (draw-solid-line (first alop) (second alop) 'red) (connect-dots2 (rest alop)))
                                      (draw-solid-line (last alop) (first alop) 'red))]))
  ;;test
  ;;(start 300 300)
  ;;(connect-dots2 (cons (make-posn 10 10) (cons (make-posn 60 60) (cons (make-posn 10 60) empty))))

(define (draw-polygon3 alop) (connect-dots2 (cons (last alop) alop)))

  ;;test
  ;;(start 300 300)
  ;;(draw-polygon (cons (make-posn 10 10) (cons (make-posn 60 60) (cons (make-posn 10 60) empty))))

;;exercise 12.4.1
;;data def: list of words is either
;;1) empty ,or
;;2) (list (cons a (cons w) (cons w empty) where it is a a grouping of words using symbols 

   ;;i.e (list (cons 'd (cons 'e (cons 'r empty)))
(define (arrangements a-word) (cond
                               [(empty? a-word) (cons empty empty)]
                               [else (first a-word) (arrangements (rest a-word))]))

;;i.e. ('red (cons 'r (cons 'e (cons 'd empty)))) = word
  ;;i.e. (list ( cons ('red (cons 'r (cons 'e (cons 'd empty))) (cons 'blue (cons 'b (cons 'l (cons 'u (cons 'e empty))))) empty)