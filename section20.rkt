;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname section20) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
;;section 20
;; develop a function that dteremines whether two functions produce the same results
;;(define (a-function=? num1 num2) (local ((function1 ...)
                                     ;;   (function2 ...))
                                 ;;  (= (function1 function2))))

(define (a-function=? func1 func2) (= func1 func2))

;;to check whether the functions are equal
(define (function=? func1 func2) (equal? func1 func2))

;;exercise 20.2.2
;;formulate contracts for the previous functions

;;sort : (listof number (number number -> boolean) : listof number)
;;map : (listof number (number number -> boolean) -> listof numbers
;;project : listof symbols (listof symbols -> listof symbols) -> listof symbols

(define (filter1 rel-op TH listofx) (cond
                                      [(empty? listofx) empty]
                                      [(rel-op TH (first listofx)) (cons (first listofx) (filter1 rel-op TH (rest listofx)))]
                                      [else (filter1 rel-op TH (rest listofx))]))


(define (contains? TH listofx) (cond
                              [(empty? listofx) false]
                              [else (cond
                                      [(symbol=? TH (first listofx)) true]
                                      [else (contains? TH (rest listofx))])]))

     ;; tested to see if it works, now need to do opposite to :
     ;;(filter1 symbol=? (cons 'fire (cons 'day (cons 'car (cons 'fire (cons 'car empty))))) 'car )

     ;; attempt2 test: (filter1 contains? car (cons 'fire (cons 'day (cons 'car (cons 'fire (cons 'car empty))))))


(define (filter2 rel-op TH listofx) (cond
                                      [(empty? listofx) empty]
                                      [else (cond
                                              [(not (rel-op TH (first listofx))) (cons (first listofx) (filter2 rel-op TH (rest listofx)))]
                                              [else (filter2 rel-op TH (rest listofx))])]))

    ;;test works, but unsure if this is what the exercise wants
    (filter2 symbol=? 'car (cons 'fire (cons 'day (cons 'car (cons 'fire (cons 'car empty))))))


(define (not-car? filter1 rel-op TH listofx) (cond
                             [(empty? listofx) empty]
                             [else (cond
                                     [(not (filter1 symbol=? TH (first listofx))) true]
                                     [else (not-car? filter1 TH (rest listofx))])]))

    ;;test using filter1 plugged into a function
    ;;(not-car? filter1 symbol=? 'car (cons 'fire (cons 'day (cons 'car (cons 'fire (cons 'car empty))))))

;;to abstract you compare the function side by side, box the parts with differences - and with new names to a parameter list.
(define (convertCF f alon) (cond
                             [(empty? alon) empty]
                             [else (cons (f (first alon)) (convertCF f (rest alon)))]))

(define (names f alon) (cond
                             [(empty? alon) empty]
                             [else (cons (f (first alon)) (names f (rest alon)))]))

;;then f is the parameter now we replace names of the natural recursion/function to get a more generalised 'abstract' function
;;(define (map f alon) (cond
                             ;;[(empty? alon) empty]
                             ;;[else (cons (f (first alon)) (map f (rest alon)))]))

;;to test the examples with the using the original functions you can define the original and plug in the abstracted expression
;;(define (f-original list) (f-abstracted boxed-function list))

;;therefore the contract header is simiplified to map : (X -> Y) (listof X) -> (listof Y)

;;exercise 21.1.1
;; tabulate : (number -> listof X) number -> listof Y
(define (tabulate t-func number) (cond
                                   [(= number 0) (list (t-func 0))]
                                   [else (cons (t-func number) (tabulate (sub1 number)))]))

;;(define (sin number) (tabulate sin number))
;;(define (sqrt number) (tabulate sqrt number))

;;exercise 21.1.2
;;fold : listof X -> Y
(define (fold rel-op list e) (cond
                             [(empty? list) e]
                             [else (rel-op (first list) (fold rel-op (rest list) e))]))


(define (sum list) (fold + list 0))
(define (product list) (fold * list 1))

;;test
(fold * (list 1 2 3) 1)
(fold + (list 1 2 3) 0)
(sum (list 1 2 3))
(product (list 1 2 3))

;;formulating general contracts we use same approach as comparing functions
;; compare the two contracts and start replacing the the arguments
    ;; (number -> number)   (listof number) -> (listof number)
    ;; (IR -> symbol)       (listof IR)     -> (listof symbol)

       ;;therefore it can be generalised
    ;; (X -> Y)             (listof X)      -> (listof Y)

;;another example for filter1
    ;; (number number -> boolean)   number    (listof number) -> (listof number)
    ;; (number IR -> boolean)       number    (listof IR)     -> (listof IR)

        ;;therefore
    ;; (number number -> boolean)   number    (listof X)      -> (listof X)
;; filter1 : ( Y X -> boolean)      Y         (listof X)      -> (listof X)

(define (build-list1 n f) (cond
                           [(zero? n) f]
                           [else (list n (build-list1 (sub1 n) f))]))
;;test
(build-list1 3 0)
(build-list1 4 1)
