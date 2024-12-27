# Highlight colors
set -g fish_color_normal normal
set -g fish_color_command brgreen
set -g fish_color_quote green
set -g fish_color_redirection bryellow
set -g fish_color_end magenta
set -g fish_color_error red
set -g fish_color_param normal
set -g fish_color_comment brwhite --italics
set -g fish_color_match normal
set -g fish_color_selection white --bold --background=brblack
set -g fish_color_search_match yellow --background=brblack
set -g fish_color_operator blue
set -g fish_color_escape yellow
set -g fish_color_autosuggestion brblack
set -g fish_color_valid_path --underline
set -g fish_color_cancel brwhite

# Prompt
set -g fish_color_cwd cyan
set -g fish_color_cwd_root yellow
set -g fish_color_status red

# Completion pager
set -g fish_pager_color_progress brcyan
set -g fish_pager_color_background blue
set -g fish_pager_color_prefix white --bold --underline
set -g fish_pager_color_completion normal
set -g fish_pager_color_description yellow

# dirh
set -g fish_color_history_current --bold

# fzf
set -gx FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS --color fg:7,bg:-1,hl:6,fg+:7,bg+:8,hl+:6"
set -gx FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS --color info:14,border:14,prompt:5,spinner:5,pointer:3,marker:3,header:15"

# jq
set -gx JQ_COLORS '3;94:3;93:3;93:0;33:0;32:0;34:0;34:0;36'
