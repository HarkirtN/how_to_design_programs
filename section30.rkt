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
                                              [else (cons (+ ))])))
