#lang racket

;;; Original Ractive Example

;; This example by Daniel Prager shows how to use the Ractive
;; framework with Urlang. This version uses x-expressions
;; and the html-writing package to generate the html.
;; Compare with the version in "ractive.rkt"

(require html-writing urlang net/sendurl)

(current-urlang-run?                           #f) ; run using Node?
(current-urlang-echo?                          #f) ; print generated JavaScript?
(current-urlang-console.log-module-level-expr? #f) ; print top-level expression?

(define (ractive template js-file)
  (xexp->html
   `((html (head (title "Ractive test")
                 (script (@ (src "http://cdn.ractivejs.org/latest/ractive.min.js"))))
          (body
           (div (@ (id "container")))
           (script (@ (id "template") (type "text/ractive"))
                   ,@template)
           (script ,(file->string js-file)))))))

(urlang
 (urmodule ractive
           (import Ractive)
           (var [ractive (new Ractive
                              (object [el "#container"]
                                      [template "#template"]
                                      [data (object [name "Racket"])]))])))

;; The form (urlang ...) compiles all urmodules into JavaScript files.
(urlang
 (urmodule ractive    ; save to ractive.js
   (import Ractive)   ; declare Ractive
   (var [ractive (new Ractive                            ; call Ractive constructor
                      (object [el       "#container"]    ; el can be a node, an ID, or a CSS selector
                              [template "#template"]     ; id of the <script> tag above
                              [data     (object
                                         [country (object   [name         "The UK"]
                                                            [climate      (object     [temperature   "cold"]
                                                                                      [rainfall      "excessive"])]
                                                            [population   63230000]
                                                            [capital      (object     [name          "London"]
                                                                                      [lat           51.5171]
                                                                                      [lon           -0.1062])]
                                                            )]
                                         )]))])))

(send-url/contents
 (ractive '((h2 "Country profile")
            (p "{{country.name}} is a {{country.climate.temperature}} country with {{country.climate.rainfall}} rainfall and a population of {{country.population}}.")
            (p "The capital city is {{country.capital.name}} (<a href='https://maps.google.co.uk/maps/place/{{country.capital.name}}/@{{country.capital.lat}},{{capital.lon}},12z' target='_blank'>see map</a>)."))
          "ractive.js"))
