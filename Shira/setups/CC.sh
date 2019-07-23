if ! $(which conda)
then
    setup anaconda3
fi

export CCDIR=$GITDIR/CC

conda activate CC
source $CCDIR/setup.sh
