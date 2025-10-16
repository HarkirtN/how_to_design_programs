;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname section19.1) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
;;section 19
;;functional abstraction is the process of combining two related function into a single one

;;contains-doll? : los -> boolean
;;computes whether alos contains doll
(define (contains-doll? alos) (cond
                                [(empty? alos) false]
                                [(symbol=? 'doll (first alos)) true]
                                [else (contains-doll? (rest alos))]))

(define (contains-car? alos) (cond
                                [(empty? alos) false]
                                [(symbol=? 'car (first alos)) true]
                                [else (contains-car? (rest alos))]))

;;both of which can be combined to a general function
(define (contains? s alos) (cond
                                [(empty? alos) false]
                                [(symbol=? s (first alos)) true]
                                [else (contains? s (rest alos))]))

;;below : lon -> lon
;;to construct a list of numbers that are below t from the alos
(define (below alon t) (cond
                         [(empty? alon) empty]
                         [else (cond
                                 [(< (first alon) t) (cons (first alon) (below (rest alon)))]
                                 [else (below (rest alon))])]))

(define (above alon t) (cond
                         [(empty? alon) empty]
                         [else (cond
                                 [(> (first alon) t) (cons (first alon) (above (rest alon)))]
                                 [else (above (rest alon))])]))

;;can be combined to the following by adding rel-op which can be the < or >
(define (filter1 rel-op alon t) (cond
                                  [(empty? alon) empty]
                                  [else (cond
                                          [(rel-op (first alon) t) (cons (first alon) (filter1 rel-op (rest alon) t))]
                                          [else (filter1 rel-op (rest alon) t)])]))

;;then you can also assign below and above to the specific functions pattern
  ;; below1 can be (define (below1 alon t) (filter1 < alon t)) AND
  ;; above1 can be (define (above1 alon t) (filter1 > alon t))
     ;;filter1 can be applied to other expressions i.e.
                   ;; (filter1 = alon t) extract all numbers = to t

;;filter1 can be inserted into other functions that follow similar pattern
(define (squared>? x c) (> (* x x) c))
(filter1 squared>? (list 1 2 3 4 5) 10)

;;using a local expression
(define (filter11 rel-op alon t) (cond
                                  [(empty? alon) empty]
                                  [else (local ((define first-item (first alon))
                                                (define rest-filtered (filter11 rel-op (rest alon) t)))
                                          (cond
                                          [(rel-op first-item t) (cons first-item rest-filtered)]
                                          [else rest-filtered]))]))

;;exercise 19.1.5
;;abstract the following two functions into a generalised function
(define (mini alon) (cond
                      [(empty? (rest alon)) (first alon)]
                      [else (cond
                         [(< (first alon) (mini (rest alon))) (first alon)]
                         [else (mini (rest alon))])]))

(define (maxi alon) (cond
                      [(empty? (rest alon)) (first alon)]
                      [else (cond
                         [(> (first alon) (maxi (rest alon))) (first alon)]
                         [else (maxi (rest alon))])]))

;;abstraction
(define (check-number rel-op alon) (cond
                                     [(empty? (rest alon)) (first alon)]
                                     [else (cond
                                             [(rel-op (first alon) (check-number rel-op (rest alon))) (first alon)]
                                             [else (check-number rel-op (rest alon))])]))

(define (mini1 alon) (check-number < alon))
(define (maxi1 alon) (check-number > alon))

;;test
(mini (list 3 7 6 2 9 8))
(maxi (list 3 7 6 2 9 8))
(mini1 (list 3 7 6 2 9 8))
(maxi1 (list 3 7 6 2 9 8))
(check-number < (list 3 7 6 2 9 8))

;;add local definition for recursion
(define (check-number1 rel-op alon) (cond
                                     [(empty? (rest alon)) (first alon)]
                                     [else (local ((define rest-checked (check-number1 rel-op (rest alon))))
                                             (cond
                                             [(rel-op (first alon) rest-checked) (first alon)]
                                             [else rest-checked]))]))

;;exercise 19.1.6
(define (sorted alon) (local ((define (sorted alon) (cond
                                                  [(empty? alon) empty]
                                                  [else (insert (first alon) (sorted (rest alon)))]))
                            (define (insert an alon) (cond
                                                       [(empty? alon) (list an)]
                                                       [else (cond
                                                               [(> an (first alon)) (cons an alon)]
                                                               [else (cons (first alon) (insert an (rest alon)))])])))
                      (sort alon)))

;;abstract using comparison operator
(define (sort1 rel-op alon) (local ((define (sort1 alon) (cond
                                                  [(empty? alon) empty]
                                                  [else (insert1 rel-op (first alon) (sort1 (rest alon)))]))
                            (define (insert1 rel-op an alon) (cond
                                                       [(empty? alon) (list an)]
                                                       [else (cond
                                                               [(rel-op an (first alon)) (cons an alon)]
                                                               [else (cons (first alon) (insert1 rel-op an (rest alon)))])])))
                      (sort1 alon)))

;;test
(sort1 > (list 2 3 1 5 4))
(sort1 < (list 2 3 1 5 4))