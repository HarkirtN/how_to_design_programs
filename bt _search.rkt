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
                             [else (or (= origin (node-ssn graph))
                                        (or (contains-n? origin (node-left graph)) (contains-n? origin (node-right graph))))]))

(define (neighbours origin graph) (cond
                           [(and (null? (node-left graph)) (null? (node-right graph))) false]
                           [else (and (contains-n? origin graph)
                                      (cons (neighbours origin (node-left graph)) (neighbours origin (node-right graph))))]))

;;test
(neighbours 29 (make-node 63 'd
                     (make-node 29 'c
                                (make-node 15 'b
                                           (make-node 10 'a null null)(make-node 24 'aa null null) v)null)
                     (make-node 89 'cc
                                (make-node 77 'bb null null) (make-node 95 'bbb
                                                                          (make-node 99 'dd null null) null))))