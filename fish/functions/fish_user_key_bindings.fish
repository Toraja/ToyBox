function fish_user_key_bindings
    bind \cx\cr reload_keybind

    # motion
    bind \e\cf forward-bigword
    bind \e\cb backward-bigword
    bind \x1D forward-jump
    # Ctrl-Alt-] does not work, and \x1D does not work fow ALT key
    bind \e] backward-jump
    bind \e\; repeat-jump
    bind \e, repeat-jump-reverse

    # edit
    bind \eh backward-kill-word
    bind \e\cw backward-kill-bigword
    bind \e\cd kill-bigword
    bind \e\cu kill-whole-line
    bind \el downcase-word

    # search
    bind \ep history-token-search-backward
    bind \en history-token-search-forward

    # misc
    bind \cg suppress-autosuggestion
    bind \e\? __fish_man_page
    bind \e\ci complete-and-search
    bind \cx\cp __fish_paginate
    bind \cx\cl __fish_list_current_token
    bind \cx\ca "commandline -a \" | xargs \"; commandline -f end-of-line"

    # wrapper
    # clipbin is exported to use inside tmux.conf
    if type -q clip.exe
        set -gx clipbin 'clip.exe'
    else if type -q xsel
        set -gx clipbin xsel -i --clipboard
    else if type -q xclip
        set -gx clipbin xclip -selection c
    end
    if set -q TMUX
        set -g clipper 'clip_to_tmux'
        # Below does not work (`and` command not found), so keep using the function above
        # set -g clipper tmux load-buffer -\; and tmux save-buffer - \| $clipbin
    else if set -q clipbin
        set -g clipper $clipbin
    end

    if set -q clipper
        bind \cq 'commandline -a \' | $clipper\''
        bind \eq 'wrap_in_echo_single \'$clipper\''
        bind \e\cq 'wrap_in_echo_double \'$clipper\''
    end

    function bind_wrapper
        argparse --name=wrap_job --min-args=3 --max-args=3 'h/help' -- $argv
        set key $argv[1] # should not escape or backslash will be duplicated
        set start (string escape --no-quoted $argv[2])
        set end (string escape --no-quoted $argv[3])

        bind \e$key't' "wrap_token $start $end"
        bind \e$key'p' "wrap_process $start $end"
        bind \e$key'j' "wrap_job $start $end"
        bind \e$key'a' "wrap_to_beginning $start $end"
        bind \e$key'e' "wrap_to_end $start $end"
    end

    bind_wrapper \( \( \)
    bind_wrapper \) \( \)
    bind_wrapper \{ \{ \}
    bind_wrapper \} \{ \}
    bind_wrapper \" \" \"
    bind_wrapper \' \' \'

    # selection
    bind -m selection \cx\x20 begin-selection
    bind -M selection \cx\cx swap-selection-start-stop repaint
    bind -M selection -m default \cx\x20 end-selection repaint
    bind -M selection -m default \e end-selection repaint
    bind -M selection -m default \cw kill-selection end-selection repaint
    bind -M selection -m default \ek kill-selection end-selection repaint
    bind -M selection \cp up-line
    bind -M selection \cn down-line
    bind -M selection \cf forward-char
    bind -M selection \cb backward-char
    bind -M selection \ef forward-word
    bind -M selection \eb backward-word
    bind -M selection \e\cf forward-bigword
    bind -M selection \e\cb backward-bigword
    bind -M selection \ca beginning-of-line
    bind -M selection \ce end-of-line
    bind -M selection \x1D forward-jump
    # Ctrl-Alt-] does not work, and \x1D does not work fow ALT key
    bind -M selection \e] backward-jump
    bind -M selection \e\; repeat-jump
    bind -M selection \e, repeat-jump-reverse
end
