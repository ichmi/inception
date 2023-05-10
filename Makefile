DOMAIN       := frosa-ma.42.fr
USERBIND     := /home/frosa-ma
DATABIND     := ${USERBIND}/data
WP_DATA_DIR  := ${DATABIND}/wordpress
MDB_DATA_DIR := ${DATABIND}/mariadb

HOSTNAME     := $(shell hostname)
ENVIRONMENT  := $(shell [ "${HOSTNAME}" = "WSL-EVAL" ] && echo 1 || echo 0 )

COMPOSE      := srcs/docker-compose.yml

all: up

up: | ${WP_DATA_DIR} ${MDB_DATA_DIR}
	@cat /etc/hosts | grep ${DOMAIN} > /dev/null || echo "127.0.0.1 ${DOMAIN}" | sudo tee -a /etc/hosts > /dev/null
ifeq ($(ENVIRONMENT),1)
	docker compose -f ${COMPOSE} up --build -d
else
	docker-compose -f ${COMPOSE} up --build -d
endif
	@echo ""
	@echo "${GREEN}+ ONLINE!${RESET}"
	@echo "${GREEN}+ ${RESET}WordPress:    ${YELLOW}https://${DOMAIN}/${RESET}"
	@echo "${GREEN}+ ${RESET}WP dashboard: ${YELLOW}https://${DOMAIN}/wp-admin${RESET}"
	@echo ""

${WP_DATA_DIR}:
	sudo mkdir -p $@

${MDB_DATA_DIR}:
	sudo mkdir -p $@

down:
ifeq ($(ENVIRONMENT),1)
	docker compose -f ${COMPOSE} down
else
	docker-compose -f ${COMPOSE} down
endif
	@echo ""
	@echo "${GREEN}+ ${RESET}Server ${YELLOW}${DOMAIN}${RESET} is offline"
	@echo ""

clean: down
	docker rmi $(shell docker images -f "dangling=true" -q) 2> /dev/null || true

fclean: clean
	docker rmi $(shell docker images -qa) 2> /dev/null || true
	docker volume rm $(shell docker volume ls -q) 2> /dev/null || true
	docker system prune --all --force
	sudo rm -rf ${USERBIND}

re: fclean all

.PHONY: all up down clean fclean re

GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
RESET  := $(shell tput -Txterm sgr0)
