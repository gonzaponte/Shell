if ! $(which conda)
then
    setup anaconda3
fi

conda deactivate
conda activate webplay

export PYTHONPATH=$PYTHONPATH:$GITDIR/webbot/
