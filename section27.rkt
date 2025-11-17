;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname section27) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp") (lib "gui.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp") (lib "gui.rkt" "teachpack" "htdp")) #f)))
;;sierpinski triangle
;; posn posn posn -> true all drawing functions must produce true
;;draw triangle down at a,b and c asumming it is large enough

(define (sierpinski a b c) (cond
                             [(too-small? a b c) true]
                             [else (local ((define a-b (mid-point a b))
                                           (define b-c (mid-point b c))
                                           (define c-a (mid-point a c)))
                                     (and (draw-triangle a b c)
                                          (sierpinski a a-b c-a)
                                          (sierpinski b a-b b-c)
                                          (sierpinski c c-a b-c)))]))

;;mid-point : posn posn -> posn
;;to create a mid-point between two positions
(define (mid-point a-posn b-posn) (make-posn (midi (posn-x a-posn) (posn-x b-posn))
                                             (midi (posn-y a-posn) (posn-y b-posn))))

;;mid : number number -> number
;; to compute the average of x and y
(define (midi x y) (/ (+ x y) 2))

;;draw-triangle : posn posn posn -> true
;; to draw a triangle
(define (draw-triangle a b c) (and (draw-solid-line (make-posn (posn-x a) (posn-y a)) (make-posn (posn-x b) (posn-y b)) 'blue)
                                   (draw-solid-line (make-posn (posn-x a) (posn-y a)) (make-posn (posn-x c) (posn-y c)) 'blue)
                                   (draw-solid-line (make-posn (posn-x b) (posn-y b)) (make-posn (posn-x c) (posn-y c)) 'blue)))

;;too-small? : posn posn posn -> boolean
;;to compute when a triangle is too small to be drawn - doesnt work
(define (too-small? a b c) (and (< a (make-posn (posn-x a) (posn-y a)))
                                (< b (make-posn (posn-x b) (posn-y b)))
                                (< c (make-posn (posn-x c) (posn-y c)))))

(define A (make-posn 200 0))
(define B (make-posn 27 300))
(define C (make-posn 373 300))

;;(start 400 400)
;; (draw-triangle A B C)
;;(sierpinski A B C)

;;list-of-lines
(list 'NL) ;; = (list (list empty))
(list 'NL 'NL) ;;= (list (list empty)(list empty))
empty ;;= (list empty)

(define NEWLINE 'NL)

;; file->lines : file -> (listof (listof symbols))
;; convert a file into a list of lines
(define (file->lines a-file) (cond
                               [(empty? a-file) empty]
                               [else (cons (first-line a-file) 
                                     (file->lines (remove-first-line a-file)))]))

;; first-line : file -> (listof symbols)
;; to create a list of a-file up to the first occurence of NEWLINE
(define (first-line a-file) (cond
                              [(empty? a-file) empty]
                              [else (cond
                                      [(symbol=? (first a-file) NEWLINE) empty]
                                      [else (cons (first a-file) (first-line (rest a-file)))])]))

;; remove-first-line : file -> (listof symbols)
;; to create a suffix of a-file behind the first occurence of NEWLINE
(define (remove-first-line a-file) (cond
                                     [(empty? a-file) empty]
                                     [else (cond
                                             [(symbol=? (first a-file) NEWLINE) (rest a-file)]
                                             [else (remove-first-line (rest a-file))])]))

;;exercise 27.2.2
;; abstract the first and remove-first
(define (first-first a-file) (cond
                               [(empty? a-file) empty]
                               [else (local ((define check (symbol=? (first a-file) NEWLINE))
                                             (define the-rest (first-first (rest a-file))))
                                       (cond
                                         [check empty]
                                         [else (cons (first a-file) the-rest)]))]))


 (define (removing a-file) (cond
                           [(empty? a-file) empty]
                           [else (local ((define checking (symbol=? (first a-file) NEWLINE))
                                         (define rest (removing (rest a-file))))
                                   (cond
                                     [checking (rest a-file)]
                                     [else rest]))]))

                                      
;;exercise 27.2.3
;; files : file -> (listof numbers)
;; to convert a file into a list of numbers
(define (files a-file) (cond
                         [(empty? a-file) empty]
                         [else (cons (first-nums a-file) (files (remove-nums a-file)))]))

(define (first-nums a-file) (cond
                              [(empty? a-file) empty]
                              [else (cond
                                      [(symbol=? (first a-file) NEWLINE) empty]
                                      [else (cons (first a-file) (first-nums (rest a-file)))])]))

(define (remove-nums a-file) (cond
                               [(empty? a-file) empty]
                               [else
                                (cond
                                  [(symbol=? (first a-file) NEWLINE) (rest a-file)]
                                  [else (remove-nums (rest a-file))])]))
;;test
(files (list 2.30 4.00 12.50 13.50 'NL 4.00 18.00 'NL 2.30 12.50))