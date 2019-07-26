if ! $(which conda)
then
    setup anaconda3
fi

cd $GITDIR/IC
source manage.sh work_in_python_version 3.7
cd -
