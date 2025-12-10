;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname accumulator_functions) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp") (lib "gui.rkt" "teachpack" "htdp") (lib "graphing.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp") (lib "gui.rkt" "teachpack" "htdp") (lib "graphing.rkt" "teachpack" "htdp")) #f)))
;;exercise 31.3.4
;; how-many : list -> 
(define (how-many a-list) (cond
                            [(empty? a-list) 0]
                            [else (+ (how-many (rest a-list)) 1)]))
;;test
(how-many (list 'a 'b 'c)) ;; expected result 3

(define (many list) (local ((define (many-a list0 accu)
                              (cond
                                [(empty? many-a) accu]
                                [else (many-a (rest list0) (+ accu 1))])))
                      (many-a list 0)))

;;test
;;(many (list 'a 'b 'c)) ;; expected result 3
;;(many (list)) ;; expecte result 0

;; add-to-pi
(define (add-pi n) (cond
                     [(zero? n) 0]
                     [else (+ 3.14 (add-pi (sub1 n)))]))

;;test
(add-pi 1) ;; expected result pi
(add-pi 2) ;; expected result 6.283185....

(define (add-to-pi n) (local ((define (add-to-pie n0 accu)
                                (cond
                                  [(zero? n) accu]
                                  [else (add-to-pie (sub1 n) (+ accu))])))
                        (add-to-pie n 0)))

;;test
(add-to-pi 1) ;;expected result 3.14
(add-to-pi 2) ;; expected result 6.28

