((text) @injection.content
    (#set! injection.combined)
    (#set! injection.language php))

; ((text) @injection.content
;     (#has-ancestor? @injection.content "envoy")
;     (#set! injection.combined)
;     (#set! injection.language bash))

((comment) @injection.content
    (#set! injection.language "comment"))

((php_only) @injection.content
    (#set! injection.combined)
    (#set! injection.language php_only))

((parameter) @injection.content
    (#set! injection.include-clildren)
    (#set! injection.language php_only))
