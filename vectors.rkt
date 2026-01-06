;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname vectors) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp") (lib "gui.rkt" "teachpack" "htdp") (lib "graphing.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp") (lib "gui.rkt" "teachpack" "htdp") (lib "graphing.rkt" "teachpack" "htdp")) #f)))
;; vectors
;; neighbours : node graph -> listof node
;; to lookup the node in graph
(define (neighbours node graph) (cond
                                  [(empty? graph) (error 'neighbours "cant happen")]
                                  [else (cond
                                          [(symbol=? (first (first graph)) node) (second (first graph))]
                                          [else (neighbours node (rest graph))])]))

;; vector is like a list, but there is built in functions that can help you index into the list and retrieve items
;; as opposed to trying the go through the whole list, this is called vector ref
;; (vector-ref (vector v-0 ... v-n) i)

(define graph-list '((A (B E))
                      (B (E F))
                      (C (D))
                      (D ())
                      (E (C F))
                      (F (D G))
                      (G ())))

(define graph-vector (vector (list 1 4)
                             (list 4 5)
                             (list 3)
                             empty
                             (list 2 5)
                             (list 3 6)
                             empty))

;;neighbour-vector : node graph -> (listof node)
;; to lookup neighbouring nodes in a graph now as vectors using vector-ref
(define (neighbour-vector node graph) (vector-ref graph node))

;;exercise 29.3.1
;;test the neighbours graph
(equal? (neighbours 'A graph-list) (neighbour-vector 0 graph-vector))
(equal? (neighbours 'D graph-list) (neighbour-vector 3 graph-vector))
(equal? (neighbours 'G graph-list) (neighbour-vector 6 graph-vector))

(neighbours 'A graph-list)
(neighbour-vector 0 graph-vector)

;;vector-sum : (vectorof number) -> number
;; to compute the sum of the numbers in v
(define (vector-sum list) (vector-sum-aux list (vector-length list)))
  ;; vector length is the number of items i.e. (= (vector -1 3/4 1/4) 3) or (= (vector) 0)

;;vector-sum-aux : (vectorof number) -> number
;; to sum the numbers in v with the index (0, i)
(define (vector-sum-aux list i) (cond
                               [(zero? i) 0] ;;is equivalent to vector-length and therefore not an index so it can be excluded, if i is 0 theres no items between 0 and i
                               [else (+ (vector-ref list (sub1 i)) (vector-sum-aux list (sub1 i)))])) ;; vector-ref extracts values from vector list
                                       ;; we add vector-ref (sub1 i) because the recursion only computer the sum of numbers in list between 0 and (sub1 i)

;;using large class of vectors using build vector
;; displacement : (vectorof number) number -> (vectorof number)
;; to compute the displacement of vector and t (time in units)
(define (displacement list t) (local ((define (new-item i) (* (vector-ref list i) t)))
                                   (build-vector (vector-length list) new-item)))

;;using lambda as its not recursive
(define (displace list t) (build-vector (vector-length list) (lambda (i) (* (vector-ref list i) t))))

;;list-sum : (listof number) -> number
;; compute the sum of the numbers on a list
(define (list-sum list) (list-sum-aux list (length list)))

;; list-sum-aux : N (listof number) -> number
;; compute sum of the first L numbers on list
(define (list-sum-aux L list) (cond
                                [(zero? L) 0]
                                [else (+ (list-ref list (sub1 L)) (list-sum-aux (sub1 L) list))]))
;; looks up the list using list-ref is an 0 (N) which would be N items
;; vector-sum-aux and list-sum-aux would be doubling the recursions one line so N squared.

;;exercise 29.3.7
;; norm : (listof numbers) -> number
;; compute the sum of of the vector from the origin
(define (norm list) (norm-sum-aux list (vector-length list)))

;;to compute the square root of numbers in vector with the index i
(define (norm-sum-aux list i) (cond
                                [(zero? i) 0]
                                [else (sqrt (+ (sqr (vector-ref list (sub1 i))) (sqr (norm-sum-aux list (sub1 i)))))]))

;;test
(define list-test (vector 1 2 3))

(norm list-test)  
(norm (vector 1 1 1)) 

;;exercise 29.3.8
;; vector-contains-dolls? : (listof numbers) -> symbol or false
;; to determine whether a vector contains 'doll symbol

(define (vector-contains-doll? list) (vector-contains-doll-aux list (vector-length list)))

;;to determine symbol=? doll occurs in vector with index i
(define (vector-contains-doll-aux list i) (cond
                                            [(zero? i) false]
                                            [else (cond
                                                    [(symbol=? 'doll (vector-ref list (sub1 i))) i]
                                                    [else (vector-contains-doll-aux list (sub1 i))])]))

;;test
(vector-contains-doll? (vector 'eyes 'see 'doll 'toy)) ;; should return index 3

;;exercise 29.3.11
;; id-vector : natural-number N -> listof 1's
;; to create a vector of many 1's
(define (id-vector N)
  (local ((define (build-1s N) (cond
                                 [(zero? N) empty]
                                 [else (cons 1 empty)])))
    (build-vector N build-1s)))

;;test
(id-vector 5) ;; didn't work, but gave me vector with x 5 lists, something wrong in the function 

;;exercise 29.3.12
;; vector+ : (listof numbers) (listof numbers) -> (listof numbers)
;; to compute the sum of one vector
;;(define (vector+ list1) (vector+aux list1 (vector-length list1)))

;;to compute the sum of one list using index
;;(define (vector+aux list i) (cond
                              ;; [(zero? i) 0]
                               ;;[else (+ (vector-ref list (sub1 i)) (vector+aux list (sub1 i)))]))

;;test
;;(vector+ (vector 1 2 3)) ;; it worked

(define (vector+ list1 list2) (+ (vector+aux list1 (vector-length list1)) (vector+aux list2 (vector-length list2))))

;;to compute the sum of two list using index
(define (vector+aux list i) (cond
                               [(zero? i) 0]
                               [else (+ (vector-ref list (sub1 i)) (vector+aux list (sub1 i)))]))

;;test
(vector+ (vector 1 2 3) (vector 1 1 1)) ;; works


;;to compute the sum of two list using index
(define (vectorsplus list1 list2) (local ((define (adding-vectors list1 list2)
                                  (cond
                                    [(and (empty? list1) (empty? list2)) 0]
                                    [else (cons (+ (first list1) (first list2)) (adding-vectors (rest list1) (rest list2)))])))
                          (build-vector (vector-length list1) adding-vectors)))

;;test
(vectorsplus (vector 1 2 3) (vector 1 1 1))