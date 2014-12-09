mkdir -p var/bin var/log var/tmp var/etc var/www

# For MacOS X 10.9, when buidling Pillow, the cc uses an invalid
# command line option; this forces XCode to ignore it (at least for now).
#
OS=`uname`
if [ 'x$OS' == 'xDarwin' ]; then
    export ARCHFLAGS=-Wno-error=unused-command-line-argument-hard-error-in-future
fi

if [ -e var/bin/activate ]; then
    echo Activating Python virtualenv
    . var/bin/activate
    pip install -q -r requirements.txt

else
    echo Building out Python virtualenv
    virtualenv var
    echo Activating Python virtualenv
    . var/bin/activate
    easy_install readline
    pip install -r requirements.txt
fi
