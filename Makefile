DOMAIN       := frosa-ma.42.fr

USERBIND     := /home/frosa-ma
DATABIND     := ${USERBIND}/data
WP_DATA_DIR  := ${DATABIND}/wordpress
MDB_DATA_DIR := ${DATABIND}/mariadb

COMPOSE      := srcs/docker-compose.yml

all: up

up: | ${WP_DATA_DIR} ${MDB_DATA_DIR}
	@cat /etc/hosts | grep ${DOMAIN} > /dev/null || echo "127.0.0.1 ${DOMAIN}" | sudo tee -a /etc/hosts > /dev/null
	docker-compose -f ${COMPOSE} up --build -d
	@echo ""
	@echo "${GREEN}+ ONLINE!${RESET}"
	@echo "${GREEN}+ ${RESET}WordPress:    ${YELLOW}https://${DOMAIN}/${RESET}"
	@echo "${GREEN}+ ${RESET}WP dashboard: ${YELLOW}https://${DOMAIN}/wp-admin${RESET}"
	@echo "${GREEN}+ ${RESET}Adminer:      ${YELLOW}https://${DOMAIN}/adminer${RESET}"
	@echo "${GREEN}+ ${RESET}Golang app:   ${YELLOW}https://${DOMAIN}/app${RESET}"
	@echo "${GREEN}+ ${RESET}NGROK tunnel: ${YELLOW}http://frosa-ma.42.fr:4040/inspect/http${RESET}"
	@echo "${GREEN}+ ${RESET}FTP server:   ${YELLOW}make ftp${RESET}"
	@echo ""

ftp:
	ftp $(shell docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ftp)

${WP_DATA_DIR}:
	sudo mkdir -p $@

${MDB_DATA_DIR}:
	sudo mkdir -p $@

down:
	docker-compose -f ${COMPOSE} down
	@echo ""
	@echo "${GREEN}+ ${RESET}Server ${YELLOW}${DOMAIN}${RESET} is offline"
	@echo ""

clean: down
	docker rmi $(shell docker images -f "dangling=true" -q) 2> /dev/null || true

fclean: clean
	docker rmi $(shell docker images -qa) 2> /dev/null || true
	docker volume rm $(shell docker volume ls -q) 2> /dev/null || true
	sudo rm -rf ${USERBIND}

re: fclean all

.PHONY: all up down clean fclean re

GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
RESET  := $(shell tput -Txterm sgr0)
