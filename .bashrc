#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '


export PATH="${PATH}:/opt/anaconda/bin"

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi

archey3

# added by Anaconda3 4.3.1 installer
export PATH="/home/mj/anaconda3/bin:$PATH"
