;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname practice#13) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp")) #f)))
;;list in lists
(define (size webpage) (cond
                         [(empty? webpage) 0]
                         [(symbol? (first webpage)) (+ 1 (size (rest webpage)))]
                         [else (+ (size (first webpage)) (size (rest webpage)))]))

;;test
(= (size (cons (cons 'One empty)empty)) 1)

;;exercise 14.3.2
(define (occurs1 webpage symbol) (cond
                                   [(empty? webpage) 0]
                                   [(symbol=? symbol (first webpage)) (+ 1 (occurs1 symbol (rest webpage)))]))


(define (occurs2 webpage symbol) (cond
                                   [(empty? webpage) 0]
                                   [(symbol=? symbol (first webpage)) (+ 1 (occurs2 symbol (rest webpage)))]
                                   [else ( + (occurs2 symbol (first webpage)) (occurs2 symbol (rest webpage)))]))

;;exercise 14.3.3
;;replace : symbol symbol list -> list
;;replaces all old with new 
(define (replace old new webpage) (cond
                                    [(empty? webpage) empty]
                                    [(symbol=? old (first webpage)) (cons new (replace old new (rest webpage)))]
                                    [else (cons (first webpage) (replace old new (rest webpage)))]))

;;exercise 14.3.4
;;depth : list -> number
;; to compute the number of embedded pages
(define (depth webpage) (cond
                          [(empty? webpage) 0]
                          [else (+ 1 (depth (rest webpage)))]))

;;exercise 14.4.1
(define-struct add(left right))
(define-struct mul (left right))


(+ 10 -10) (make-add 10 -10)
;;(+ (* 9/5 c) 32) (make-add (make-mul 9/5 c) 32)

;;exercise 14.4.2
;;numeric? : scheme expression -> boolean
(define (numeric? expression) (cond
                                [(empty? expression) true]
                                [(numeric? (number? expression)) true]
                                [else false]))

;;test
(numeric? (make-add 10 -10))
(numeric? (make-add 4 (make-mul 1 2)))

;;exercise 14.4.3
;;evaluate-expression : scheme expression -> number
;; evaluate a scheme expression
;;(define (evaluate-expression expression) (cond
                                         ;;  [(empty? expression) 0]
                                         ;;  [(and (add? expression)(numeric? expression)) (+ (add-left expression) (add-right expression))]
                                         ;;  [(and (mul? expression)(numeric? expression)) (* (mul-left expression) (mul-right expression))]
                                         ;;  [else (error 'evaluate-expression "expected number given variable")]))

(define (evaluate-expression expression) (cond
                                           [(empty? expression) 0]
                                           [(numeric? expression) (evaluate-expression (rest expression))]
                                           [else (error 'evaluate-expression "expected number given variable")]))

;;test
(evaluate-expression (make-add 3 5))
(evaluate-expression (make-mul 4 4))
(evaluate-expression (make-add 4 (make-mul 1 2)))