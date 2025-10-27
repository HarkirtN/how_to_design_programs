;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname fingerexercises_5) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
;;finger exercises
(define-struct child (father mother name date eyes))

;;older gen
(define carl (make-child empty empty 'carl 1926 'blue))
(define dorothy (make-child empty empty 'dorothy 1926 'blue))

;;mid gen
(define adam (make-child carl dorothy 'adam 1950 'green))
(define maggie (make-child carl dorothy 'maggie 1965 'green))
(define gen (make-child empty empty 'gen 1967 'brown))

;;young gen
(define gustav (make-child adam gen 'gustav 1988 'brown))

;;we recurse into the embedded parts of a function definition i.e.
;;(define (fun-for-tree a-tree) (cond
                               ;; [(empty? a-tree) empty]
                               ;; [else (cond
                                      ;;  [(fun-for-tree (child-father a-tree))...]
                                      ;;  [(fun-for-tree (child-mother a-tree))...]
                                      ;;  [(child-name a-tree)...]
                                      ;;  [(child-date a-tree)...]
                                      ;;  [(child-eyes a-tree)]...)]))

;;blued-eyed-ancestor? : a-tree -> boolean
(define (blue-eyed-ancestor? a-tree) (cond
                                       [(empty? a-tree) false]
                                       [else (cond
                                               [(symbol=? 'blue (child-eyes a-tree)) true]
                                               [(blue-eyed-ancestor? (child-father a-tree)) true]
                                               [(blue-eyed-ancestor? (child-mother a-tree)) true]
                                               [else false])]))

;;average-age : a-tree -> number
;;to compute the average age of all people in the tree, but im attempting to do local expression 

(define (average-age a-tree) (local ((define (count-people a-tree) (cond
                                                                      [(empty? a-tree) 0]
                                                                      [else (+ 1 (count-people (child-father a-tree)) (count-people (child-father a-tree)))]))
                                     (define (total-age a-tree) (cond
                                                                  [(empty? a-tree) 0]
                                                                  [else ( + (- 2025 (child-date a-tree)) (total-age (child-father a-tree)) (total-age (child-mother a-tree)))])))
                               (cond
                                 [(empty? a-tree) 0]
                                 [else ( / (total-age a-tree) (count-people a-tree))])))

(define (eye-colours a-tree) (cond
                               [(empty? a-tree) empty]
                               [else (list (child-eyes a-tree) (eye-colours (child-mother a-tree)) (eye-colours (child-father a-tree)))]))

;;test
(eye-colours dorothy)
(append (eye-colours adam))

;;for bonary trees instead of empty should choose false
(define-struct node (ssn name left right))

;;contains-bt? : node number -> boolean
;;to search the binary tree
(define (contains-bt? n node) (cond
                              [(false? node) false]
                              [(= n (node-ssn node)) true]
                              [else false]))

;; search-bt : node number -> symbol
;;to search the binary tree for number and then produce name of the node 
(define (search-bt n node)(cond
                             [(false? node) empty]
                             [(contains-bt? n node) (node-name node)]
                             [(contains-bt? n (node-left node)) (node-name node)]
                             [(contains-bt? n (node-right node)) (node-name node)]
                             [else false]))

;;test
(search-bt 77 (make-node 63 'd
                    (make-node 29 'c
                               (make-node 15 'b
                                          (make-node 10 'a false false)(make-node 24 'aa false false))false)
                    (make-node 89 'cc
                                (make-node 77 'bb false false) (make-node 95 'bbb
                                                                          (make-node 99 'dd false false) false))))

