if ! $(which conda)
then
    setup anaconda3
fi

cd $GITDIR/IC
source manage.sh work_in_python_version_no_tests 3.8
cd -

setup jupytools
