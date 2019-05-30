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

alias emacs="emacs -nw -q"

alias root="root -l"
alias untar="tar -xzvf"
alias dropbox="cd ~/Dropbox/"

alias master="cd ~/Dropbox/Gonzalo/USC/Máster/"
alias next="ssh -Y lema@neutrinos1.ific.uv.es"

##alias icuser="ssh -Y -v -o PreferredAuthentications=password -o PubkeyAuthentication=no icuser@193.146.122.114 -p 6027"
##alias icuser2="ssh -Y -v -o PreferredAuthentications=password -o PubkeyAuthentication=no icuser@193.146.122.114 -p 6028"
##alias shifter="ssh -Y -v -o PreferredAuthentications=password -o PubkeyAuthentication=no shifter@193.146.122.114 -p 6027"
##alias shifter2="ssh -Y -v -o PreferredAuthentications=password -o PubkeyAuthentication=no shifter@193.146.122.114 -p 6028"
alias shifter="ssh -Y -v -o PreferredAuthentications=password -o PubkeyAuthentication=no shifter@195.77.159.50 -p 6030"
alias shifter2="ssh -Y -v -o PreferredAuthentications=password -o PubkeyAuthentication=no shifter@195.77.159.50 -p 6031"
alias icuser="ssh -Y -v -o PreferredAuthentications=password -o PubkeyAuthentication=no icuser@195.77.159.50 -p 6030"
alias icuser2="ssh -Y -v -o PreferredAuthentications=password -o PubkeyAuthentication=no icuser@195.77.159.50 -p 6031"

alias gridcsic="ssh -Y braispal@ui00.ific.uv.es" #Bpp.3/7/92
alias griddipc="ssh -t jjgomez@ac-01.sw.ehu.es ssh atlas.sw.ehu.es"

alias pythoni="python -i"
alias rmlatex="rm *.tex~;rm *.aux;rm *.synctex.gz;rm *.log;rm *.toc; rm *.nav; rm *.snm; rm *.out;rm *.lof"
alias rmpy="rm *.pyc;rm *.py~"
alias cdnext="cd $NEXTDIR"
alias openpy="open *.py"
alias opencpp="open *.c* *.h"
alias opencc="open *.cc *.hh"
alias openpdf="open *.pdf"
alias mergepdf="gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=merged.pdf"
alias foldersize="du -hsc"
alias cdgit="cd $GITDIR"
alias rmvlc="defaults delete org.videolan.vlc.LSSharedFileList RecentDocuments"
alias py="python"
alias pyi="pythoni"
alias julia="exec /Applications/Julia-0.4.2.app/Contents/Resources/julia/bin/julia"
alias cdfou="cd $GITDIR/reconstruction/FourierReco/Development/"
#alias g4make="cmake -DGeant4_DIR=/Applications/Geant4/install/lib/Geant4-10.1.0"
alias g4make="cmake -DGeant4_DIR=/Applications/Geant4/lib/Geant4-10.2.0"

alias nucd="cd $GITDIR/Geant4/nuCD/source/"

alias 9gag="$GITDIR/ShittyScripts/9gag.py"


alias disable_spotlight="sudo mdutil -a -i off"
alias enable_spotlight="sudo mdutil -a -i on"

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