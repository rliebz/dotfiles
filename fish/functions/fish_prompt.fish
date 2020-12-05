function fish_prompt --description 'Write out the prompt'
    set -l last_pipestatus $pipestatus
    set -l normal (set_color normal)

    # Color the prompt differently when we're root
    set -l color_cwd cyan
    set -l suffix ' |▶'
    if contains -- $USER root toor
        set color_cwd yellow
        set suffix ' !▶'
    end

    # Make VCS display more fun
    set -g __fish_git_prompt_showcolorhints
    set -g __fish_git_prompt_showdirtystate
    set -g __fish_git_prompt_showuntrackedfiles

    # Write pipestatus
    set -l prompt_status (__fish_print_pipestatus " [" "]" "|" (set_color $fish_color_status) (set_color --bold $fish_color_status) $last_pipestatus)

    echo -n -s (set_color $color_cwd) (prompt_pwd) $normal (fish_vcs_prompt) $normal $prompt_status (set_color --bold magenta) $suffix " " $normal
end

