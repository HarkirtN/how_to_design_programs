;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname section30) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp") (lib "gui.rkt" "teachpack" "htdp") (lib "graphing.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp") (lib "gui.rkt" "teachpack" "htdp") (lib "graphing.rkt" "teachpack" "htdp")) #f)))
;; relative-2-absolute : (listof number) -> (listof number)
;; to covert a list of relative distances to a list of absolute distances
;; the first item on a list represents the distance to the origin
(define (relative-2-absolute alon) (cond
                                     [(empty? alon) empty]
                                     [else (cons (first alon) (add-to-each (first alon) (relative-2-absolute (rest alon))))]))

;; add-to-each : number (listof number) -> (listof number)
;; to add N to each number of alon
(define (add-to-each N alon) (cond
                               [(empty? alon) empty]
                               [else (cons (+ (first alon) N) (add-to-each N (rest alon)))]))

;;test
(relative-2-absolute (list 1 3 5 7))
(equal? (relative-2-absolute (list 1 1 1 1)) (list 1 2 3 4))

;; reformulate add-to-each using map
;;expected result (map1 add-to-each (list 3 1 1)) = (list 3 4 5)
(define (map2 f alon) (cond
                      [(empty? alon) empty]
                      [else (cons (f (first alon)) (map2 f (rest alon)))]))

(define (map1 add-to-each alon) (cond
                                  [(empty? alon) empty]
                                  [else (cons (first alon) (add-to-each (first alon) (map1 add-to-each (rest alon))))]))

(equal? (map1 add-to-each (list 1 1 1 2)) (list 1 2 3 5))
;; abstract running time for relative-2-absolute there is two recursions is 2to the power of N

;; rels-2-abs : (listof number) -> (listof number)
;; converting a list of relative distances to absolute
;; the first item represents the distance from origin, using method that would be incorporated by hand
(define relative-2-absolute2 alon (local ((define (rel-2-abs alon acc-dist)
                                            (cond
                                              [(empty? alon) empty]
                                              [else (cons (+ (first alon) accu-dist) (rel-2-abs (rest alon) (+ (first alon) accu-dist)))])))
                                                                                       ;; accu-dist helps keep the tally
                                    (rel-2-abs alon 0))) ;; initial value must be 0 as its accu-dist should start from zero then start the tally

;; route-exists? : node node simple-graph -> boolean
;; to determine whether there is a route from orig to dest in graph
(define (route-exists? orig dest graph) (cond
                                          [(symbol=? orig dest) true]
                                          [else (route-exists? (neighbour orig graph) dest graph)]))

;; neighbour : node simple-graph -> node
;; to determine the node that is connected to a-node in graph
(define (neighbour a-node graph) (cond
                                   [(empty? graph) (error "neighbour : impossible")]
                                   [else (cond
                                           [(symbol=? (first (first graph)) a-node) (second (first graph))]
                                           [else (neighbour a-node (rest graph))])]))

;; make the function so that it has a cond that will tally the already searched nodes to prevent continued search
;; route-exists2 node node graph -> boolean
;; to determine whether there is a route from orig to dest in graph
(define (route-exists2 orig dest graph) (local ((define (re-accu? orig dest graph accu-seen)
                                                  (cond
                                                    [(symbol=? orig dest) true]
                                                    [(contains orig accu-seen) false]
                                                    [else (re-accu? (neighbour orig graph) dest graph (cons orig accu-seen))])))
                                          (re-accu? orig dest graph empty))) ;; initial value must be empty the tally up

;; locally defined function that consumes only those arguments that change in evaluation
(define (r-exists orig dest graph) (local ((define (re-accu?? orig dest graph accu-seen1) (re-accu?? (neighbour orig graph) dest graph (cons orig accu-seen1))))
                                     (re-accu?? orig dest empty))
                                     (cond
                                       [(symbol=? orig dest) true]
                                       [(contains1 orig accu-seen1) false]
                                       [else (...)]))

;; developing accumalator-style functions only developed after a function is designed
;; accumalator is a parameter that accumalates the knowledge (like the tally in the above examples)

;; to consider if the function is structurally recursive, if the results is processed by auxillary, recursive function then consider an accumalator
;; invert : (listof X) -> (listof X)
;; to construct the reverse of alox
;; structural recursions 
(define (invert alox) (cond
                        [(empty? alox) empty]
                        [else (make-last-item (first alox) (invert (rest alox)))]))

;; make-last-item : X (listof X) -> (listof X)
;; to add an-x to the end of alox
;; structural recursion
(define (make-last-item an-x alox) (cond
                                     [(empty? alox) (list an-x)]
                                     [else (cons (first alox) (make-last-item an-x (rest alox)))])) ;; recursive results is a reverse of rest list
                                        ;; make-last-item adds first to reverse of rest list

;; function based generative recursions will need accumalators if the algorithm were to fail when an result is expected