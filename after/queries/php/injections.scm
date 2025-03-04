;; extends

;; SQL for Laravel raw methods
((member_call_expression
   name: (_) @_raw_func_identifier
   arguments: (arguments
                .
                (argument
                  (_
                    (string_content) @injection.content))))
 (#set! injection.language "sql")
 (#any-of? @_raw_func_identifier 
  "raw" "whereRaw" "selectRaw" "orWhereRaw" "havingRaw" "orHavingRaw" "orderByRaw"))
