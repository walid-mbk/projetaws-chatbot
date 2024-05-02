


define HELP

Manage Caustaza chatbot Project Usage:
make lint           	Run linter
make format         	Run formatter
make test           	Run tests
make super-user     	Create super user
make make-migrations 	Make migrations
make migrate        	Migrate
make run-local	  		Run local environment
make stop-local	  		Stop local environment
make build-dev      	Build and run dev environment
make stop-dev       	Stop dev environment
make stop-prod      	Stop prod environment
make build-prod     	Build and run prod environment
make all            	Show help

endef

export HELP

help:
	@echo "$$HELP"

lint:
	 @docker-compose -f local.yml run --rm django black chatbot_backend

format:
	@docker-compose -f local.yml run --rm django black chatbot_backend/

test:
	@docker-compose -f local.yml run --rm django coverage run -m pytest

super-user:
	docker-compose -f local.yml run --rm django python manage.py createsuperuser

make-migrations:
	docker-compose -f local.yml run --rm django python manage.py makemigrations

migrate:
	docker-compose -f local.yml run --rm django python manage.py migrate

build-dev:
	DOCKER_BUILDKIT=1 COMPOSE_DOCKER_CLI_BUILD=1 docker-compose -f local.yml up --build -d

build-prod:
	DOCKER_BUILDKIT=1 COMPOSE_DOCKER_CLI_BUILD=1 docker-compose -f production.yml up --build -d

stop-dev:
	@docker-compose -f local.yml down

stop-prod:
	@docker-compose -f production.yml down

run-local:
	@docker-compose -f local.yml up -d

stop-local:
	@docker-compose -f local.yml down

all: help

.PHONY: help lint format test super-user make-migrations migrate build-dev build-prod stop-dev stop-prod all run-local stop-local
