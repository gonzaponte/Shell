alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias ls=" ls -h"
alias ls1="ls -1"
alias lsa="ls -a"
alias lsl="ls -l"
alias lsla="ls -la"
alias l="lsla"
alias count="ls -1|wc -l"
alias root="root -l"
alias untar="tar -xzvf"
#alias dropbox="cd ~/Dropbox/"
alias master="cd ~/Dropbox/Gonzalo/USC/Máster/"
alias next="ssh -Y lema@neutrinos1.ific.uv.es"
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
alias julia="exec /Applications/Julia-0.2.1.app/Contents/Resources/julia/bin/julia"
alias cdfou="cd $GITDIR/reconstruction/FourierReco/Development/"
#alias g4make="cmake -DGeant4_DIR=/Applications/Geant4/install/lib/Geant4-10.1.0"
alias g4make="cmake -DGeant4_DIR=/Applications/Geant4/lib/Geant4-10.2.0"

alias nucd="cd $GITDIR/Geant4/nuCD/source/"

alias disable_spotlight="sudo mdutil -a -i off"
alias enable_spotlight="sudo mdutil -a -i on"

function setup(){
source $GITDIR/Bash/configuration_scripts_macbook/$1.sh
echo Enjoy $1
}
