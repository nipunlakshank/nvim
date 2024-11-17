((text) @injection.content
    (#not-has-ancestor? @injection.content "envoy")
    (#set! injection.combined)
    (#set! injection.combined "php,bash") ; Define as combined PHP/Bash if needed
    (#set! injection.language "php") ; Primary language is PHP
)

((php_only) @injection.content
    (#set! injection.language "php_only")
)

((parameter) @injection.content
    (#set! injection.language "php_only") ; Corrected "php_only" to "php" for compatibility
)
