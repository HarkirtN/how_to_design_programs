;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname fingerexercises_7) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
;;finger exercises 7

;;replace-at-end : list-numbers list-numbers -> list-numbers
;;to construct a new list by replacing empty in alon1 with alon2
(define (replace-at-end alon1 alon2) (cond
                                       [(empty? alon1) alon2]
                                       [else (cons (first alon1) (replace-at-end (rest alon1) alon2))]))

(define (our-append alon1 alon2) (cond
                                   [(empty? alon1) alon2]
                                   [else (append (cons (first alon1) (our-append (rest alon1) alon2)))]))

;;test
(our-append (list 'a 'b) (list 'c 'd 'e))


;;cross : list-symbols list-numbers -> list
(define (crossed los lon) (cond
                          [(empty? los) lon]
                          [(empty? lon) los]
                          [else (cons (first los) (cons (first lon) (crossed los lon)))]))

;;test
;;(crossed '(a b c) '(1 2))

;; ZIP : list-names list-phones -> records
;; combines lists of names and numbers to create a list of records
(define-struct record (name number))

(define (zip list1 list2) (cond
                           [(empty? list1) empty]
                           [else (cons (make-record (first list1) (first list2)) (zip (rest list1) (rest list2)))]))

;;test
(zip (list 'a 'b 'c 'd 'e) (list 1 2 3 4 5))

;;merge : list1 list2 -> list3
(define (sort-list alon) (cond
                           [(empty? alon) empty]
                           [(cons? alon) (insert (first alon) (sort-list (rest alon)))]))

(define (insert n alon) (cond
                          [(empty? alon) (cons n empty)]
                          [(< n (first alon)) (cons n alon)]
                          [(>= n (first alon)) (cons (first alon) (insert n (rest alon)))]))

(define (create-list list1 list2) (cond
                                    [(empty? list1) empty]
                                    [else (cons (first list1) (create-list (rest list1) list2))]))

(define (merge list1 list2) (cond
                              [(or (empty? list1) (empty? list2)) (error 'merge "empty list")]
                              [else (sort-list (create-list list1 list2))]))

;;test
(merge (list 1 7 9 3 5 4) (list 4 7 8 2))

;; gift-pick : list-symbols -> symbol
(define (arrangements word) (cond
                              [(empty? word) (cons empty empty)]
                              [else (insert-word (first word) (arrangements (rest word)))]))

(define (insert-word s list) (cond
                               [(empty? list) (cons empty empty)]
                               [(string<? s (first list)) (cons s list)]
                               [(string>=? s (first list)) (cons (first list) (insert-word s (rest list)))]))

;;test
;;(insert-word 'd (cons (cons 'e (cons 'r empty)) (cons (cons 'r (cons 'e empty)) empty)))
(define-struct star (name instrument))

(define (last-occurence s alos) (cond
                                  [(empty? alos) false]
                                  [else (local ((define m (last-occurence s (rest alos))))
                                          (cond
                                          [(star? m) m]
                                          [(symbol=? s (star-name (first alos))) (first alos)]
                                          [else false]))]))

(define (maxm alon) (cond
                     [(empty? (rest alon)) (first alon)]
                     [else (local ((define n (maxm (rest alon))))
                             [(> (first alon) n) (first alon)]
                             [else n])]))

(define (minm alon) (cond
                     [(empty? (rest alon)) (first alon)]
                     [else (local ((define s (minm (rest alon))))
                             [(< (first alon) s) (first alon)]
                             [else s])]))

;;functional abstraction
(define (check-number rel-op alon) (cond
                                     [(empty? (rest alon)) (first alon)]
                                     [else (local ((define any (check-number rel-op (rest alon))))
                                             [(rel-op (first alon) any) (first alon)]
                                             [else any])]))

(define (last non-empty) (cond
                           [(empty? non-empty) false]
                           [else (local ((define u (last (rest non-empty))))
                                   (cond
                                   [(cons? u) u]
                                   [(false? u) (first non-empty)]
                                   [else false]))]))