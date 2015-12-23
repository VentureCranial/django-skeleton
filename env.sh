HOSTNAME=`hostname -s`
ROOTDIR="var/$HOSTNAME"

export ROOTDIR

mkdir -p $ROOTDIR/bin $ROOTDIR/log $ROOTDIR/tmp $ROOTDIR/etc $ROOTDIR/www $ROOTDIR/db $ROOTDIR/log/emails $ROOTDIR/log/celery

# For MacOS X 10.9, when buidling Pillow, the cc uses an invalid
# command line option; this forces XCode to ignore it (at least for now).
#
OS=`uname`
if [ 'x$OS' == 'xDarwin' ]; then
    export ARCHFLAGS=-Wno-error=unused-command-line-argument-hard-error-in-future
fi

# Install bower if it's not in the path
BOWER_BIN=`which bower`
if [ ! -x $BOWER_BIN ]; then
    npm install -g bower
fi

if [ -e $ROOTDIR/bin/activate ]; then
    echo Activating Python virtualenv
    . $ROOTDIR/bin/activate
else
    echo Building out Python virtualenv
    virtualenv $ROOTDIR
    echo Activating Python virtualenv
    . $ROOTDIR/bin/activate
    easy_install readline
fi

pip install -q -r requirements.txt

if [ -e manage.py ]; then
    CHECK=`./manage.py | grep bower_install`
    if [ "x$CHECK" == "x" ]; then
        echo -n
    else
        ./manage.py bower_install 2>&1 > /dev/null
    fi
fi


# CHECK=`grep django.utils.datastructures $VIRTUAL_ENV/lib/python2.7/site-packages/passlib/ext/django/utils.py`
# if [ "x$CHECK" == "x" ]; then
#     echo Applying patch to passlib to fix django SortedDict problem
#    patch -p0 $VIRTUAL_ENV/lib/python2.7/site-packages/passlib/ext/django/utils.py patches/fix-sorted-dict-passlib.patch
# fi
