;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname practice#14) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
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
(define-struct di (name content))

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
                         [(symbol? (di-name a-dir)) (file (di-content a-dir))]
                         [else (file (di-content a-dir))]))

(define (file LOFD) (cond
                      [(empty? LOFD) 0]
                      [else (cond
                              [(symbol? (first LOFD)) (+ 1 (file (rest LOFD)))]
                              [else (+ (how-many2 (first LOFD)) (file (rest LOFD)))])]))

;; exercise 16.3.1
;;template
;;(define (file-stru a-file) (... (file-name a-file)...
                             ;;   (file-size a-file)...
                             ;;  (list-file (file-content a-file))...))
  
;;(define (list-file a-file) (cond
                            ;; [(empty? a-file)...]
                            ;; [...(file-struc (first a-file))... (list-file (rest a-file))...]))

;;(define (direc-stru a-dir) (... (dir-name a-dir)...
                              ;;  (dir-dirs a-dir)...
                              ;;  (dir-files a-dir)...))
  
;;(define (list-dir a-dir) (cond
                          ;; [(empty? a-dir) ...]
                          ;; [...(direc-struc (first a-dir))... (list-dir (rest a-dir))...]))


;;create-dir : string -> dir
  (define (create-file string) (cons (make-file (file-name empty)
                                                (file-size empty)
                                               (list-of-file (file-content empty)))))

  (define (create-dir2 string) (cons (make-dir (dir-name string)
                                              (list-of-dir (dir-dirs empty))
                                              (create-file (dir-files empty)))))

  (define (list-of-file string) (cond
                                  [(empty? string) empty]))

  (define (list-of-dir string) (cond
                                [(empty? string) empty]
                                [else (append (create-dir2 (first string)))]))

;;exercise 16.3.2
;;how-many? : dir -> number
;; produces a number of files in the dir tree
 (define (how-many? a-dir) (+ (dir-dirs a-dir)
                              (sum-file (dir-files a-dir))))

(define (sum-file a-dir) (cond
                           [(symbol? (file-name a-dir)) (+ 1 (file-list (file-content a-dir)))]
                           [else (how-many? a-dir)]))

(define (file-list a-dir) (cond
                            [(empty? a-dir) 0]
                            [else (cond
                                    [(sum-file (first a-dir)) (+ 1 (file-list (rest a-dir)))]
                                    [else (file-list (rest a-dir))])]))

(define (sum-direc a-dir) (cond
                            [(empty? a-dir) 0]
                            [(symbol? (first a-dir)) (+ 1 (sum-direc (rest a-dir)))]
                            [else (sum-direc (rest a-dir))]))

;;exercise 16.3.3
;; du-dir : directory tree -> number
(define (du-dir a-dir) ( + (dir-dirs a-dir)
                           (total-file (dir-files a-dir))))

(define (total-file a-dir) (+ (file-size a-dir) (into-file (file-content a-dir))))
  
(define (into-file a-dir) (cond
                            [(empty? a-dir) 0 ]
                            [else (cond
                                    [(number? (first a-dir))(+ (first a-dir) (into-file (rest a-dir)))]
                                    [else (into-file (rest a-dir))])]))


                                        

  