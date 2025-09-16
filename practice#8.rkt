;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname practice#8) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp")) #f)))
;; Natural numbers of arbitrary size
;; hellos : Number -> list of hellos
;;to create a list of n copis of hellos

(define (hello n) (cond
                   

;; two option it is either 'o' hellos which means the list is empty
                     [(zero? n) empty]


;; then anything apart from zero means 1 was added, so to find the amount of times  'hello' occurs we subtract 1 also use recursion here
                     ;; [else (hello (sub1 n))]



;; then we create 'cons' because we want to create a list 
                     [else (cons 'hello (hello (sub1 n)))]))

;;test
(hello 2)
;; = (cons 'hello (cons 'hello empty))

;; exercise 11.2.1
;; repeat : n -> list of occurence
(define (repeat n) (cond
                     [(zero? n) empty]
                     [else (cons 'repeat (repeat (sub1 n)))]))

;; tabulates the values of f a create a list on n posns
(define x 1)
;; auxillary function
(define (f x)(+
              (* 3 (* x x))
                (+ (* -6 x) -1)))

;; f : number -> number
;;(define (tabulate-f f n) (cond
               ;; [(zero? n) 0]
                ;;[else (cons (tabulate-f f (sub1 n)) (f (f x)))]))

;;test
(f 4)
;;(tabulate-f 4)

;;exercise 11.2.4
;;deep-list : list -> number

;; To create depth function which determines how many times 'cons' was used
;;(define (depth list) (cond
                      ;; [(empty? list) empty]
                       ;;[else

;; first we must extract the list of 'cons'
                       ;; (cond 
                       ;; [(symbol=? 'cons (first list))

 ;; add1 because you want to count the occurence of 'cons
                       ;; (add1

  ;; recursion to look at rest of list by using sub1 and +1 because we can assume the first list has a 'cons    
                       ;;  (depth (rest list)))]
                       ;;[else (depth (rest list))])]))


(define (depth list-of-list) (cond
                       [(empty? list-of-list) 0]
                       [else (add1 (depth (rest list-of-list)))]))
;;test
(depth (cons 8 (cons 3 (cons 4 (cons 5 empty)))))

;; function that produces a list containg symbol cons with n(cons)
;; make-deep : symbol number -> number
;;template
(define (make-deep s number) (cond
                                    [(zero? number) empty]
                                    [else (cons s (make-deep s (sub1 number)))]))

;;test 
(make-deep 'red 5)

;; Exercise 11.3.1
  ;;random-n- : integer integer -> integer
  ;; to randomise number between two given numbers by calculating the difference and than adding the randomised number to the margin 

    ;;i.e. ___________________________________________________
    ;;               I=====================I
    ;;    0          3                     8

(define (random-n-m n m) (+ (random (- m n)) n))

       ;;test example
       (random-n-m 10 800)

;;Exercise 11.3.2
;;tie-dyed : number -> list of random numbers

;;first auxillary is to randomise the number prior to creating a list
(define (randomised-n l m) (+ ( random (- m l)) l))
(randomised-n 20 120)

;;then use that random number to create a list
(define (tie-dyed randomised) (cond
                            [(randomised-n 20 120)(zero? randomised) empty]
                            [(randomised-n 20 120)(cons 'list (tie-dyed (sub1 randomised)))]
                            [else (error 'tie-dyed "expected natural number")]))
                                    
(define (tie-dyed number-20-120)
;;test
(tie-dyed ...)


