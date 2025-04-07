.PHONY: all down clean

# Cargar variables del entorno desde .env
include ./src/.env
export $(shell sed 's/=.*//' ./src/.env)

# Ruta al archivo hosts
HOSTS_FILE := /etc/hosts

# IP deseada (puedes cambiarla si es distinta en tu setup)
DOCKER_HOST_IP := 127.0.0.1

all:
	@echo "Asegurando que $(DONAIN_NAME) esté en /etc/hosts..."
	@if ! grep -q "$(DONAIN_NAME)" $(HOSTS_FILE); then \
		echo "$(DOCKER_HOST_IP) $(DONAIN_NAME)" | sudo tee -a $(HOSTS_FILE); \
		echo "Añadido $(DONAIN_NAME) a $(HOSTS_FILE)"; \
	else \
		echo "$(DONAIN_NAME) ya está en $(HOSTS_FILE)"; \
	fi
	@echo "Creando directorios de datos..."
	@mkdir -p /home/jainavas/data/mariadb
	@mkdir -p /home/jainavas/data/wordpress
	@echo "Levantando los servicios con Docker Compose..."
	@docker compose -p src -f ./src/docker-compose.yml up -d --build

up-%:
	docker compose -p src -f ./src/docker-compose.yml up $*

build-%:
	docker compose -p src -f ./src/docker-compose.yml build $*

down:
	@echo "Apagando los servicios con Docker Compose..."
	@docker compose -p src -f ./src/docker-compose.yml down

clean:
	@echo "Eliminando directorios de datos..."
	@rm -rf /home/jainavas/data/

	@echo "Eliminando imágenes de Docker..."
	@docker rmi -f $$(docker images -qa) || true

	@echo "Eliminando contenedores de Docker..."
	@docker rm -f $$(docker ps -qa) || true

	@echo "Deteniendo contenedores de Docker..."
	@docker stop $$(docker ps -qa) || true

	@echo "Eliminando volúmenes de Docker..."
	@docker volume rm -f $$(docker volume ls -q) || true

	@echo "Eliminando red de Docker..."
	@docker network rm jainavasnet || true

	@echo "Limpieza completada."

