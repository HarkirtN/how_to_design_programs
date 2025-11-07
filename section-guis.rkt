;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname section-guis) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp") (lib "gui.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp") (lib "gui.rkt" "teachpack" "htdp")) #f)))
;;Creating GUIs

;; text-field : (make-text a-string)
;; buttons : (make-button a-string a-function)
;; choice-menus : (make-choice list-strings)
;; message-fields : (make-message a-string)


;;to create a window with a "close" button and call-back "hide window"
;;(create-window (list (list (make-button "close" hide-window))))

;;create a function echo-message obtain the text in 'text field' and draws string into message
(define a-text (make-text "enter-text:"))
(define a-message (make-message "'hello world' is a silly program."))
(define (echo-message e) (draw-message a-message (a-text)))
(create-window (list (list a-text a-message) (list (make-button "copy now" echo-message))))

;; create a 'copy now' button that echoes message, so user can enter text in field
;; outer bracket create a window with choice menu, message, and a button - places the current choice into the message field
(define THE-CHOICES (list "green" "red" "yellow"))
(define a-choice (make-choice THE-CHOICES))
(define choice-message (make-message (first THE-CHOICES)))

;; function finds the index of users current choice using "list-ref" to extract string from THE-CHOICES
;; then draws result into text field
(define (echo-choice e) (draw-message a-message (list-ref THE-CHOICES (choice-index a-choice))))

;;then create the window and button
(create-window (list (list a-choice a-message) (list (make-button "confirm choice" echo-choice))))


;;creating gui for echoing digits as numbers

;; translate a list of digits into a number
;; build-number : (listof digits) -> number
(define (build-number list) (cond
                              [(empty? list) 0 ]
                              [else (+ (first list) (* 10 (build-number (rest list))))]))

;test
;;(build-number (list 1 2 4 ))

;;ten digits into string 
(define DIGITS (build-list 10 number->string))

;;a list of 3 digits choice menus
(define digit-choice (local ((define (builder i) (make-choice DIGITS)))
                        (build-list 3 builder)))

;; a message field to say hello and display a number
(define a-msg (make-message "welcome"))

;;to obtain current choice of digits and convert to number
;;then draw this number to message field

(define (check-num b) (draw-message a-msg (number->string (build-number (map choice-index digit-choice)))))

(create-window (list (append digit-choice (list a-msg)) (list (make-button "check-guess" check-num))))


;;creating number-guessing game
;; use build number function to convert list of digits to strings 
(define (guess-number lod) (+ (first lod) (* 10 (guess-number (rest lod)))))

;;view
;; 3 digits as string
(define my-digits (build-list 3 number->string)))

;;list of 3 digit choice menus
(define choose-digits (local ((define (build-number x) (make-choice my-digits)))
                         (build-list 3 build-number)))

;;the message
(define guess-entry (make-message "hello"))

;;controller

