;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |bt _search|) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp") (lib "gui.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp") (lib "gui.rkt" "teachpack" "htdp")) #f)))
(define-struct node (ssn name left right))
;; find-route : (listof node) node graph -> (listof node or false)
;; to create a path from one node to the destination, else false is no path found
;;(define (find-route origin destination) (cond
                                         ;; [(symbol=? origin destination) (list destination)]
                                         ;; [else ...(find-route (neighbours origin G) destination G) ...]))

(define graph1 '((A (B E))
                (B (E F))
                (C (D))
                (D ())
                (E (C F))
                (F (D G))
                (G ())))

(define graph (make-node 63 'd
                     (make-node 29 'c
                                (make-node 15 'b
                                           (make-node 10 'a null null)(make-node 24 'aa null null))null)
                     (make-node 89 'cc
                                (make-node 77 'bb null null) (make-node 95 'bbb
                                                                          (make-node 99 'dd null null) null))))


;;neighbours : node graph -> listof nodes
;;provides a listof all possible paths
(define (contains-n? origin graph) (cond
                             [(null? graph) false]
                             [else (or (= origin (first graph))
                                        (or (contains-n? origin (node-left graph)) (contains-n? origin (node-right graph))))]))

(define (neighbours origin graph) (cond
                           [(empty? graph) empty]
                           [else (cond
                                   [(= origin (first graph)) graph]
                                   [else (neighbours origin (rest graph))])]))

;;test
;;(neighbours 29 (make-node 63 'd
                     ;;(make-node 29 'c
                               ;; (make-node 15 'b
                                           ;;(make-node 10 'a null null)(make-node 24 'aa null null))null)
                    ;; (make-node 89 'cc
                    ;;            (make-node 77 'bb null null) (make-node 95 'bbb
                                                                        ;;  (make-node 99 'dd null null) null))))
(define (in-order n a-tree) (cond
                            [(false? a-tree) empty]
                            [else (append (node-left a-tree) (cons (node-name a-tree) (in-order n (node-right a-tree))))]))
                                    
 ;;test - doesnt work yet only provides me with list of nodes regardless of the node origin 
 (neighbours o graph1) ;;= (list D empty)

;; find path : node node graph -> listof nodes or false
 ;; computes a path going through the neighbours to destination or returns false
 (define (find-path origin destination G) (cond
                                            [(symbol=? origin destination) (list destination)]
                                            [else (local ((define possible-path (find-path (neighbours origin G) destination G)))
                                                    (cond
                                                      [(boolean? possible-path) false]      ;;if it failed to find route using neighbours it is impossible to reach and returns false 
                                                      [else (cons origin possible-path)]))])) ;;if found then returns the listof nodes and attaches to the origin 

