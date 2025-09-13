;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fingerexercises_4) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp")) #f)))
;;Processing lists
 ;; hours-to-wages function : list of number -> list of numbers

;;Auxillary
(define (wages hours) (* 12 hours))

  ;; will start off with the same template where we use recursion for the (rest lon)
   ;; template
     ;;(define (hours-to-wages lon) (cond
                                    ;;[(empty? lon) 'empty]
                                   ;; [...(first lon)... (hours-to-wages(rest lon))]))

;; the second clause must compute the weekly wage of (first lon) and consruct a list for ALL wages
 ;; we must add auxillary function 'wages' to the (first lon)
  ;; then cons the (rest lon) recursion with first member i.e.
(define (hours-to-wages lon) (cond
                               [(empty? lon) 0]
                               [else (cons (wages (first lon)) (hours-to-wages (rest lon)))]))

;;checked-hours : list -> boolean
(define (checked-hours lon) (cond
                              [(empty? lon) true]
                              [else (cond
                                      [( > 100 lon) true]
                                      [else (error 'checked-hours "too many hours")])]))

;; refined version to include checked-hours
(define (hours-to-wages2 lon) (cond
                               [(empty? lon) empty]
                               [else (cond
                                       [(checked-hours (first lon))
                                        (cons (wages (first lon)) (hours-to-wages2 (rest lon)))]
                                       [else (hours-to-wages2 (rest lon))])]))

;;test
(define listed (cons 10 (cons 5 (cons 0 (cons 0 empty)))))
(hours-to-wages2 listed)

;; converts a list of US dollars to Enro amounts using an echange rate 1.22 for every US dollar
;; Auxillary function is the exchange rate
(define (exchange US$) (* 1.22 US$))

;; convert-euro : lod -> loe
(define (convert-euro lod) (cond
                             [(empty? lod) empty]
                             [else (cons (exchange (first lod)) (convert-euro (rest lod)))]))
;;test
(convert-euro (cons 1.00 (cons 10.00 (cons 0 empty))))


;; eliminate-exp : list -> list
;; eliminate expensive toys above the value of ua

(define (eliminate-exp ua lot) (cond
                                 [(empty? lot) empty]
                                 [(>= ua (first lot))
                                  (cons (first lot) (eliminate-exp ua (rest lot)))]
                                 [else (eliminate-exp ua (rest lot))]))
                                  
;;test
(eliminate-exp 1.0 (cons 2.95 (cons .95 (cons 1.0 (cons 5 empty)))))

;; name-robot : list -> list
(define (name-robot symbol lot) (cond
                           [(empty? lot) empty]
                           [(symbol=? 'robot (first lot)) (cons 'r2d2 (name-robot symbol (rest lot)))]
                           [else (cons (first lot) (name-robot symbol (rest lot)))]))

;; test
(name-robot 'robot (cons 'doll (cons 'ball (cons 'robot empty))))


(define (recall ty lon) (cond
                          [(empty? lon) empty]
                          [(not (symbol=? ty (first lon))) (cons (first lon) (recall ty (rest lon)))]
                          [else (recall ty (rest lon))]))

;;test
(recall 'robot (cons 'robot (cons 'doll (cons 'dress empty))))


(define-struct ir (name price))

(define (contains-doll? inv-list) (cond
                                    [(empty? inv-list) empty]
                                    [else (cond
                                      [(symbol=? 'doll (ir-name (first inv-list))) true]
                                      [else (contains-doll? (rest inv-list))])]))

;;test
(contains-doll? (cons (make-ir 'robot 11.00) ( cons (make-ir 'doll 10.00) empty)))

;; inventory that includes picture with each object
(define-struct inv (name price image))

(define (show-picture symbol inv-list) (cond
                                              [(empty? inv-list) empty]
                                              [(symbol=? symbol (inv-name (first inv-list))) (cons (first inv-list)(show-picture symbol (rest inv-list)))]
                                              [else (show-picture symbol (rest inv-list))]))

;; phone directory that combines phone number and names
(define-struct directory (name phone))

;; whose-number : symbol -> num-symbol
(define (whose-number name directory) (cond
                                          [(empty? directory) empty]
                                          [(symbol=? name (directory-name (first directory)))
                                           (cons (first directory)(whose-number name (rest directory)))]
                                          [else (error 'whose-number "unknown number")]))

;;test
(whose-number 'joe (cons (make-directory 'joe 021113) (cons (make-directory 'harky 02111555) (cons (make-directory 'lily 090909) empty))))