;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname section22) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
;;Section 22
(define f (local ((define (x-adder5 y) (+ 5 y)))
            x-adder5))

;;test
(f 10)

;;functions within functions utilise local expression
;;computer will remeber the first function and exevute that prior to the second function call
;;it will be a different name as you dont want it to confuse and excute original function i.e. filter1, filter2, filter3

(define (filter2 rel-op) (local ((define (func-abs alon t)
                                   (cond
                                     [(empty? alon) empty]
                                     [else (cond
                                             [(rel-op (first alon) t) (cons (first alon) (func-abs (rest alon) t))]
                                             [else (func-abs (rest alon) t)])])))
                           func-abs))

;;so if you test for (filter2 <) this is essentially the same template for below
;;i.e (filter2 <) copies the template below1
(define (below2 alon t) (cond
                          [(empty? alon) empty]
                          [else (cond
                                  [(< (first alon) t) (cons (first alon) (below2 (rest alon) t))]
                                  [else (below2 (rest alon) t)])]))

;;you can name more succintently below2 = below3
(define below3 (filter2 <))

;;exercise 22.2.1
(define (f-c farenheit) ( * (- farenheit 32) (/ 5 9)))
(define-struct IR (names number))

(define (map1 f lon) (cond
                      [(empty? lon) empty]
                      [else (cons (f (first lon)) (map1 f (rest lon)))]))

(define (map2 func) (local ((define (convert func alon) (cond
                                                       [(empty? alon) empty]
                                                       [else (cons (func (first alon)) (convert func (rest alon)))])))
                      convert))

(define convertCF (map2 f-c))
(define names (map2 IR-names))

;;exercise 22.2.3
(define (fold1 base combine alon) (cond
                                [(empty? alon) base]
                                [else (combine (first alon) (fold1 base combine (rest alon)))]))

(define (fold2 combine) (local ((define (abs-func base combine alon) (cond
                                                                      [(empty? alon) base]
                                                                      [else (combine (first alon) (fold1 base combine (rest alon)))])))
                         abs-func))

(define sum1 (fold2 +))
(define product2 (fold2 *))

;;exercise 22.3.1
;; check-guess-gui : digits -> gui-item
(define (check-guess-gui1 digits) (+ (* 1 o) (* 10 t) (* 100 h)))
  