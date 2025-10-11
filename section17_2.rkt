;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname section17_2) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
;;section 17 cont...
(define (web=? wb1 wb2) (cond
                          [(empty? wb1) (empty? wb2)]
                          [(symbol? (first wb1)) (and (and (cons? wb2) (symbol? (first wb2)))
                                                      (and (symbol=? (first wb1) (first wb2)) (web=? (rest wb1) (rest wb2))))]
                          [else (and (and (cons? wb2) (list? (first wb2)))
                                     (and (web=? (first wb1) (first wb2)) (web=? (rest wb1) (rest wb2))))]))
;;exercise 17.8.7
;;posn=? : bt bt -> boolean
;; to determine whether two binary posn structure are equal
;; data definition a posn binary structure is either ->   posn                           
                                        ;;               /     \
                                        ;;            empty    posn
                                        ;;                      /  \
                                        ;;                 posn     posn

                                        ;;                posn
                                        ;;               /     \
                                        ;;            empty    posn
                                        ;;                      /  \
                                        ;;                 posn     posn


(define (posn=? bt1 bt2) (cond
                         [(empty? bt1) (empty? bt2)]
                         [(posn? (first bt1)) (and (and (cons? bt2) (posn? (first bt2)))
                                              (and (= (first bt1) (first bt2)) (posn=? (rest bt1) (rest bt2))))]))
                      

;;exercise 17.8.8
;; tree=? : binary-tree binary-tree -> boolean
;; empty
;; node node
;; subtree (left right) subtree (left right)

(define (tree=? bt1 bt2)(cond
                          [(empty? bt1) (empty? bt2)]
                         [(and (cons? (first bt1)) (cons? bt2))
                                              (and (= (first bt1) (first bt2)) (tree=? (rest bt1) (rest bt2)))]
                         [else (and (and (cons? bt2) (list? (first bt2)))
                               (and (tree=? (first bt1) (first bt2))
                                    (tree=? (rest bt1) (rest bt2))))]))

(define (slist=? st1 st2) (cond
                            [(empty? st1) (empty? st2)]
                            [else (cond
                                    [(number? st1) (and (and (cons? st2) (number? st2))
                                                   (and (= (first st1) (first st2))
                                                        (slist=? (rest st1) (rest st2))))]
                                    [(boolean? st1) (and (and (cons? st2) (boolean? st2))
                                                   (and (= (first st1) (first st2))
                                                        (slist=? (rest st1) (rest st2))))]
                                    [(symbol? st1) (and (and (cons? st2) (symbol? st2))
                                                   (and (= (first st1) (first st2))
                                                        (slist=? (rest st1) (rest st2))))]
                                    [else (and (and (cons? st2) (list st2))
                                               (and (slist=? (first st1) (first st2))
                                                    (slist=? (rest st1) (rest st2))))])]))

;;exercise 17.8.10
(define (list=? list1 list2) (cond
                               [(and (empty? list1) (empty? list2)) true]
                               [(or (empty? list1) (empty? list2)) false]
                               [else (and (= (first list1) (first list2)) (list=? (rest list1) (rest list2)))]))

;;(define (testhours-wage list1 list2 expected value) (cond
                                                      ;;[(list=? (hours-wages list1 list2) expected-result) true]
                                                      ;;[else (list "bad test result:" list1 list2 expected-result)]))

(define (replace-with list1 list2) (cond
                                     [(empty? list1) empty]
                                     [(empty? list2) empty]
                                     [else (cons (+ (first list1) (first list2)) (replace-with (rest list1) (rest list2)))]))

(define (test-replace list1 list2 expected-result) (cond
                                                     [(equal? (replace-with list1 list2) expected-result) true]
                                                     [else (list "incorrect" list1 list2 expected-result)]))

;;test
(replace-with (cons 3 (cons 3 (cons 3 empty))) (cons 1 (cons 2 (cons 3 empty))))
(test-replace (cons 3 (cons 3 (cons 3 empty))) (cons 1 (cons 2 (cons 3 empty))) (list 4 5 6))

;;exercise 17.8.11
(define (list-pick alos n) (cond
                                 [(empty? alos) (error 'list-pick "list too short")]
                                 [(= n 1) (first alos)]
                                 [(> n 1) (list-pick (rest alos) (sub1 n))]))

(define (test-list-pick alon n expected-result) (cond
                                       [(equal? (list-pick alon n) expected-result) true]
                                       [else (list "incorrect" alon n expected-result)]))

;;test
(list-pick (list 1 2 3) 1)
(list-pick (list 1 2 3) 3)
(test-list-pick (list 1 2 3) 3 3)