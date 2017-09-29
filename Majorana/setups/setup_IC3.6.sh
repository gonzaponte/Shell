if ! $(which conda); then
    setup anaconda3
fi

export ICTDIR=$SW/IC/
export ICDIR=$ICTDIR/invisible_cities/

export PATH=$ICTDIR/bin:$PATH
export PYTHONPATH=$ICTDIR:$PYTHONPATH

source activate IC3.6
