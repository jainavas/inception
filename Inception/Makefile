.PHONY: all down clean

# Crear los directorios y levantar los servicios
all:
	@echo "Creando directorios de datos..."
	@mkdir -p /home/jainavas/data/mariadb
	@mkdir -p /home/jainavas/data/wordpress
	@echo "Levantando los servicios con Docker Compose..."
	@docker compose -f ./src/docker-compose.yml up -d --build

up-%:
	docker compose -f ./src/docker-compose.yml up $*

build-%:
	docker compose -f ./src/docker-compose.yml build $*

# Apagar los servicios
down:
	@echo "Apagando los servicios con Docker Compose..."
	@docker compose -f ./src/docker-compose.yml down

# Limpiar contenedores, imágenes, volúmenes, y redes
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
