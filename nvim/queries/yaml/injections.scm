;; extends

; Tusk scripts, modified from: nvim-treesitter/queries/yaml/injections.scm
(block_mapping_pair
  key: (flow_node) @_tusk_command
  (#any-of? @_tusk_command "run" "command")
  value: (flow_node
    (plain_scalar
      (string_scalar) @injection.content)
    (#set! injection.language "bash")))

(block_mapping_pair
  key: (flow_node) @_tusk_command
  (#any-of? @_tusk_command "run" "command")
  value: (block_node
    (block_scalar) @injection.content
    (#set! injection.language "bash")
    (#offset! @injection.content 0 1 0 0)))

(block_mapping_pair
  key: (flow_node) @_tusk_command
  (#any-of? @_tusk_command "run" "command")
  value: (block_node
    (block_sequence
      (block_sequence_item
        (flow_node
          (plain_scalar
            (string_scalar) @injection.content))
        (#set! injection.language "bash")))))

(block_mapping_pair
  key: (flow_node) @_tusk_command
  (#any-of? @_tusk_command "run" "command")
  value: (block_node
    (block_sequence
      (block_sequence_item
        (block_node
          (block_scalar) @injection.content
          (#set! injection.language "bash")
          (#offset! @injection.content 0 1 0 0))))))
