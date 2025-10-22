;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname section21) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
(define (map1 f lon) (cond
                      [(empty? lon) empty]
                      [else (cons (f (first lon)) (map1 f (rest lon)))]))

(define (convert-euro dollar) (* dollar 1.22))

;;test
(map convert-euro (cons 1 (cons 10 (cons 100 empty))))


(define (move-posn a-posn) (make-posn (+ (posn-x a-posn) 3)
                                         (posn-y a-posn)))

;;test
(map move-posn (list (make-posn 1 1)(make-posn 10 10) (make-posn 100 100)))

(define (reduce base combine l) (cond
                                  [(empty? l) base]
                                  [else (combine (first l) (reduce base combine (rest l)))]))

;; abstractions from templates i.e. above that proceses lists

;;then use reduce to define list processing functions

;; sum : (listof number) -> number
  (define (sum l) (reduce 0 + l))  ;; 0 is the base case for sum, + is the combination, l is the list

;; product : (listof number) -> number
  (define (product l) (reduce 1 * l))  ;; 1 is the base case for product, * is the combining primative, l is the list

  ;;sort : (listof number) -> (listof number)
  (define (sort? l) (local ((define (insert an alon) (cond
                                                      [(empty? alon) (list an)]
                                                      [else (cond
                                                              [(> an (first alon)) (cons (an alon))]
                                                              [else (cons (first alon) (insert an (rest alon)))])])))
                     (reduce empty insert l)))


(define (filter? predicate alon) (cond
                                   [(empty? alon) empty]
                                   [else (cond
                                           [(predicate (first alon)) (cons (first alon) (filter? predicate (rest alon)))]
                                           [else (filter? predicate (rest alon))])]))

(define (eliminate-exp ua list) (local ((define (filter? predicate alon) (cond
                                                                         [(empty? alon) empty]
                                                                         [else (cond
                                                                                [(predicate ua (first alon)) (cons (first alon) (filter? predicate (rest alon)))]
                                                                                [else (filter? predicate (rest alon))])])))
                                  (filter? symbol=? list)))

    ;;test
      (eliminate-exp 'toy (cons 'toy (cons 'doll (cons 'puppy empty))))


(define (recall ty list) (local ((define (filter? predicate alon) (cond
                                                                   [(empty? alon) empty]
                                                                   [else (cond
                                                                            [(not (predicate ty (first alon))) (cons (first alon) (filter? predicate (rest alon)))]
                                                                            [else (filter? predicate (rest alon))])])))
                           (filter? symbol=? list)))

;;test
(recall 'toy (cons 'toy (cons 'doll (cons 'puppy empty))))