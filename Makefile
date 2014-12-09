
.PHONY: default

default: virtualenv syncdb collectstatic
	@echo 'Build complete.'

.PHONY: virtualenv
virtualenv:
	@echo Setting up environment
	@. ./env.sh

.PHONY: syncdb
syncdb:
	. var/bin/activate && ./manage.py migrate

.PHONY: static
static:
	. var/bin/activate && echo TBD

.PHONY: collectstatic
collectstatic: static
	. var/bin/activate && ./manage.py collectstatic --noinput

.PHONY: coverage
coverage: syncdb
	@echo 'Running web application tests; generating coverage report'
	. var/bin/activate && coverage run --source='.' manage.py test web
	. var/bin/activate && coverage report --include='web/*'

.PHONY: debugsmtp
debugsmtp:
	python -m smtpd -n -c DebuggingServer localhost:1025

.PHONY: shell
shell:
	. var/bin/activate && ./manage.py shell_plus
