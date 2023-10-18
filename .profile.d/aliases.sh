# ~/.profile/aliases.sh - user specific command aliases

#echo "DBG: aliases" >&2

# Directory listing and file system
# Use rational units/formats in file size & date output
alias df='df --si'
alias du='du --total --si'
alias l='ls -l --si --time-style=long-iso --color'
alias ls='ls -h --si --time-style=long-iso --color'
alias la='ls -la --si --time-style=long-iso --color'
alias ll='ls -l  --si --time-style=long-iso --color'
alias lh='ls -lh  --si --time-style=long-iso --color'
alias tree='tree -AC'
alias Z='ls -l -Z --si --color'
alias diff='diff --color --unified'

# Git
alias a='git add'
alias c='git commit -m'
alias d='git diff'
alias g='git'
alias gca='git commit --amend'
alias gp='git pull --rebase --autostash'
alias gpd='for dir in ./*/; do echo "=== ${dir} ==="; cd "${dir}"; git pull --rebase --autostash; cd ..; done'
alias gpr='git pull --rebase --autostash'
alias gr='git restore .'
# Git author stats
alias gs='git ls-tree -r -z --name-only HEAD | xargs -0 -n1 git blame --line-porcelain | grep  "^author "|sort|uniq -c|sort -nr'
alias h='git log --pretty="format:%C(yellow)%h %C(blue)%ad %C(reset)%s%C(red)%d %C(green)%an%C(reset), %C(cyan)%ar" --date=short --graph --all'
alias p='git push && git push --tags'
alias pr='git pull --rebase --autostash'
alias pt='git push -u origin --tags'
alias s='git status'

# Vagrant
alias v='vagrant'
alias vdd='vagrant destroy --force'
alias vd='vagrant destroy'
alias vdu='vagrant destroy --force && vagrant up'
alias vh='vagrant halt'
alias vp='vagrant provision'
alias vr='vagrant reload'
alias vss='vagrant ssh'
alias vs='vagrant status'
alias vu='vagrant up'

# Find stuff
alias ff='find . -type f -name '
alias fd='find . -type d -name '
