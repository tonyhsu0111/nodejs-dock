#CreateName="2022/08/03"
#MAINTAINER="Tony Hsu"
SOURCE_PATH=$(PWD)
help:
	@echo ""
	@echo "-- Help Menu"
	@echo ""
	@echo "   1. make build        - build container"
	@echo "   2. make run          - start container"
	@echo "   3. make rm           - rm container"
	@echo "   4. make logs         - view logs"
	@echo "   5. make clean        - remove image and unused docker data"
	@echo "   6. make restart      - restart ALL container"

.PHONY:build
build:
	@echo "Build Docker"
	@docker-compose -f docker-compose.yml build --force-rm


logs:
	@docker-compose logs --tail 25 -f 

rm:
	@echo "remove Docker"
	@docker-compose -f docker-compose.yml --compatibility down 

run:
	@echo "RUN Docker"
	@docker-compose -f docker-compose.yml --compatibility  down
	@docker-compose -f docker-compose.yml --compatibility  up -d

clean:
	@echo "Remove image Docker"
	@docker-compose -f docker-compose.yml  down --rmi all
	@docker system prune -f

exec:
	@echo "Exec image Docker"
	@docker-compose -f docker-compose.yml exec nodejs-server01 bash

restart:
	@echo "RESTART Docker"
	@docker-compose restart