django17-skeleton
=================

Base skeleton for environment for starting a Django app.




Setup Django-Require
--------------------

To enable require.js optimization via django-require:

    1. Add 'require' to INSTALLED_APPS setting.
    2. Set STATICFILES_STORAGE setting to
       - 'require.storage.OptimizedStaticFilesStorage', or
       - 'require.storage.OptimizedCachedStaticFilesStorage'.

For more info: https://github.com/etianen/django-require


Setup Django-Compressor
-----------------------

To enable Django-Compressor:

    1. Add 'compressor' to INSTALLED_APPS setting.
    2. Add 'compressor.finders.CompressorFinder' to STATICFILES_FINDERS.
    3. Define COMPRESS_ROOT if different from STATIC_ROOT.

For more info: http://django-compressor.readthedocs.org/en/latest/quickstart/


Setup Django-Bower
------------------

To enable Django-Bower:

    1. Add 'djangobower' to INSTALLED_APPS setting.
    2. Add 'djangobower.finders.BowerFinder' to STATICFILES_FINDERS.
    3. Specify path to components root (absolute path):
       BOWER_COMPONENTS_ROOT = '/PROJECT_ROOT/components.'
    4. Add bower apps to BOWER_INSTALLED_APPS.

For more info: https://django-bower.readthedocs.org/en/latest/installation.html


Setup Django-SwampDragon
------------------------

    1. Ensure redis is installed.

For more info: http://swampdragon.net/documentation/quick-start/


