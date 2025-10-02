;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname practice#14) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp")) #f)))
;;exercise 16.2.1
;;file is a symbol
;;directory is a list either empty; file + directory ; directory1 + directory2

;;template
;;(define (file a-file) (cond
                       ;; [(empty? a-file)...]
                       ;; [...(first a-file) ...(file (rest a-file))...]
                       ;; [... (file (first a-file)) ... (file (rest a-file))]))

;; how-many : directory -> number
(define (how-many a-dir) (cond
                               [(empty? a-dir) 0]
                               [(symbol? (first a-dir)) (+ 1 (how-many(rest a-dir)))]
                               [else ( + (how-many (first a-dir)) (how-many (rest a-dir)))]))
;;exercise 16.2.4
(define-struct dir (name content))

;;template
;;(define (direct a-dir) (... (dir-name a-dir)...
                          ;;  (dir-content a-dir)...))

;;(define (file LOFD) (cond
                   ;;   [(empty? LOFD) ...]
                   ;;   [... (first a-dir) ... (file (rest a-dir))]
                   ;;   [ ...(direct (first a-dir)) ... (file (rest a-dir))]))

;;exercise 16.2.5
;; how-many2 : directory structure -> number
(define (how-many2 a-dir) (cond
                         [(symbol? (dir-name a-dir)) (file (dir-content a-dir))]
                         [else (file (dir-content a-dir))]))

(define (file LOFD) (cond
                      [(empty? LOFD) 0]
                      [else (cond
                              [(symbol? (first LOFD)) (+ 1 (file (rest LOFD)))]
                              [else (+ (how-many2 (first LOFD)) (file (rest LOFD)))])]))

