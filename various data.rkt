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
;;(define (distance-to-0 a-pixel) (cond
                                  ;;[(number? a-pixel)...]
                                  ;;[(posn? a-pixel) .. (posn-x a-pixel)... (posn-y a-pixel)]))

;; complete function with the equation to find ditance-to-0 i.e. pythagoras
;;(define (distance-to-0 a-pixel) (cond
                                  ;;[(number? a-pixel) a-pixel]
                                  ;;[(posn? a-pixel) ( sqrt
                                                     ;;( + (sqr posn-x a-pixel) (sqr posn-y a-pixel)))]))

;;Exercise 7.1.2
;; perimeter : shape -> number
;; to compute the permeter of a-shape
;;(define (perimeter a-shape) (cond
                              ;;[(square? a-shape)...]
                              ;;[(circle? a-shape)...]))

;;define structure of each shape
(define-struct square (posn length))
;;(define-struct circle (centre radius))

;;to calculate perimeter
  ;;square = 4 * side
  ;; circle = 2 * radius * pi
;;(define (perimeter a-shape) (cond
                             ;;[(square? a-shape) (square-posn a-shape) (square-side a-shape)...]
                             ;;[(circle? a-shape) (circle-centre a-shape) (circle-radius a-shape) ...]))

;; add calculations and remove selectors that not applicable
(define (perimeter a-shape) (cond
                             [(square? a-shape) ( * (square-length a-shape) 4)]
                             [(circle? a-shape) ( * pi ( * 2 (circle-radius a-shape)))]))


;;Exercise 7.1.3
;; area : shape -> number
;; to compute the area of a shape i.e. square or circle
;; template
;;(define (area a-shape) (cond
                         ;;[(square? a-shape) (square-posn a-shape) (square-length a-shape) ...]
                         ;;[(circle? a-shape) (circle-centre a-shape) (circle-centre a-shape)...]))

;; add calculation and remove unneccessary selectors
(define (area a-shape) (cond
                         [(square? a-shape) ( sqr (square-length a-shape))]
                         [(circle? a-shape) ( * pi ( sqr (circle-radius a-shape)))]))


;;Exercise 7.2.1
;;define structure of zoo animals i.e. spigiders, elephants, monkey
(define-struct spider (legs space))
(define-struct elephant (space))
(define-struct monkeys (intelligence space))


 (define (fits an-animal cage) (cond
                            [(spider? an-animal) ( <= (spider-space an-animal) cage)]
                            [(elephant? an-animal) ( <= (elephant-space an-animal) cage)]
                            [(monkeys? an-animal) ( <= (monkeys-space an-animal) cage)]))


 ;;Exercise 7.4.1
  ;;data definitions for shapes
   (define-struct circle (centre radius colour))
  ;; a circle is a structure (make-circle posn number symbol)
  
   (define-struct rectangle (upper-corner width height colour))
  ;; a rectangle is a structure (make-rectangle posn number number symbol)

  ;;a shape is either a circle or rectangle


;;Develop fun-for-shape function template ONLY
  ;;(define (fun-for-shape shape) (cond
                                  ;;[(circle? shape) (circle-centre shape) (circle-radius shape) (circle-colour shape)...]
                                  ;;[(rectangle? shape) (rectangle-upper-corner shape) (rectangle-width shape) (rectangle-height shape) (rectangle-colour shape)...]))


;;function draw-shape using above template
       ;;first auxiallry function draw-a-circle
         (define (draw-a-circle shape) (draw-solid-disk (circle-centre shape)
                                                        (circle-radius shape)
                                                        (circle-colour shape)))

       ;;second auxillary function draw-a-rectangle
         (define (draw-a-rectangle shape) (draw-solid-rect(rectangle-upper-corner shape)
                                                              (rectangle-width shape)
                                                              (rectangle-height shape)
                                                              (rectangle-colour shape)))

      ;;simplified draw-shape function
       (define (draw-shape shape) ( cond
                                [(circle? shape) (draw-a-circle shape)]
                                [(rectangle? shape) (draw-a-rectangle shape)]))



;;translate shape using template
      ;; first auxillary function is a circle
      (define (translate-circle shape delta) (draw-solid-disk (circle-centre ( make-posn ( + delta (posn-x shape))
                                                                              (posn-y shape)))
                                                               (circle-radius shape)
                                                               (circle-colour shape)))
  
     ;;second auxillary function is a rectangle
     (define (translate-rectangle shape delta) (draw-solid-rect (rectangle-upper-corner (make-posn ( + delta (posn-x shape)
                                                                                         (posn-y shape))))
                                                                 (rectangle-width shape)
                                                                 (rectangle-height shape)
                                                                 (rectangle-colour shape)))
  
    ;;simplified translate-shape function
    (define (translate-shape shape delta) (cond
                                   [(circle? shape) (translate-circle shape delta)]
                                   [(rectangle? shape) (translate-rectangle shape delta)]))

  

;;clear-shape using template
   ;;first auxillary function of clear-circle
   (define (clear-a-circle shape) (clear-solid-disk (circle-centre shape)
                                                   (circle-radius shape)
                                                   'white))

   ;;second clear-rectangle auxillary function
   (define (clear-a-rectangle shape) (clear-solid-rect (rectangle-upper-corner shape)
                                                      (rectangle-width shape)
                                                      (rectangle-height shape)
                                                      'white))
   ;;simplified clear-shape function
   (define (clear-shape shape) (cond
                                [(circle? shape)(clear-a-circle shape)]
                                [(rectangle? shape) (clear-a-rectangle shape)]))
                               



;;draw-and-clear-shape using template
 (define (draw-and-clear-shape shape) (cond
                                         [(circle? shape) ( and (draw-solid-disk shape) (sleep-for-a-while ...) (clear-a-circle shape))]
                                         [(rectangle? shape) (and (draw-solid-rect shape) (sleep-for-a-while ...) (clear-a-rectangle shape))]))



;;move-shape using template
  (define (move-shape shape delta) (cond
                                     [(circle? shape)(and (draw-and-clear-shape shape) (translate-circle shape delta))]
                                     [(rectangle? shape) (and (draw-and-clear-shape shape) (translate-rectangle shape delta))]
                                     [else 'unknownShape]))
  