if ! $(which conda)
then
    setup anaconda3
fi

export ICTDIR=$GITDIR/IC
export ICDIR=$ICTDIR/invisible_cities/
export PYTHONPATH=$ICTDIR:$PYTHONPATH
export PATH=$ICTDIR/bin:$PATH

PYTHON_VERSION=3.6
conda activate IC${PYTHON_VERSION}
