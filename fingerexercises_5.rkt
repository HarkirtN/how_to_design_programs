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

;;creating a binary tree
(define par (make-node 2 'par false false))
(define hri (make-node 4 'hri false 'par))
(define kat (make-node 8 'kat false false))
(define ash (make-node 5 'ash 'kat 'hri))
(define root ash)

;;contains-bt? : node number -> boolean - first attempt again
;;to search the binary tree
;;(define (contains-bt? n node) (cond
                             ;; [(false? node) false]
                             ;; [(= n (node-ssn node)) true]
                             ;; [else false]))

;; search-bt : node number -> symbol first attempt again 
;;to search the binary tree for number and then produce name of the node 
;;(define (search-bt n node)(cond
                            ;; [(false? node) empty]
                            ;; [(contains-bt? n node) (node-name node)]
                            ;; [(contains-bt? n (node-left node)) (node-name node)]
                            ;; [(contains-bt? n (node-right node)) (node-name node)]
                            ;; [else false]))

(define (contains-bt? n node) (cond
                                [(false? node) empty]
                                [(= n (node-ssn node)) (node-name node)]
                                [else (local ((define search-left (contains-bt? n (node-left node)))
                                              (define search-right (contains-bt? n (node-right node))))
                                        (cond
                                          [(symbol? search-left) search-left]
                                          [(symbol? search-right) search-right]
                                          [else false]))]))

;;test
(contains-bt? 99 (make-node 63 'd
                    (make-node 29 'c
                               (make-node 15 'b
                                          (make-node 10 'a false false)(make-node 24 'aa false false))false)
                    (make-node 89 'cc
                                (make-node 77 'bb false false) (make-node 95 'bbb
                                                                          (make-node 99 'dd false false) false))))
;; in-order : BT -> list
;;so its saying recurse into the left till you get to the leaf then cons the ssn for left first then right 
(define (in-order a-tree) (cond
                            [(false? a-tree) empty]
                            [else (append (in-order (node-left a-tree)) (cons (node-ssn a-tree) (in-order (node-right a-tree))))]))
                                    
 ;;test
 (in-order (make-node 63 'd
                    (make-node 29 'c
                               (make-node 15 'b
                                          (make-node 10 'a false false)(make-node 24 'aa false false))false)
                    (make-node 89 'cc
                                (make-node 77 'bb false false) (make-node 95 'bbb
                                                                          (make-node 99 'dd false false) false))))

;;search-bst : BST (ordered) -> symbol
(define (search-bst? n a-tree) (cond
                               [(false? a-tree) empty]
                               [(= n (node-ssn a-tree)) (node-name a-tree)]
                               [else (local ((define left-search (search-bst? n (node-left a-tree)))
                                             (define right-search (search-bst? n (node-right a-tree))))
                                       (cond
                                         [(< n (node-ssn a-tree)) left-search]
                                         [else right-search]))]))
  ;;test
(search-bst? 95 (make-node 63 'd
                    (make-node 29 'c
                               (make-node 15 'b
                                          (make-node 10 'a false false)(make-node 24 'aa false false))false)
                    (make-node 89 'cc
                                (make-node 77 'bb false false) (make-node 95 'bbb
                                                                          (make-node 99 'dd false false) false))))

(define (create-bst? B N S) (cond
                              [(false? B) (make-node N S false false)]
                              [else (local ((define go-left (create-bst? (make-node N S B false) N S))
                                            (define go-right (create-bst? N S (make-node N S false B))))
                                      (cond
                                        [(< N B) go-left]
                                        [else go-right]))]))

;;test
(create-bst? false 66 'a)
(create-bst? (create-bst? false 66 'a) 53 'b) ;; should be (make-node 66 'a (make-node 53 'b false false) false)
