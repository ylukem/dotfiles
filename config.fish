alias git hub
alias grep rg
alias c code
alias gst "git status"
set GOPATH /Users/ylukem/go
set PATH $GOPATH $PATH
set PRDIR /Volumes/GoogleDrive/My\ Drive/prs
set TODODIR /Volumes/GoogleDrive/My\ Drive/todo
set NOTESDIR /Volumes/GoogleDrive/My\ Drive/notes
set PATH /Users/ylukem/stripe/henson/bin /Users/ylukem/stripe/space-commander/bin /Users/ylukem/stripe/password-vault/bin /Users/ylukem/.rbenv/bin /Users/ylukem/.rbenv/shims /Users/ylukem/stripe/henson/bin /usr/local/bin /usr/local/bin /usr/bin /bin /usr/sbin /sbin /usr/local/MacGPG2/bin /usr/local/munki "/Applications/Visual Studio Code.app/Contents/Resources/app/bin" $PATH

abbr --add g git

function todo
    vi $TODODIR/(date +'%Y-%m-%d').txt
end

function newpr
    set PRFILENAME $PRDIR/(date +'%Y-%m-%d-%X').txt
    cp $PRDIR/template.txt $PRFILENAME
    vi $PRFILENAME
    cat $PRFILENAME | pbcopy
    echo "PR body copied to clipboard"
end

function todo-yesterday
    mdless $TODODIR/(date -v '-1d' +'%Y-%m-%d').txt
end

function todo-tomorrow
  vi $TODODIR/(date -v '+1d' +'%Y-%m-%d').txt
end

function f
  fzf | read -l result; and code $result
end

alias t todo

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

function embiggen
    sed \
        -e 's/\([a-zA-Z]\)/:big-\1:/g' \
        -e 's/0/:zero:/g' \
        -e 's/1/:one:/g' \
        -e 's/2/:two:/g' \
        -e 's/3/:three:/g' \
        -e 's/4/:four:/g' \
        -e 's/5/:five:/g' \
        -e 's/6/:six:/g' \
        -e 's/7/:seven:/g' \
        -e 's/8/:eight:/g' \
        -e 's/9/:nine:/g' \
        | tr '[:upper:]' '[:lower:]'
end

function iterm2_fish_prompt --description 'Write out the prompt'
	set -l last_status $status

    if not set -q __fish_git_prompt_show_informative_status
        set -g __fish_git_prompt_show_informative_status 1
    end
    if not set -q __fish_git_prompt_hide_untrackedfiles
        set -g __fish_git_prompt_hide_untrackedfiles 1
    end

    if not set -q __fish_git_prompt_color_branch
        set -g __fish_git_prompt_color_branch magenta --bold
    end
    if not set -q __fish_git_prompt_showupstream
        set -g __fish_git_prompt_showupstream "informative"
    end
    if not set -q __fish_git_prompt_char_upstream_ahead
        set -g __fish_git_prompt_char_upstream_ahead "↑"
    end
    if not set -q __fish_git_prompt_char_upstream_behind
        set -g __fish_git_prompt_char_upstream_behind "↓"
    end
    if not set -q __fish_git_prompt_char_upstream_prefix
        set -g __fish_git_prompt_char_upstream_prefix ""
    end

    if not set -q __fish_git_prompt_char_stagedstate
        set -g __fish_git_prompt_char_stagedstate "●"
    end
    if not set -q __fish_git_prompt_char_dirtystate
        set -g __fish_git_prompt_char_dirtystate "✚"
    end
    if not set -q __fish_git_prompt_char_untrackedfiles
        set -g __fish_git_prompt_char_untrackedfiles "…"
    end
    if not set -q __fish_git_prompt_char_conflictedstate
        set -g __fish_git_prompt_char_conflictedstate "✖"
    end
    if not set -q __fish_git_prompt_char_cleanstate
        set -g __fish_git_prompt_char_cleanstate "✔"
    end

    if not set -q __fish_git_prompt_color_dirtystate
        set -g __fish_git_prompt_color_dirtystate blue
    end
    if not set -q __fish_git_prompt_color_stagedstate
        set -g __fish_git_prompt_color_stagedstate yellow
    end
    if not set -q __fish_git_prompt_color_invalidstate
        set -g __fish_git_prompt_color_invalidstate red
    end
    if not set -q __fish_git_prompt_color_untrackedfiles
        set -g __fish_git_prompt_color_untrackedfiles $fish_color_normal
    end
    if not set -q __fish_git_prompt_color_cleanstate
        set -g __fish_git_prompt_color_cleanstate green --bold
    end

    if not set -q __fish_prompt_normal
        set -g __fish_prompt_normal (set_color normal)
    end

    set -l color_cwd
    set -l prefix
    set -l suffix
    switch "$USER"
        case root toor
            if set -q fish_color_cwd_root
                set color_cwd $fish_color_cwd_root
            else
                set color_cwd $fish_color_cwd
            end
            set suffix '#'
        case '*'
            set color_cwd $fish_color_cwd
            set suffix '>'
    end

    # PWD
    set_color $color_cwd
    echo -n (prompt_pwd)
    set_color normal

    if contains (basename $PWD) "pay-server"
        printf ' (%s) ' (git branch-name)
    else
        printf '%s ' (__fish_git_prompt)
    end

    if not test $last_status -eq 0
        set_color $fish_color_error
    end

    echo -n "$suffix "

    set_color normal
end