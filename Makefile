HOSTNAME=`hostname -s`
CONTAINER=docker.venturecranial.com/nanog-profile
CONTAINER_TAG=dev-latest


.PHONY: default

default: virtualenv syncdb collectstatic
	@echo 'Build complete.'

.PHONY: virtualenv
virtualenv:
	@echo Setting up environment
	@. ./env.sh

.PHONY: syncdb
syncdb:
	. var/${HOSTNAME}/bin/activate && ./manage.py migrate

.PHONY: static
static:
	. var/${HOSTNAME}/bin/activate && echo TBD

.PHONY: collectstatic
collectstatic: static
	. var/${HOSTNAME}/bin/activate && ./manage.py collectstatic --noinput

.PHONY: coverage
coverage: syncdb
	@echo 'Running web application tests; generating coverage report'
	. var/${HOSTNAME}/bin/activate && coverage run --source='.' manage.py test web
	. var/${HOSTNAME}/bin/activate && coverage report --include='web/*'

.PHONY: debugsmtp
debugsmtp:
	python -m smtpd -n -c DebuggingServer localhost:1025

.PHONY: shell
shell:
	. var/${HOSTNAME}/bin/activate && ./manage.py shell_plus

.PHONY: devcelery
devcelery:
	. var/${HOSTNAME}/bin/activate && rabbitmq-server&
	. var/${HOSTNAME}/bin/activate && ./manage.py celery -A default worker -l info

.PHONY: container
container:
	docker ps || exit -1
	docker build -t ${CONTAINER}:${CONTAINER_TAG}
	docker push
