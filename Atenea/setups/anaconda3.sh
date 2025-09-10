export ANACONDADIR=$SWDIR/anaconda3/

eval "$(/home/gonzalo/sw/anaconda3/bin/conda shell.zsh hook)"

# #. $ANACONDADIR/etc/profile.d/conda.sh

# # >>> conda initialize >>>
# # !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('$ANACONDADIR/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "$ANACONDADIR/etc/profile.d/conda.sh" ]; then
#         . "$ANACONDADIR/etc/profile.d/conda.sh"
#     else
#         export PATH="$ANACONDADIR/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# # <<< conda initialize <<<
