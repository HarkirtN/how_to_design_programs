;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname section32) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp") (lib "gui.rkt" "teachpack" "htdp") (lib "graphing.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp") (lib "gui.rkt" "teachpack" "htdp") (lib "graphing.rkt" "teachpack" "htdp")) #f)))
;;section 32
(define-struct child (father mother name date eyes))

;; all-blue-eyed-ancestors ; tree -> (listof symbols)
;; to construct a list of all-blue-eyed ancestors in tree
(define (all-blue-eyed-ancestors a-tree) (cond
                                           [(empty? a-tree) empty]
                                           [else (local ((define in-parents
                                                           (append (all-blue-eyed-ancestors (child-father a-tree))
                                                                   (all-blue-eyed-ancestors (child-mother a-tree)))))
                                                   (cond
                                                     [(symbol=? (child-eyes a-tree) 'blue) (cons (child-name a-tree) in-parents)]
                                                     [else in-parents]))]))

;;this can be made into a accumulator function because it have two natural recursions, where it needs to tally the
;;names of all ancestors with blue-eyes in father & mother tree
;;(define (all-blue-eyed-ancestors1 a-tree0) (local (;;accumulator
                                               ;;  (define (all-a a-tree accu) (cond
                                                                            ;;   [(empty? a-tree) ...]
                                                                            ;;   [else (local ((define in-parents
                                                                                            ;;   (all-a ... (child-father a-tree)... accu...)
                                                                                            ;;   (all-a ... (child-mother a-tree)... accu...)))
                                                                                  ;;     (cond
                                                                                  ;;       [(symbol=? (child-eyes a-tree) 'blue) (cons (child-name a-tree) in-parents)]
                                                                                  ;;       [else in-parents]))])))
                                        ;;   (all-a a-tree0 ...)))

;; purpose of the accumulator is to remember knowledge that all-a loses as it transverses the tree
;; when it processes child-father is has no knowledge of child father and vice-versa
;; two-options - accu coul represent all-blue-eyed ancestors encountered so far, incl mother when decending into father tree
              ;; alternative accu remembers everything

(define (all-blue-eyed-ancestors2 a-tree00) (local (;;accumulator is a list of blue-eyed ancestors encountered on mother's side
                                                 (define (all-a0 a-tree accu) (cond
                                                                               [(empty? a-tree) accu]
                                                                               [else (local ((define in-parents0
                                                                                               (all-a0 (child-father a-tree) ;; create new accu with both sides
                                                                                                      (all-a0 (child-mother a-tree) accu))) ;; collect mothers side first
                                                                                       (cond
                                                                                         [(symbol=? (child-eyes a-tree) 'blue) (cons (child-name a-tree) in-parents0)]
                                                                                         [else in-parents0])))])))
                                           (all-a0 a-tree00 empty))) ;; empty because it has not seen any nodes

;; alternative remembers everything 
(define (all-blue-eyed-ancestors3 a-tree000) (local (;; todo list if family tree not encountered but not processed
                                                 (define (all-a00 a-tree todo) (cond
                                                                               [(empty? a-tree) (cond
                                                                                                  [(empty? todo) empty]
                                                                                                  [else (all-a00 (first todo) (rest todo))])];; todo represents what's left to process,
                                                                                                          ;; if its a list then pick (first item) to process 
                                                                               [else (local ((define in-parents00
                                                                                               (all-a (child-father a-tree)
                                                                                               (all-a (child-mother a-tree) todo))))
                                                                                       (cond
                                                                                         [(symbol=? (child-eyes a-tree) 'blue) (cons (child-name a-tree) in-parents00)]
                                                                                         [else in-parents00]))])))
                                           (all-a00 a-tree000 empty)))

;; exercise 32.1.1
(lambda (x) y) ;; x is bound to y
((lambda (x) x) (lambda (x) x)) ;; x is bound with primary x, then the results are bound
(((lambda (y) (lambda (x) y)) ;; x with y then the result bound with x from other lambda
  (lambda (z) z)) ;; z bound with z then bound with first two lambdas
 (lambda (w) w)) ;; w is bound with w then result of the rest lambda

;; exercise 32.1.2
;; free-or-bound : lambda -> lambda
;; to replace each non-binding occurence of a variable in a-lambda
;; with free or bound depending on the occurence
(define (free-or-bound f0) (local (;; in-f is a list of functions that have been occured similar to a list
                                   (define in-f (...)))))



