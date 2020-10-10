# list
alias la='ls -Al'
alias ld='la | grep "^d" && la | grep -v "^d"'
alias lw='cd /var/www/html && ld && gs'

# git
alias gau='git add -u'
alias ga='git add'
alias gcm='git commit -m'
alias gss='git status -s'
alias gs='git status'

alias gps='git push'
alias gpl='git pull'

alias gch='git checkout'
alias gb='git branch'

