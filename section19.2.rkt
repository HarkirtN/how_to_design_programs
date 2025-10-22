;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname section19.2) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
;; similarities in data definitions/structures

(define-struct ir (name price))

;;below : number lon -> lon
;;create a list of numbers in alon that are below t
(define (below alon t) (cond
                         [(empty? alon) empty]
                         [else (cond
                                 [(< (first alon) t) (cons (first alon) below (rest alon) t)]
                                 [else (below (rest alon) t)])]))

;;below-ir : number lor -> lor
;;create a list of records in lor that are price below t
(define (below-ir lor t) (cond
                           [(empty? lor) empty]
                           [else (cond
                                   [(<ir (first lor) t) (cons (first lor) (below-ir (rest lor) t))]
                                   [else (below-ir (rest  lor) t)])]))

;;<ir : IRnumber -> boolean
(define (<ir ir price) (< (ir-price) price))

;;can also insert filter1 as it is generalised and follows the same shape
(define (filter1 rel-op alon t) (cond
                                  [(empty? alon) empty]
                                  [else (cond
                                          [(rel-op (first alon) t) (cons (first alon) (filter1 rel-op (rest alon) t))]
                                          [else (filter1 rel-op (rest alon) t)])]))
;;then it can be applied
(define (below-ir1 lor t) (filter1 <ir lor t))

;;then it can be applied as long it is a list with numbers
;;therefore we need the function that compares items on the list i.e. define ... (> item1 item2) and then pass on to filter1

;;find : lor symbol-> boolean
;;to compute whether lor contains a record for t
(define (find lor t) (cons? (filter1 eq-ir? lor t)))

;;eq-ir? : IR symbol -> boolean
;;to compare ir's name with p
(define (eq-ir? ir p) (symbol=? (ir-name ir) p))

;;length : (listof X) -> number
;; introduction to listof abbreviation which suggests exactly its name 'a list of' x
;; computes the length of a length
(define (length1 alon) (cond
                        [(empty? alon) empty]
                        [else (+ (length1 (rest alon)) 1)]))

;;exercise 19.2.3
(define-struct pair (left right))

;;(listof (pair number number))
;;(listof (pair symbol number))
;;(listof (pair symbol symbol))

(define (lefts listof) (cond
                      [(empty? listof) empty]
                      [(pair? listof) (cons (pair-left listof) (lefts (rest listof)))]))

;;exercise 19.2.4
;;last : list -> item
;; produces the last item in that list
(define (last non-emptylist) (cond
                      [(empty? non-emptylist) false]
                      [else (local ((define l (last (rest non-emptylist))))
                              (cond
                                [(cons? l) l]
                                [(boolean? l) (first non-emptylist)]))]))