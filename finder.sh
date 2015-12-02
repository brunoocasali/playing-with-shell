cd $(find /home/ -name DIR-NAME 2>/dev/null)

# Just place this in your .bashrc

finderx() {
  cd $(find /home/ -name $1 2>/dev/null)
}
alias cec=finderx

# and use:

cec dirname
