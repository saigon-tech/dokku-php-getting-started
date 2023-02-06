rebuild:
	docker-compose build --no-cache
build:
	docker-compose build
up:
	docker-compose up --remove-orphans
	docker-compose ps
down:
	docker-compose down
attach:
	docker-compose exec app bash