;; extends

; Conceal the backslash in escape sequences
((backslash_escape)
  @string.escape.backslash
  (#offset! @string.escape.backslash 0 0 0 -1)
  (#set! conceal ""))
