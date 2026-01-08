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

;; state variables are variables that change their value which indicate a change in memory
;; service that changes memory will need to use set!
;; prior to changing state variables need to understand what kind of value you are dealing with and and its purpose

;;addy : (listof (list symbol number))
;; to keep track of pairs of names and phone numbers
(define addy empty)

;; addy stands for a list (cons (list 'adam 1) address-book) constructs a longer list
;; set! changes the state variable addy of a different class of (listof (list symol number))
(set! addy (cons (list 'amy 1) addy))

;; current-light : TL-colour
;; to track the current colour of traffic light
(define current-light 'red)

;; if we wanted to change we use set!
(set! current-light 'green)

;; some cases you may need to use a function to create a new value
;; next-colour : TL-colour -> TL-colour
;; to compute the next colour for traffic light
(define (next-colour c)
  (cond
    [(symbol=? 'red c) 'green]
    [(symbol=? 'green c) 'yellow]
    [(symbol=? 'yellow c) red]))

;;using auxiallry function next-colour we can then use set!
(set! current-light (next-colour current-light))

