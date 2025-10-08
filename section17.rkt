;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname section17) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
;;exercise 17.1.1
;; our-append : lists of numbers -> one list
(define (our-append list1 list2 list3) (cond
                                         [(empty? list1) (append list2 list3)]
                                         [else (list (first list1) (our-append (rest list1) list2 list3))]))

(our-append (list 'a) (list 'b 'c) (list 'd 'e 'f))

;;exercise 17.1.2
;; cross : list-of-symbols list-of-numbers -> combined list of different symbols/number combos
(define (cross-both list1 list2) (list (first list1) list2))

(define (cross list1 list2) (cond
                              [(empty? list1) list2]
                              [else (append (cross-both list1 list2) (cross (rest list1) list2))]))



(cross (list 'a 'b 'c)  (list 'a 'b))

;;exercise 17.2
;;weekly-wage : number number -> number
;;to compute the weeklyw age from thee pay-rate and hours-worked
(define (weekly-wage pay-rate hours) (* pay-rate hours))

;;to create a new list with multiplying corresponding items 
;;(define (total-wage list1 list1) (cond
                                 ;;  [(empty? list1) empty];;assumption is if one list is empty the other is too
                                 ;;  [else (cons (weekly-wage (first list1) (first list2)) (total-wage (rest list1) (rest list2)))]))

;;exercise 17.2.1
;;modify above total-wage function so it specifies elements within a structure for work list
(define-struct work (name hours-worked))
(define-struct employee (name ssn pay-rate))

(define (total-wage list1 list2) (cond
                                   [(empty? list1) empty]
                                   [else (cons (weekly-wage (work-hours-worked (first list1)) (employee-pay-rate (first list2))) (total-wage (rest list1) (rest list2)))]))

(define-struct phone-record (name number))

(define (zip lon los) (cond
                        [(empty? los) empty]
                        [else (cons (make-phone-record (first los) (first lon)) (zip (rest los) (rest lon)))]))

;;exercise 17.3
;;(define (list-pick alos n) (cond
                            ;; [(and (= n 1) (empty? alos)) (error 'list-pick "list too short")]
                            ;; [(and (> n 1) (empty? alos)) (error 'list-pick "list too short")]
                            ;; [(and (= n 1) (cons? alos)) (first alos)]
                            ;; [(and (> n 1) (cons? alos)) (list-pick (rest alos)(sub1 n))]))

(define (list-pick0 alos n) (cond
                              [(and (= n 0) (empty? alos)) (error 'list-pick0 "list too short")]
                              [(and (> n 0) (empty? alos)) (error 'list-pick0 "list too short")]
                              [(and (= n 0) (cons? alos)) (first alos)]
                              [(and (> n 0) (cons? alos)) (list-pick0 (rest alos) (sub1 n))]))

;;exercise 17.4
;;simplify list-pick
;; we know that first two conditions produce same output that is determined by empty? alos
 ;; therefore we can simplify this using morgans law of distributivity
    ;; [(and (or condition1 condition2) a-condition)] = [(and (or (= n 1) (> n 1)) empty? alos)) (error 'list-pick "list too short")]
    ;; we know that first two conditions equate to N [>= 1] so hold true further simiplified to : ( and true (empty? alos))
    ;; = [(empty? alos) (error 'list-pick "list too short")]

;;we know we have filtered out it is not a empty list by the time we get to the last two conditions, so (cons? alos) can be removed
 ;; simiplified version
    (define (list-pick alos n) (cond
                                 [(empty? alos) (error 'list-pick "list too short")]
                                 [(= n 1) (first alos)]
                                 [(> n 1) (list-pick (rest alos) (sub1 n))]))

;;exercise 17.4.1

(define (replace-with alon1 alon2) (cond
                                     [(empty? alon1) empty]
                                     [(empty? alon2) empty]
                                     [else (cons (+ (first alon1) (first alon2)) (replace-with (rest alon1) (rest alon2)))]))

;;simiplify
;;to simplify we can apply morgans law = [(empty? (and alon1 alon2)) empty]

(define (replace-with2 alon1 alon2) (cond
                                      [(empty? (and alon1 alon2)) empty]
                                      [else (cons (+ (first alon1) (first alon2)) (replace-with2 (rest alon1) (rest alon2)))]))

;;exercise 17.4.2
;;simplify list-pick0
 ;; we can apply morgans law again to the first two conditions clauses as they both result to an error message
 ;; [(or (and condition1 condition2) a-condition)] = [(and (or (= n 0) (> n 0)) (empty? alos)) (error 'list-pick0 "list too short")]
 ;; N [> = 0] = [(empty? alos) (error 'list-pick0 "list too short")]

;; then last two clauses we know have filtered empty? so we remove cons
  ;; = [(= n 0) (first alos)]
  ;; = [(> n 0) (list-pick0 (rest alos) (sub1 n))]

;;exercise 17.6
;; to create a list from a two lists of numbers in an ascending order
;; merge : list1 list2 -> list

;;auxillary function to sort a list
(define (sort-list alon) (cond
                           [(empty? alon) empty]
                           [(cons? alon) (insert (first alon) (sort-list (rest alon)))]))

(define (insert n alon) (cond
                          [(empty? alon) (cons n empty)]
                          [(< n (first alon)) (cons n alon)]
                          [(>= n (first alon)) (cons (first alon) (insert n (rest alon)))]))

;;test
(sort-list (cons 4 (cons 8 (cons 5 empty))))

(define (new-list alon1 alon2) (cond
                                 [(empty? alon1) alon2]
                                 [else (cons (first alon1) (new-list (rest alon1) alon2))]))

(define (merge alon1 alon2) (cond
                                 [(and (empty? alon1)(empty? alon2)) true]
                                 [(empty? alon1) (sort-list alon2)]
                                 [(empty? alon2) (sort-list alon1)]
                                 [else (sort-list (new-list alon1 alon2))]))



;;test
(new-list (cons 2 (cons 11 (cons 1 empty))) (cons 2 (cons 1 (cons -3 empty))))

;;test
(merge (list 1 3 5 7 9) (list 0 2 4 6 8))

;;exercise 17.6.3
(define-struct record (name number rate))

(define-struct card (number hours))

(define (wage pay-rate hours) (* pay-rate hours))

;;(define (hour->wages list1 list2) (cond
                                   ;; [(or (empty? list1) (empty? list2)) (error 'hours->wages "list too short")]
                                   ;; [else (cond
                                           ;; [(not (= (record-number (sort-list (first list1))) (card-number (sort-list (first list2))))) (error 'hours-wages "mismatched numbers")]
                                           ;; [else (cons (wage (record-rate (first list1)) (card-hours (first list2))) (hour->wages (rest list1) (rest list2)))])]))


;;simplify
(define (check-number list1 list2) (cond
                                     [(= (record-number (sort-list (first list1))) (card-number (sort-list (first list2)))) true]
                                     [else (error 'hours-wages "mismatched numbers")]))

(define (hour->wages list1 list2) (cond
                                    [(or (empty? list1) (empty? list2)) (error 'hours->wages "list too short")]
                                    [(check-number list1 list2) (cons (wage (record-rate (first list1)) (card-hours (first list2))) (hour->wages (rest list1) (rest list2)))]))

;;exercise 17.6.4
;; value : list-of-numbers list-of-equation -> number
;; to compute the value of polynomial (equation) from two lists i.e. 5 * x + 17 * y + 3 * z

;;auxillary function
(define (add-up polynomial n) (* polynomial n))

(define (poly-list list1 list2) (cond
                              [(empty? list1) empty]
                              [else (cons (add-up (first list1) (first list2)) (poly-list (rest list1) (rest list2)))]))
;;test
(poly-list (list 5 17 3) (list 1 1 1))

(define (value list1 list2) (cond
                              [(and (empty? list1) (empty? list2)) 0]
                              [(poly-list list1 list2) (+ (first (poly-list list1 list2))
                                                          (value (rest (poly-list list1 list2)) (rest (poly-list list1 list2))))]))

;;test
(value (list 5 17 3) (list 1 1 1))
