docker network create --attachable atnet
docker volume create postgresql
docker volume create postgresql_data
docker run -d --name sonardatabase --network atnet --restart always -e POSTGRES_USER=sonardb -e POSTGRES_PASSWORD=sonar -v postgresql:/var/lib/postgresql -v postgresql_data:/var/lib/postgresql/data postgres:12.1-alpine
