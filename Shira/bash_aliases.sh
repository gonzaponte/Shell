alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

alias clr="yes \"\" | head -n50;clear"

alias ls=" ls -h"
alias ls1="ls -1"
alias lsa="ls -a"
alias lsl="ls -l"
alias lsla="ls -la"
alias l="lsla"

alias count="ls -1|wc -l"

alias root="root -l"
alias untar="tar -xzvf"

alias next="ssh -Y lema@neutrinos1.ific.uv.es"

alias shifter="ssh -Y -v -o PreferredAuthentications=password -o PubkeyAuthentication=no shifter@195.77.159.50 -p 6030"
alias shifter2="ssh -Y -v -o PreferredAuthentications=password -o PubkeyAuthentication=no shifter@195.77.159.50 -p 6031"
alias icuser="ssh -Y -v -o PreferredAuthentications=password -o PubkeyAuthentication=no icuser@195.77.159.50 -p 6030"
alias icuser2="ssh -Y -v -o PreferredAuthentications=password -o PubkeyAuthentication=no icuser@195.77.159.50 -p 6031"

alias gridcsic="ssh -Y braispal@ui00.ific.uv.es" #Bpp.3/7/92
alias griddipc="ssh -t jjgomez@ac-01.sw.ehu.es ssh atlas.sw.ehu.es"

alias pythoni="python -i"
alias rmlatex="rm *.tex~;rm *.aux;rm *.synctex.gz;rm *.log;rm *.toc; rm *.nav; rm *.snm; rm *.out;rm *.lof"
alias rmpy="rm *.pyc;rm *.py~"

alias mergepdf="gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=merged.pdf"

alias foldersize="du -hsc"

alias cdgit="cd $GITDIR"

alias py="python"
alias pyi="pythoni"

alias scroll="tput rmcup"

function setup(){
source ~/.configuration_scripts/$1.sh
echo Enjoy $1
}

function lsccp(){
echo scp -P 6030 icuser@195.77.159.50:$1 $2
scp -P 6030 icuser@195.77.159.50:$1 $2
}

function nextcp(){
echo scp lema@neutrinos1.ific.uv.es:$1 $2
scp lema@neutrinos1.ific.uv.es:$1 $2
}

function lemacp(){
nextcp /data4/NEXT/users/gmartinez/topo/$1 $2
}

alias realpath="python -c 'import os, sys; print(os.path.abspath(os.path.dirname(sys.argv[1])))'"


alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

alias svpn='snx -s svpn.weizmann.ac.il -u '

alias mvss="mv $HOME/Imaxes/Captura* $HOME/Imaxes/Screenshots/"
