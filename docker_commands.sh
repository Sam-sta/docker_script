docker network create --attachable atnet
docker volume create postgresql
docker volume create postgresql_data
docker run -d --name sonardatabase --network atnet --restart always -e POSTGRES_USER=sonardb -e POSTGRES_PASSWORD=sonar -v postgresql:/var/lib/postgresql -v postgresql_data:/var/lib/postgresql/data postgres:12.1-alpine
docker volume create sonarqube_data
docker volume create sonarqube_extensions
docker volume create sonarqube_logs
docker run -d --name sonarqube --network atnet -p 9000:9000 -e SONARQUBE_JDBC_URL=jdbc:postgresql://sonardatabase:5432/sonardb -e SONAR_JDBC_USERNAME=sonardb -e SONAR_JDBC_PASSWORD=sonar -v sonarqube_data:/opt/sonarqube/data -v sonarqube_extensions:/opt/sonarqube/extensions -v sonarqube_logs:/opt/sonarqube/logs sonarqube:8.9.0-community
docker volume create jenkins_volume
docker run -d --name jenkins -p 8080:8080 -p 50000:50000 -v jenkins_volume:/var/jenkins_home jenkins:2.60.3
docker network connect atnet jenkins
docker volume create nexus_data
docker run -d --name nexus --network atnet -v nexus_data:/nexus-data -p 8081:8081 sonatype/nexus3