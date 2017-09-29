# Moving around folders
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

# Listing and counting
alias ls=" ls -h --color=auto"
alias l="ls -la"


# Shortcuts
alias emnw="emacs -nw"
alias untar="tar -xzvf"
alias mergepdf="gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=merged.pdf"
alias rmlatex="rm *.tex~;rm *.aux;rm *.synctex.gz;rm *.log;rm *.toc; rm *.nav; rm *.snm; rm *.out;rm *.lof"
alias rmpy="rm *.pyc;rm *.py~"
alias rmtemp="rm *~"

# Connections
alias next="ssh -Y lema@neutrinos1.ific.uv.es"

# Set-ups
function setup(){
source $CONF/setups/setup_$1.sh
echo $1 is set up 
}
