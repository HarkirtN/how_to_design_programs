;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname addressbook_GUI) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp") (lib "gui.rkt" "teachpack" "htdp") (lib "graphing.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp") (lib "gui.rkt" "teachpack" "htdp") (lib "graphing.rkt" "teachpack" "htdp")) #f)))
;; set! address-book GUI

(define address-book empty) ;;address-book variable is defined here

;;add-to-address-book : symbol number -> void
(define (add-to-address-book name phone) (set! address-book
                                               (cons (list name phone) address-book)))

;;look-up : symbol (listof (list symbol number)) -> false or number
;; to look-up the name and return a phone-number
(define (look-up name addressb) (cond
                                  [(empty? addressb) false]
                                  [else (cond
                                          [(symbol=? (first (first addressb)) name) (second (first addressb))]
                                          [else (look-up name (rest addressb))])]))

;; working through the example by hand
;; test
(begin (add-to-address-book 'adam 1)
       (add-to-address-book 'Eve 2)
       (add-to-address-book 'chris 456))

;; substitute into the add-to-address-book function
;;(begin (set! address-book (cons (list 'adam 1) empty))
       ;;(add-to-address-book 'Eve 2)
       ;;(add-to-address-book 'chris 456))

;; change the definition of address-book to adam 1 as it has been added and continue
;;(define address-book (cons (list 'adam 1) empty))

;;(begin (void)
       ;; (set! address-book (cons (list 'Eve 2)
                 ;;                (list 'adam 1) empty))
       ;; (add-to-address-book 'chris 456))

;;exercise 35.4.1
;; remove : symbol -> void
;; to remove an entry replace with empty
(define (removing a-name)
  (set! address-book (cons (list a-name empty) address-book)))

;;test
(removing 'adam)
(look-up 'adam address-book)

