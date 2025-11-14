;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname section26) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp") (lib "gui.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp") (lib "gui.rkt" "teachpack" "htdp")) #f)))
;; general-quick-sort : (X X -> bool) (list X) -> (list X)
(define (general-quick-sort a-predicate a-list)
  (cond
    [(empty? a-list) empty]
    [else (local ((define (quick-sort a-predicate a-list)
             (cond
               [(empty? a-list) empty]
               [else (if (a-predicate (first a-list))
                         (cons (first a-list) (quick-sort a-predicate (rest a-list)))
                         (quick-sort a-predicate (rest a-list)))])))
           (append
            (quick-sort (lambda (x) (a-predicate (first a-list) x)) a-list)
            (quick-sort (lambda (x) (not (a-predicate (first a-list) x))) a-list)))]))
          

;;  (append
;; (general-quick-sort (lambda (x) (a-predicate (first a-list) x)) (rest a-list))
;; (list (first a-list))
;; (general-quick-sort (lambda (x) (not (a-predicate (first a-list) x))) (rest a-list)))]))

;; ((define lhs (lambda (rhs) (a-predicate  ]))
;; (local ((define search-left (contains-bt? n (node-left node)))
;;        (define search-right (contains-bt? n (node-right node))))

;;(general-quick-sort > (list 2 1 4 3 6 5))

;;(define (generative-recursive-fun problem) (cond
                                            ;; [(trivally-solvable? problem) (determine-solution problem)]
                                            ;; [else (combine-solutions problem (generative-recursive-fun (generate-problem problem)))]))

;; change trivally-solvable to empty and generate-problem with rest

;;exercise 26.2.1
;; define determine-solution and combine-solution so that it computes the length of its input

;;first attempt
(define (generative-recursive-length problem) (cond
                                                [(null? problem) empty]
                                                [else (local ((define combine-solutions1  1 ))
                                                      (+ combine-solutions1 (generative-recursive-length (rest problem))))]))

;;(generative-recursive-length (list 4 5 2 7 9 7)) - didnt work

;;something similiar to counting the length of a family tree
;;but the list could be one item - to many item list

(define (generative-fun problem) (cond
                                   [(empty? problem) 0]
                                   [(not (list? problem)) 1]
                                   [else (+ (generative-fun (first problem)) (generative-fun (rest problem)))]))
;;test
(generative-fun (list 1 2 3 4 5))
(generative-fun (list (list 1 2 3) 4 5 6))
(generative-fun (list 1))

;;gcd-gen : N [>= 1] N [>= 1] -> N
;; to find the greastest common divisor for n and m
;;use gen recursion : (gcd n m) = (gcd n (remainder m n)) if (<= m n)
(define (gcd-gen n m) (local ((define (clever-gcd larger smaller) (cond
                                                                    [(= smaller 0) larger]
                                                                    [else (clever-gcd smaller (remainder larger smaller))])))
                        (clever-gcd (max m n) (min m n))))


;;exercise 26.3.4
(define (gcd-gen1 n m) (local ((define (clev-gcd larger smaller) (cond
                                                                   [(and (= smaller 0) (= larger 0)) (error 'gcd-gen1 "received 0 as divisor for small and large")]
                                                                   [(= smaller 0) larger]
                                                                   [else (clev-gcd smaller (remainder larger smaller))])))
                         (clev-gcd (max m n) (min m n))))

;;exercise 26.3.6
;;for larger lists
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

;;for smaller list
(define (quick-small alon) (cond
                             [(empty? alon) empty]
                             [else (insert-small (first alon) (quick-small (rest alon)))]))

(define (insert-small alon threshold) (cond
                                        [(empty? alon) (cons threshold empty)]
                                        [else (cond
                                                [(>= threshold (first alon)) (cons threshold (alon))]
                                                [(< threshold (first alon)) (cons (first alon) (insert-small threshold (rest alon)))])]))

;;develop a function sort-quick-sort that behaves like quick sort and then switches over when its a small list
;;intial thoughts to place them both into local
;;then add a threshold

(define (sort-quick-sort lst) (cond
                                  [(empty? lst) empty]
                                  (local((define (quicker-sort lst) (cond
                                                                   [(empty? lst) empty]
                                                                   [else (append (quicker-sort (small lst (first lst))) (list (first lst))
                                                                                  (quicker-sort (larger lst (first lst))))]))
                                      (define (small lst TH) (cond
                                                               [(empty? lst) empty]
                                                               [else (if (< (first lst) TH) (cons (first lst) (small (rest lst) TH))
                                                                                                  (small (rest lst) TH))]))
                                      (define (large lst TH) (cond
                                                               [(empty? lst) empty]
                                                               [else (if (> (first lst) TH) (cons (first lst) (large (rest lst) TH))
                                                                         (large (rest lst) TH))]))
                                      (define (sorting-small lst) (cond
                                                                    [(empty? lst) empty]
                                                                    [else (inserting (first lst) (sorting-small (rest lst)))]))
                                      (define (inserting-small lst TH) (cond
                                                                         [(empty? lst) (cons TH empty)]
                                                                         [else (cond
                                                                                 [(>= TH (first lst)) (cons TH lst)]
                                                                                 [(< TH (first lst)) (cons (first lst) (inserting-small TH (rest lst)))])]))
                                      (define (generative-fun problem) (cond
                                                                        [(empty? problem) 0]
                                                                        [(not (list? problem)) 1]
                                                                        [else (+ (generative-fun (first problem)) (generative-fun (rest problem)))])))
                                  [(< (generative-fun lst) 30) (sorting-small lst)]
                                  [(> (generative-fun lst) 30) (quicker-sort lst)])))