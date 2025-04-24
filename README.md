## Inception

**Inception** es un entorno de desarrollo y despliegue de WordPress totalmente contenedorizado, que incluye MariaDB como base de datos y Nginx como servidor web, orquestado con Docker Compose y automatizado mediante un Makefile. Está pensado tanto para desarrollo local como para demostraciones en producción ligera.

---

## 🔍 Descripción

Este proyecto te permite levantar en un solo paso un stack completo:

- **MariaDB**: Base de datos relacional, configurada con ajustes de rendimiento y codificación UTF-8.
- **WordPress**: Instalación automática de WordPress usando WP-CLI, con creación de usuario y tema predeterminado.
- **Nginx**: Proxy reverso con SSL autofirmado para servir WordPress por HTTPS.
- **Makefile**: Simplifica la orquestación incluyendo la inserción automática del dominio en `/etc/hosts`, creación de volúmenes persistentes y comandos de ciclo de vida (`up`, `down`, `clean`).

---

## ⚙️ Arquitectura

```
┌───────────────────┐      ┌───────────────┐      ┌──────────────────┐
│   Contenedor      │      │   Contenedor  │      │   Contenedor     │
│    MariaDB        │◀───▶ │   WordPress   │◀───▶ │      Nginx        │
│ (puerto 3306)     │      │ (puerto 9000) │      │  (puerto 443)    │
└───────────────────┘      └───────────────┘      └──────────────────┘
           │                       │                       │
           │                       │                       │
       Volumen                  Volumen                 ––
(`/home/.../mariadb`)    (`/home/.../wordpress`)    SSL y configuración
```

---

## 🛠 Tecnologías

- **Docker & Docker Compose**  
- **Makefile**  
- **Bash scripting** (scripts de inicialización y hosts)  
- **Nginx** con SSL (OpenSSL)  
- **MariaDB**  
- **WordPress** + **WP-CLI**  

---

## 📂 Estructura del proyecto

```text
Inception/
├── Makefile
├── src/
│   ├── .env
│   ├── docker-compose.yml
│   └── requirements/
│       ├── mariadb/
│       │   ├── conf/mariadb.conf
│       │   ├── Dockerfile
│       │   └── tools/mariadb.sh
│       ├── nginx/
│       │   ├── conf/default.conf
│       │   ├── Dockerfile
│       │   └── tools/nginx_start.sh
│       └── wordpress/
│           ├── Dockerfile
│           ├── conf/www.conf
│           └── tools/wp.sh
└── README.md
```

---

## 📋 Requisitos previos

- [Docker](https://www.docker.com/)  
- [Docker Compose](https://docs.docker.com/compose/)  
- Permisos de `sudo` para modificar `/etc/hosts`

---

## 🔧 Variables de entorno

Define tus parámetros en `src/.env`:

```dotenv
DONAIN_NAME=mi-dominio.local
MYSQL_HOSTNAME=mariadb
MYSQL_DATABASE=mi_db
MYSQL_USER=usuario
MYSQL_PASSWORD=pass
MYSQL_ROOT_USER=root
MYSQL_ROOT_PASSWORD=pass_root

WORDPRESS_TITLE=MiSitio
WORDPRESS_ADMIM=admin_wp
WORDPRESS_ADMIM_PASS=pass_wp
WORDPRESS_ADMIM_EMAIL=admin@correo.com
WORDPRESS_USER=autor_wp
WORDPRESS_EMAIL=autor@correo.com
WORDPRESS_USER_PASS=pass_autor
```

---

## 🚀 Instalación y uso

1. **Clona el repositorio**  
   ```bash
   git clone https://github.com/jainavas/inception.git
   cd inception
   ```

2. **Ajusta tu archivo `.env`** en `src/.env` según tus necesidades.

3. **Levanta todo el entorno**  
   ```bash
   make all
   ```
   - Se añadirá tu dominio en `/etc/hosts`.
   - Se crearán los volúmenes de datos en `~/data/mariadb` y `~/data/wordpress`.
   - Se levantará el stack con Docker Compose.

4. **Visita tu sitio**  
   Accede por HTTPS a `https://<DONAIN_NAME>` (el certificado SSL se genera automáticamente).

5. **Detener servicios**  
   ```bash
   make down
   ```

6. **Limpiar todo**  
   ```bash
   make clean
   ```
   Elimina contenedores, imágenes, volúmenes y la red Docker.

---

## 🤝 Contribuciones

1. Haz un **fork** del proyecto.
2. Crea una **branch** para tu feature o corrección:  
   ```bash
   git checkout -b feature/nueva-funcionalidad
   ```
3. Haz tus cambios y **commitea**:  
   ```bash
   git commit -m "Añade descripción de la mejora"
   ```
4. Envía tu **pull request**.

---

## 📄 Licencia

Este proyecto está bajo la licencia MIT. Consulta el archivo `LICENSE` para más detalles.

---

## ✉️ Contacto

**Jaime Navascues Peña**  
- Email: jainavas@student.42madrid.com
- GitHub: [@jainavas](https://github.com/jainavas)  
