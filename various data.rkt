;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |various data|) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp")) #f)))
;; A variety of data


;; distance-to-0 : pixel-2 -> number
;; to compute the distance of a-pixel to the origin
(define (distance-to-0 a-pixel)...)
;; add cond clause because there are two kinds of input i.e. a number and pixel
(define (ditance-to-0 a-pixel) (cond
                                 [(number? a-pixel)...]
                                 [(posn? a-pixel)...]))

;; add selector expressions to remind us of inputs
(define (distance-to-0 a-pixel) (cond
                                  [(number? a-pixel)...]
                                  [(posn? a-pixel) .. (posn-x a-pixel)... (posn-y a-pixel)]))

;; complete function with the equation to find ditance-to-0 i.e. pythagoras
(define (distance-to-0 a-pixel) (cond
                                  [(number? a-pixel) a-pixel]
                                  [(posn? a-pixel) ( sqrt
                                                     ( + (sqr posn-x a-pixel) (sqr posn-y a-pixel)))]))

;;Exercise 7.1.2
;; perimeter : shape -> number
;; to compute the permeter of a-shape
(define (perimeter a-shape) (cond
                              [(square? a-shape)...]
                              [(circle? a-shape)...]))

;;define structure of each shape
(define-struct square (posn length))
(define-struct circle (centre radius))

;;to calculate perimeter
  ;;square = 4 * side
  ;; circle = 2 * radius * pi
(define (perimeter a-shape) (cond
                             [(square? a-shape) (square-posn a-shape) (square-side a-shape)...]
                             [(circle? a-shape) (circle-centre a-shape) (circle-radius a-shape) ...]))

;; add calculations and remove selectors that not applicable
(define (perimeter a-shape) (cond
                             [(square? a-shape) ( * (square-side a-shape) 4)]
                             [(circle? a-shape) ( * pi ( * 2 (circle-radius a-shape)))]))

;;Exercise 7.1.3
;; area : shape -> number
;; to compute the area of a shape i.e. square or circle
;; template
(define (area a-shape) (cond
                         [(square? a-shape) (square-posn a-shape) (square-length a-shape) ...]
                         [(circle? a-shape) (circle-centre a-shape) (circle-centre a-shape)...]))

;; add calculation and remove unneccessary selectors
(define (area a-shape) (cond
                         [(square? a-shape) ( sqr (square-length a-shape))]
                         [(circle? a-shape) ( * pi ( sqr (circle-radius a-shape)))]))

;;Exercise 7.2.1
;;define structure of zoo animals i.e. spiders, elephants, monkey
(define-struct spider (legs space))
(define-struct elephant (space))
(define-stuct monkeys (intelligence space))
(define zoo ((make-spider legs space) (make-elelphant space) (make-monkey intelligence space))

 (define (fits an-animal cage) (cond
                            [(spider? an-animal) ( <= (spider-space an-animal) cage)]
                            [(elephant? an-animal) ( <= (elephant-space an-animal) cage)]
                            [(monkey? an-animal) ( <= (monkey-space an-animal) cage)]))
  



