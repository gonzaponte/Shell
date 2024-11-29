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
alias majorana="ssh -Y lema@majorana1.ific.uv.es"

alias shifter="ssh -Y -v -o PreferredAuthentications=password -o PubkeyAuthentication=no shifter@195.77.159.50 -p 6030"
alias shifter2="ssh -Y -v -o PreferredAuthentications=password -o PubkeyAuthentication=no shifter@195.77.159.50 -p 6031"
alias icuser="ssh -Y -v -o PreferredAuthentications=password -o PubkeyAuthentication=no icuser@195.77.159.50 -p 6030"
alias icuser2="ssh -Y -v -o PreferredAuthentications=password -o PubkeyAuthentication=no icuser@195.77.159.50 -p 6031"

alias gridcsic="ssh -Y braispal@ui00.ific.uv.es" #Bpp.3/7/92
#alias griddipc="ssh -t jjgomez@ac-01.sw.ehu.es ssh atlas.sw.ehu.es"
alias dipc="ssh -Y jjgomez@atlas-fdr.sw.ehu.es"

alias pythoni="python -i"
alias rmlatex="rm *.tex~;rm *.aux;rm *.synctex.gz;rm *.log;rm *.toc; rm *.nav; rm *.snm; rm *.out;rm *.lof"
alias rmpy="rm *.pyc;rm *.py~"

alias mergepdf="gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=merged.pdf"

alias foldersize="du -hsc"

alias cdgit="cd $GITDIR"

alias py="python"
alias pyi="pythoni"

alias scroll="tput rmcup"

function mkcd(){
    mkdir $@
    cd $1
}

function setup(){
source ~/.configuration_scripts/$1.sh
echo Enjoy $1
}

function lsccp(){
echo scp -P 6030 icuser@195.77.159.50:$1 $2
scp -P 6030 icuser@195.77.159.50:$1 $2
}

function nextcp(){
from=$1
to=$2
shift
shift
echo scp $@ lema@neutrinos1.ific.uv.es:${from} ${to}
scp $@ lema@neutrinos1.ific.uv.es:${from} ${to}
}

function lemacp(){
from=$1
to=$2
shift
shift
nextcp /data4/NEXT/users/gmartinez/topo/${from} ${to} $@
}

alias realpath="python -c 'import os, sys; print(os.path.abspath(os.path.dirname(sys.argv[1])))'"


alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias pbpasteimg='xclip -selection clipboard -y image/png -o'

alias svpn='snx -s svpn.weizmann.ac.il -u '

alias mvss="mv $HOME/Imaxes/Captura* $HOME/Imaxes/Screenshots/"


function startcbd(){
    if [[ -z $(ps -e | grep clipboard_dump) ]]; then
        $GITDIR/Shell/clipboard_dumper.sh >& /dev/null &
    fi
#    pid=$!
#    trap "kill ${pid}" EXIT
}


function setup_anaconda3(){
. $SWDIR/anaconda3/etc/profile.d/conda.sh
}


function setup_ic_prod(){
setup_anaconda3

conda deactivate

conda activate IC-3.7-2020-06-16
export ICTDIR=$GITDIR/IC
export ICDIR=$ICTDIR/invisible_cities/
export PYTHONPATH=$ICTDIR
export PATH=$ICTDIR/bin:$PATH

export HDF5_USE_FILE_LOCKING=FALSE
}

function echoo(){
  var=$1
  echo $var ${!var}
}

function replace_whitespaces(){
    arg=$1
    shift
    mv "$arg" "${arg// /_}"
    if [[ $# -ne 0 ]]; then
        replace_whitespaces "$@"
    fi
}

function m4a_to_mp3(){
    filein=${1}
    fileout=${2}/${filein//m4a/mp3}
    ffmpeg -i ${filein} -c:v copy -c:a libmp3lame -q:a 4 ${fileout}
}

function webp_to_png(){
    dwebp {} -o $1.png ::: $1
}

function clean_root(){
    echo "These are the packages installed with snap:"
    echo ""
    snap list --all
    echo ""
    echo "Now removing the following packages:"
    snap list --all | grep "desactivado"
    while true; do
        read -p "OK?(y/N)" yn
        case $yn in
            [nN]* ) return;;
            [yY]* ) break;;
            * ) echo "Invalid answer";;
        esac
    done
    sudo echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    snap list --all | while read snapname v rev notes; do
        if [[ $notes = *desactivado* ]]; then
            echo "Removing $snapname $rev"
            sudo snap remove "$snapname" --revision="$rev"
        fi
    done


}

alias em="emacs &"
alias emnw="emacs -nw"
