alias gpl='git prunelocal'
alias gdl='git discard'

gblame() {
  git log -p -M --follow --stat -- "$1"
}

# Git Diff Against
gda() {
  gd $1...$(git_current_branch)
}

# Git Diff Against Master
gdam() {
  gda 'master'
}

# Copied this from: https://github.com/robbyrussell/oh-my-zsh/blob/3705d47bb3f3229234cba992320eadc97a221caf/lib/git.zsh
# Outputs the name of the current branch
# Usage example: git pull origin $(git_current_branch)
# Using '--quiet' with 'symbolic-ref' will not cause a fatal error (128) if
# it's not a symbolic ref, but in a Git repo.
git_current_branch() {
  local ref
  ref=$(command git symbolic-ref --quiet HEAD 2> /dev/null)
  local ret=$?
  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return  # no git repo.
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
  fi
  echo ${ref#refs/heads/}
}
alias gcam='git add . && git commit -a -m'

## Autocompleted alias
__git_complete gco _git_checkout
__git_complete gb _git_branch
__git_complete gba _git_branch
__git_complete gbd _git_branch
__git_complete gbda _git_branch
__git_complete gbl _git_branch
__git_complete gbnm _git_branch
__git_complete gbr _git_branch
__git_complete gm _git_branch
__git_complete gd _git_branch
__git_complete gda _git_branch
