# --- zinit (self-bootstraps on first shell open) ---
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [[ ! -d "$ZINIT_HOME" ]]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# --- vi mode (must be before other plugins) ---
ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
ZVM_INIT_MODE=sourcing

zinit light jeffreytse/zsh-vi-mode

# --- plugins ---
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting

# --- completions ---
autoload -Uz compinit && compinit
zinit cdreplay -q

# --- history ---
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory sharehistory hist_ignore_dups hist_ignore_all_dups hist_ignore_space hist_save_no_dups

# --- keybindings (via zvm hook so vi-mode doesn't clobber them) ---
zvm_after_init() {
    autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
    zle -N up-line-or-beginning-search
    zle -N down-line-or-beginning-search
    bindkey '^l' autosuggest-accept
    bindkey '^p' up-line-or-beginning-search
    bindkey '^n' down-line-or-beginning-search
    bindkey -M vicmd '^p' up-line-or-beginning-search
    bindkey -M vicmd '^n' down-line-or-beginning-search
}

# --- zoxide (z replacement) ---
eval "$(zoxide init zsh)"

# --- starship prompt ---
eval "$(starship init zsh)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# Source profile.d scripts directly instead of running `conda shell.zsh hook`,
# which spawns python and imports ~600 modules (~300ms). Sourcing is ~6ms
# and provides the same `conda`/`conda activate` shell functions.
. "/home/tobias/miniforge3/etc/profile.d/conda.sh"
if [ -f "/home/tobias/miniforge3/etc/profile.d/mamba.sh" ]; then
    . "/home/tobias/miniforge3/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<

# Aliases
alias lg='lazygit'
alias c='clear'
alias ranger=". ranger"
alias xo="xdg-open"

# bitwarden password copy
bwcp () {
    local copy_cmd
    copy_cmd=''
    if command -v wl-copy &> /dev/null
    then
        copy_cmd='wl-copy'
    elif command -v xclip &> /dev/null
    then
        copy_cmd='xclip -se c 1> /dev/null 2> /dev/null'
    fi

    if [ $copy_cmd ]
    then
        bw get password $1 | eval $copy_cmd
    else
        echo 'No supported copy command found!'
    fi
}

bwcpfh () {
    bwcp portal.fhstp
}

export EDITOR=nvim
export PATH="$HOME/.local/bin:$PATH"

# >>> mamba initialize >>>
export MAMBA_EXE='/home/tobias/miniforge3/bin/mamba'
export MAMBA_ROOT_PREFIX='/home/tobias/miniforge3'

__mamba_exe() (
    "$MAMBA_EXE" "${@}"
)

__mamba_hashr() {
    if [ -n "${ZSH_VERSION:+x}" ]; then
        \rehash
    else
        \hash -r
    fi
}

__mamba_xctivate() {
    local ask_mamba
    ask_mamba="$(PS1="${PS1:-}" __mamba_exe shell "${@}" --shell bash)" || return
    eval "${ask_mamba}"
    __mamba_hashr
}

mamba() {
    local cmd="${1-__missing__}"
    case "${cmd}" in
        activate|reactivate|deactivate)
            __mamba_xctivate "${@}"
            ;;
        install|update|upgrade|remove|uninstall)
            __mamba_exe "${@}" || return
            __mamba_xctivate reactivate
            ;;
        *)
            __mamba_exe "${@}"
            ;;
    esac
}

if [ -z "${CONDA_SHLVL+x}" ]; then
    export CONDA_SHLVL=0
    export PATH="${MAMBA_ROOT_PREFIX}/condabin:${PATH}"
    [ -z "${PS1+x}" ] && PS1=
fi
mamba activate base
# <<< mamba initialize <

zvm_after_init
