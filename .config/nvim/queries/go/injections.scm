;; extends
(short_var_declaration
  right: (expression_list
    (raw_string_literal) @injection.content
    (#set! injection.language "json")
  )
)

(call_expression
  arguments: (argument_list
    (raw_string_literal) @injection.content
    (#set! injection.language "json")
  )
)

; repository sql definitions
(const_declaration
  (const_spec
    name: (identifier) @name
    value: (expression_list
      (raw_string_literal) @injection.content
      (#match? @name ".*Stmt$")
      (#set! injection.language "sql")
    )
  )
)
