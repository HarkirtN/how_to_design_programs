;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname practice#10) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp")) #f)))
(define (random-dollars dimes) (/ (+ 1 (random dimes)) 10))

(define (create-prices n)
    (cond
        [(zero? n) empty]
        [else (cons (random-dollars 100) (create-prices (- n 1)))]))

     ;; auxillary function
(define (f x)
  (+
   (* 3 (* x x))
   (+ (* -6 x) -1)))

;; f : number -> number
(define (tabulate-f n) (cond
                     [(zero? n) empty]
                     [else (cons (make-posn n (f n)) (tabulate-f (sub1 n)))]))
                     ;; [else (cons (cons n (cons (f n) empty)) (tabulate-f (sub1 n)))]))

;;test
(tabulate-f 10)

;; tabulate from 20
;; auxillary function
;;from-20 : n (>= 20) -> n
(define (from-20 n-above-20) (cond
                      [(= 20 n-above-20) 1]
                      [else (* n-above-20 (from-20 (sub1 n-above-20)))]))

;;test
(from-20 22)

;;add to tabulate i.e. replace n
(define (tabulate-f20 n) (cond
                            [(zero? n) empty]
                            [else (cons (make-posn n (f n)) (tabulate-f20 (sub1 (from-20 n))))]))

;;test
(tabulate-f20 25)

;; including the limit, so far it has computed for > or <
;; we will include the limit
(define (product limit n) (cond
                            [(= n limit) 1]
                            [else (* n (product limit (sub1 n)))]))

;;refine tabulate function to include limit
(define (tabulate-f-lim n limit) (cond
                                   [(= n limit) 1]
                                   [else (* n (tabulate-f-lim (sub1 n) limit))]))

;; adding a natural number to an arbiturary number
;; i.e. adding pi without using primative 'n' amount of times 1,2, 3.... etc
(define (add-pi n) (cond
                     [(zero? n) 3.14]
                     [else (add1 (add-pi (sub1 n)))]))

;;exercise 11.5.1
(define (add n x) (cond
                    [(and (zero? n) (zero? x)) 0]
                    [else (add1 (add (- n n)(- x x)))]))

;;exercise 11.5.2
(define (multiply-pi n) (cond
                          [(zero? n) 0]
                          [else (+ 3.14 (multiply-pi (sub1 n)))]))


(define (multiply n x) (cond
                         [(zero? n) 0]
                         [else (+ x (multiply (sub1 n) x))]))

;;exercise 11.5.3
;;auxillary for first loop
(define (multiply-x x n) (cond
                           [(zero? n) x]
                           [else (add1 (multiply-x (sub1 n) x))]))
(define (exponent n x) (cond
                         [(zero? x) 0]
                         [(= n 2) (multiply x n)]
                         [else (add1 (multiply x n) (exponent (sub1 n) x))]))

