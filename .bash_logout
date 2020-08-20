# ~/.bash_logout: executed by bash(1) when login shell exits.

# when leaving the console clear the screen to increase privacy
if [ "$SHLVL" = 1 ]; then
    [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
fi

rm -f ~/.gnupg/S.gpg-agent

if [[ -n $SSH_CLIENT && -n $SSH_AGENT_PID ]]; then
    kill $SSH_AGENT_PID
fi
