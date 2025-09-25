;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname practice#12) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp")) #f)))
;;abbreviations for cons is a 'list' where it can combine all cons into one parentheses
;;exercise 13.0.3
(list 0 1 2 3 4 5)
(cons 0 (cons 1 (cons 2 (cons 3 (cons 4 (cons 5 empty))))))

(list (list 'adam 0) (list 'eve 1) (list 'louisXIV 2))
(cons (cons 'adam (cons 0 empty)) empty) (cons (cons 'eve (cons 1 empty)) empty) (cons (cons 'louisXIV (cons 2 empty)) empty)

;;exercise 13.0.4
(cons (cons 1 (cons 2 empty)) empty)
(list (list 1 2))

(cons (cons 1 (cons 2 empty)) (cons (cons 2 (cons 3 empty)) empty))
(list (list 1 2) (list 2 3))

;;exercise 13.0.5
(cons 'a (list 0 false))
(cons 'a (cons 0 (cons false empty)))

(list empty empty (cons 1 empty))
(cons empty (cons empty (cons (cons 1 empty) empty)))

;;exercise 13.0.7
(first (list 1 2 3)) ;; 1
(rest (list 1 2 3))  ;; (list 2 3)

;;shorthand for list is '()
;;i.e. '((1 2) (3 4) (5 6))
(list (list 1 2) (list 3 4) (list 5 6))

;;'((alan 1000) (barb 2000) (carl 1500) (dawn 2300))
(list (list 'alan 1000) (list 'barb 2000) (list 'carl 1500) (list 'dawn 2300))

;;self-referential occurs with lists and natural numbers
;;i.e family tree
(define-struct child (father mother name date eyes)) ;; father mother name date eyecolour

;;some info maybe empty i.e. mother's or father's parents, therefore
;; family tree node : empty or
                   ;; (make-child f m na da ec)

(make-child
    ;;father
      (make-child empty empty 'carl 1926 'green)
    ;;mother
      (make-child empty empty 'dorothy 1926 'green)
      'adam
      1950
      'green)

;;simplify mother and father cons so that it is easier for when we are creating children and garndchildren data
;;older gen
(define carl (make-child empty empty 'carl 1926 'blue))
(define dorothy (make-child empty empty 'dorothy 1926 'blue))

;;mid gen
(define adam (make-child carl dorothy 'adam 1950 'green))
(define maggie (make-child carl dorothy 'maggie 1965 'green))
(define gen (make-child empty empty 'gen 1967 'brown))

;;young gen
(define gustav (make-child adam gen 'gustav 1988 'brown))

;;template input for all selectors, plus it is a conditional statement as the structure could have empty or complete (make-child)
;;(define (fun-ftn a-tree) (cond
                          ;; [(empty? a-tree) ...]
                          ;; [else (child? a-tree)
                           ;;  ... (child-father a-tree)...
                           ;;  ... (child-mother a-tree)...
                           ;;  ... (child-name a-tree)...
                           ;;  ... (child-date a-tree)...
                           ;;  ... (child-eyes a-tree) ...]))

;;to determine whether someone in the family tree has blue eyes
(define (blue-eyes a-tree) (cond
                             [(empty? a-tree) false]
                             [else (cond
                                     [(symbol=? (child-eyes a-tree) 'blue) true]
                                     [(blue-eyes (child-father a-tree)) true]
                                     [(blue-eyes (child-mother a-tree)) true]
                                     [else false])]))

;;NOTE: if there are nested items you will need to use recursion i.e. parents' node is nested and you will need to access parents, grandparents and maybe great grandparents
;; also could use OR expression as one long second-caluse

(define (blue-eyes2 a-tree) (cond
                              [(empty? a-tree) false]
                              [else (or (symbol=? (child-eyes a-tree) 'blue)
                                        (or (blue-eyes (child-father a-tree)) (blue-eyes (child-mother a-tree))))]))

;;exercise 14.1.2
(blue-eyes2 gustav)
                    ;; = (cond [(or (child-eyes (make-child adam gen gustav 1988 brown)) = false
                           ;;  [(or (blue-eyes2 (child-father (make-child carl dorothy 'adam 1950 'green)))] = false
                           ;;       (blue-eyes2 (child-mother (make-child empty empty 'gen 1950 'blue))))])]) = true
                           ;; true because one parent has blue eyes and or statement hold 'true'

;;exercise 14.1.3
(define (count-persons a-tree) (cond
                                 [(empty? a-tree) 0]
                                 [else (+ 1 (count-persons (child-father a-tree)) (count-persons (child-mother a-tree)))]))

;;test
(=(count-persons gustav) 5)

(define (sum a-tree) (cond
                       [(empty? a-tree) 0]
                       [else (+ ( - 2025 (child-date a-tree))
                                (sum (child-mother a-tree)) (sum (child-father a-tree)))]))

;;test
( = (sum carl) 99)
(= (sum adam) 273)

(define (average-age a-tree) (cond
                               [(empty? a-tree) 0]
                               [else (/ (sum a-tree) (count-persons a-tree))]))

;;test
(average-age gustav)

;;(define (blue-parents a-tree) (cond
                               ;; [(empty? a-tree) false]
                               ;; [else (cond
                                      ;;  [(symbol=? 'blue (child-eyes a-tree)) (blue-parents (child-father a-tree)) (blue-parents (child-mother a-tree))) true]
                                      ;;  [else (or (blue-parents (child-father a-tree)) (blue-parents (child-mother a-tree)))])]))

;;test
;;(blue-parents carl)


;;exercise 14.2.1
(define-struct node (ssn name left right))


(define (contains-n? n node) (cond
                             [(false? node) empty]
                             [else (or (= n (node-ssn node))
                                        (or (contains-n? n (node-left node)) (contains-n? n (node-right node))))]))

;;exercise 14.2.2
(define (search-bt n BT) (cond
                          [(false? BT) empty]
                          [else (cond
                                  [(contains-n? n (node-ssn BT)) (and (= n (node-ssn BT)) (node-name BT))]
                                  [else false])]))
;;test
;;(search-bt 29 (make-node 63 'd
                    ;; (make-node 29 'c
                               ;; (make-node 15 'b
                                          ;; (make-node 10 'a null null)(make-node 24 'aa null null))null)
                    ;; (make-node 89 'cc
                               ;; (make-node 77 'bb null null) (make-node 95 'bbb
                                                                          ;;(make-node 99 'dd null null) null))))
;;exercise 14.2.3
(define (in-order BT) (cond
                        [(false? BT) empty]
                        [else (append (in-order (node-left BT)) (cons (node-ssn BT) (in-order (node-right BT))))]))

;;test
;;(in-order (make-node 63 'd
                    ;; (make-node 29 'c
                        ;;        (make-node 15 'b
                         ;;                  (make-node 10 'a false false)(make-node 24 'aa false false))false)
                   ;;  (make-node 89 'cc
                          ;;      (make-node 77 'bb false false) (make-node 95 'bbb
                                                                       ;;   (make-node 99 'dd false false) false))))

;;exercise 14.2.4
;;(define (search-bst n BST) (cond
                             ;;[(false? BST) empty]
                             ;;[else (cond
                                     ;;[(and (> n (node-ssn BST)) (search-bst n (node-left BST))) true]
                                     ;;[(and (< n (node-ssn BST)) (search-bst n (node-right BST))) true]
                                     ;;[(= n (node-ssn BST)) (node-name BST)]
                                     ;;[else false])]))

(define (search-bst n BST) (cond
                             [(false? BST) empty]
                             [else (or (= (node-ssn BST) n) (search-bst n (node-ssn BST)))]))
;;test
 ;;(search-bst (make-node 10 'a (make-node 15 'b (make-node 24 'c (make-node 29 'd (make-node 63 'e (make-node 77 'f (make-node 89 'g (make-node 99 'h (make-node 95 'i
                                                                                                                                                ;; false false)
                                                                                                                                                ;; false)
                                                                                                                              ;;  false)
                                                                                                            ;;   false)
                                                                                            ;;  false)
                                                                           ;;   false)
                                                          ;;   false)
                                          ;;   false)
                          ;;  false) 89)
;;first attempt
;;(define (create-bst B N S) (list (make-node N S false B)))

(define (create-bst B N S) (cond
                             [(false? B) (list (make-node N S false false))]
                             [(> (node-ssn B) N) (list (make-node N S false (create-bst B N S)))]
                             [else (list (make-node N S (create-bst B N S) false))]))


(create-bst false 66 'a)
(create-bst (create-bst false 66 'a) 53 'b)