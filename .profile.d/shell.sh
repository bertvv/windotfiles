#! /bin/bash
#
# Bash Shell Configuration
#
# Sources:
# - http://codeinthehole.com/writing/the-most-important-command-line-tip-
#     incremental-history-searching-with-inputrc/
# - https://github.com/mrzool/bash-sensible/blob/master/sensible.bash

#echo "DBG: Shell settings" >&2

# ---------- General settings -------------------------------------------------

# Make vim the default editor
export EDITOR="vim"

shopt -s checkwinsize # update window size after each command

# Prevent file overwrite with >. Use >| to force
set -o noclobber

# Disable Ctrl-S keyboard shortcut for ScrollLock (locks up Vim)
# Source: https://unix.stackexchange.com/questions/72086/ctrl-s-hang-terminal-emulator
stty -ixon

# ---------- History ----------------------------------------------------------

# Larger bash history (allow more entries; default is 500)
export HISTSIZE=500000
export HISTFILESIZE=$HISTSIZE
export HISTCONTROL=ignoredups:ignorespace
# Make some commands not show up in history
export HISTIGNORE="&:ls:cd:cd -:pwd:exit:bg:fg"
export HISTTIMEFORMAT='%F %T '

shopt -s histappend   # append to history, don't overwrite
shopt -s histverify   # expand !!, !$, etc when typing ENTER
shopt -s cmdhist      # enter multi-line commands as one entry

# Enable history expansion with space
# E.g. typing !!<space> will replace the !! with your last command
bind Space:magic-space

# Enable incremental history search with up/down arrows (also Readline goodness)
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\e[C": forward-char'
bind '"\e[D": backward-char'

#---------- Completion --------------------------------------------------------

# Perform file completion in a case insensitive fashion
bind "set completion-ignore-case on"

# Treat hyphens and underscores as equivalent
bind "set completion-map-case on"

# Display matches for ambiguous patterns at first tab press
bind "set show-all-if-ambiguous on"

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -f "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2 | tr ' ' '\n')" scp sftp ssh

#---------- Directory navigation ----------------------------------------------

shopt -s autocd       # entering a directory as command will cd into it
shopt -s cdspell      # autocorrect typos in path names when using 'cd'
shopt -s globstar     # allow use of ** in file globbing
shopt -s nocaseglob   # case insensitive globbing

# This defines where cd looks for targets
# Add the directories you want to have fast access to, separated by colon
# Ex: CDPATH=".:~:~/projects" will look for targets in the current working directory, in home and in the ~/projects folder
# CDPATH=".:~:~/c"

# This allows you to bookmark your favorite places across the file system
# Define a variable containing a path and you will be able to cd into it regardless of the directory you're in
shopt -s cdable_vars

# Set home directory, depending on whether we're inside WSL or in Git Bash
if [ -n "$WSL_DISTRO_NAME" ]; then
    export win_home="/mnt/c/Users/${USER}"
else
    export win_home="/c/Users/${USERNAME}"
fi

export docs="${win_home}/OneDrive - Hogeschool Gent/Documenten/"
export vakken="${docs}/Vakken"
export infra="${vakken}/InfrastructureAutomation"
export lnx="${vakken}/Linux"
export linux="${vakken}/Linux"
export dpo="${vakken}/DevopsProjectOperations"
export devops="${vakken}/DevopsProjectOperations"
export dsai="${vakken}/DataScienceAI"
export ozt="${vakken}/ResearchMethods"
export bp="${vakken}/Bachelorproef"
export stage="${vakken}/Stage"
export huisstijl="${docs}/HOGENT/Huisstijl"
