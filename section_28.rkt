;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname section_28) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp") (lib "gui.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp") (lib "gui.rkt" "teachpack" "htdp")) #f)))
;;listof lists 
(define graph1 '((A (B E))
                (B (E F))
                (C (D))
                (D ())
                (E (C F))
                (F (D G))
                (G ())))

;;to flatten the list
(define (flatten list) (cond
                         [(empty? list) empty]
                         [(list? (first list)) (append (flatten (first list)) (flatten (rest list)))]
                         [else (cons (first list) (flatten (rest list)))]))

;; to return a list with the origin 
(define (neighbours origin a-list) (cond
                                      [(empty? a-list) empty]
                                      [else (cond
                                              [(symbol=? (flatten (first a-list)) origin) (first a-list)]
                                              [else (neighbours origin (rest a-list))])]))

;;test
;;(flatten graph1)
;;(neighbours 'D graph1)
;;(neighbours 'F graph1)

;;exercise 28.1.4
(define (test-all-nodes g) (cond
                             [(empty? g) empty]
                             [else (local ((define find-route list d g) (cond
                                                                          [(empty? list) false]
                                                                          [else (local ((define possible-route (find-route (first list) d g)))
                                                                                  (cond
                                                                                    [(boolean? possible-route) (find-route (rest list) d g)]
                                                                                    [else possible-route]))]))

;;The intermediate value theorem
;; finding the root of a continuous interval (a,b) using the IVT //this is on the x axis //
;;you try to find the value of f(a) by pugging in the root x equation and same with f(b) //this is on the y axis //
;; the root is f(a) < K < f(b)
;; try to find midpoint = a+b / 2, which partitions a & b. We use the midpoint halving strategy multiple times to find the root

(define (find-root f left right) (cond
                                   [(<= (- right left) 2) left] ;;termination statement that it is solved once the distance between left and right is <= TOLERANCE
                                   [else (local ((define mid (/ (+ left right) 2)))
                                           (cond
                                             [(<= (f mid) 0 (f right)) (find-root mid right)]
                                             [else (find-root left mid)]))]))

;;exercise 27.3.2
;;test find root with different values
;;(find-root 1 -3 6)

