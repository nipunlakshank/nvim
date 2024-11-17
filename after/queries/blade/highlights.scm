(directive) @function
(directive_start) @function
(directive_end) @function
(comment) @comment
((parameter) @include (#set! "priority" 110)) 
((php_only) @include (#set! "priority" 110)) 
((bracket_start) @function (#set! "priority" 120)) 
((bracket_end) @function (#set! "priority" 120)) 
(keyword) @function

; ; Highlight Blade directives like @csrf, @extends, etc.
; (directive) @theme_selector
;
; ; Highlight the starting part of multiline directives like @php
; (directive_start) @theme_selector
;
; ; Highlight the ending part of multiline directives like @endphp
; (directive_end) @theme_selector
;
; ; Optional: Highlight Blade attribute directives as attributes
; (attribute (directive) @theme_selector)
;
; ; Highlight comments like {{-- comment --}}
; (comment) @theme_selector
;
; ; Optional: Highlight the start of brackets like {{
; (bracket_start) @theme_selector
;
; ; Optional: Highlight the end of brackets like }}
; (bracket_end) @theme_selector
