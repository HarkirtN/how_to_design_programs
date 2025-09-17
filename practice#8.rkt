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
(define x 5)
;; auxillary function
(define (f x)(+
              (* 3 (* x x))
                (+ (* -6 x) -1)))

;; f : number -> number
(define (tabulate-f n) (cond
                     [(zero? n) empty]
                     [else (cons (- n 1) (tabulate-f (sub1 n)))]))


;;test
(tabulate-f 5)


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
;;(define (tie-dyed randomised) (cond
;;                            [(zero? randomised) empty]
;;                            [(randomised-n 20 120) (cons 'list (tie-dyed (sub1 randomised)))]
;;                            [else (error 'tie-dyed "expected natural number")]))

(define (tie-dyed number) (cond
                                [(zero? number) empty]
                                [else (cons (randomised-n 20 120) (tie-dyed (sub1 number)))]))
                              
;;test
(tie-dyed 0)
(tie-dyed 1)
(tie-dyed 2)
(tie-dyed 10)


;;Exercise 11.3.3
;;create temps : number, high, & low temp -> list
;; to create a list of temperature between the low and high x number of times
(define (create-temps x low high) (cond
                                    [(zero? x) empty]
                                    [else (cons (randomised-n low high) (create-temps (sub1 x) low high))]))
;;test
(create-temps 3 50 100)

;;can we feed create-temps list into check-range
;; let's try
;;(define (check-temperature temp) (or (> 5 temp) (< 95 temp)))

;;(define (check-range1 x low high) (cond
                              ;; [(empty? (create-temps x low high)) empty]
                               ;;[else (cond
                               ;;  [(check-temperature (first (create-temps x low high))) false]
                                ;; [else (check-temperature (rest (create-temps x low high)))])]))

;;test
;;(check-range1 5 10 150)

;;food for thought
;; can we simply feed it into the check-range function - it expects a real number for the check-temperature function where first does not extract the value only provides the whole list

;; values of low and high needed ? No because the check-temperature function's purpose is to detect out-of-range temps, ultimately both want to achieve similar result
  ;;i.e. check-temperature check out of range temps
  ;;i.e. create-temps produce a randomised list within range is it safe to say that this will always be within the range 5-95 if parameters are set

;; what does this say about testing with auto generated data = that you could create a test using just AGD if parameters are set

;;Exercise 11.3.4
;; create-prices : number -> list
;; to produce a list of prices between $0.10 - $10 in increments of 0.10 (dimes)

;;alter the randomisation function?
(define (random-dime l m) (/ (+ ( random (- (* 100 m) (* 100 l))) l) 100))

;; increments of 0.10
(define (create-prices n dime dollar) (cond
                                        [(zero? n) empty]
                                        [else (cons (... (random-dime dime dollar)) (create-prices (sub1 n) dime dollar))]))

;;test
(random-dime 0.10 10)
(create-prices 5 0.10 10)

;;Exercise 11.4.1
(define (! n) (cond
                [(zero? n) 1]
                [else (* n (! (sub1 n)))]))
;;this function attempts to multiply all numbers from n to 0 (excludes 0)
;;first function resolves the issue of no numbers between 0 - 0 by setting !0 equal to 1

;;test 
(! 4) ;; 4 * 3 * 2 * 1
(! 5) ;; 5 * 4 * 3 * 2 * 1

;; then you can utilise (!) to multiply n from n for example a product from 20 will multiply all number greater than 20 to n

;; Exercise 11.4.3
(define (product-from-minus-11 n) (cond
                                    [(= n -11) 1]
                                    [else (* n (product-from-minus-11 (sub1 n)))]))

;;add into tabulate function ???????

;;auxillary function first
(define (from-20 n) (cond
                      [(= n 20) 1]
                      [else (* n (from-20 (sub1 n)))]))

;; add
(define (tabulate-f20 n) (cond
                           [(zero? n) empty]
                           [else (cons (from-20 n)(tabulate-f20(sub1 n)))]))

;;test
(tabulate-f20 21)

