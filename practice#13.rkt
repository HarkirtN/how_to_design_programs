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
                                [(mul? expression) (and (number? (mul-left expression)) (number? (mul-right expression)))]
                                [(add? expression) (and (number? (add-left expression)) (number? (add-right expression)))]
                                ;;[(and (numeric? (mul? expression)) (numeric? (add? expression)))]
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
                                           [(numeric? expression) (evaluate-expression (list (+ (add-left expression) (add-right expression))  (* (mul-left expression) (mul-right expression))))]
                                           [else (error 'evaluate-expression "expected number given variable")]))

;;test
(evaluate-expression (make-add 3 5))
(evaluate-expression (make-mul 4 4))
(evaluate-expression (make-add 4 (make-mul 1 2)))

;;Exercise 15.1
;; if the family tree was switched to structure where descend through grandparents to children then the tree/data def will be different
(define-struct parent (children name date eyes))
;; then it will require a referential def because they maybe multiple children (list within a list)
;;(define children (p loc))

;;revised family tree
(define gustav (make-parent empty 'gustav 1988 'brown))

  (define fred&eva (list gustav))

(define adam (make-parent empty 'adam 1950 'yellow))
(define dave (make-parent empty 'dave 1955 'black))
(define eva (make-parent fred&eva 'eva 1965 'blue))
(define fred (make-parent fred&eva 'fred 1966 'pink))

  (define carl&bettina (list adam dave eva))

(define carl (make-parent carl&bettina 'carl 1926 'green))
(define bettina (make-parent carl&bettina 'bettina 1926 'green))

;;to find blue-eyed ancestor in all structures
(define (blue-parents a-parent) (cond
                                  [(symbol=? 'blue (parent-eyes a-parent)) true]
                                  [else (blue-children (parent-children a-parent))]))

(define (blue-children aloc) (cond
                               [(empty? aloc) false]
                               [else (cond
                                       [(blue-parents (first aloc)) true]
                                       [else (blue-children (rest aloc))])]))

(define (how-far a-parent) (cond
                            [(+ 1 (blue-parents a-parent)) (how-far (parent-children a-parent))]
                            [else false]))

;;count decendents including parent
(define (count-decendents a-parent) (cond
                                      [(empty? a-parent) 0]
                                      [else (+ 1 (count-decendents (parent-children a-parent)))]))

;;count decendents excluding parent
(define (count-decendents2 a-parent) (cond
                                       [(empty? a-parent) 0]
                                       [(count-decendents2 (parent-children a-parent)) (+ 1 (parent-children a-parent))]))
