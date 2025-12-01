;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname vectors) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp") (lib "gui.rkt" "teachpack" "htdp") (lib "graphing.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp") (lib "gui.rkt" "teachpack" "htdp") (lib "graphing.rkt" "teachpack" "htdp")) #f)))
;;vectors
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