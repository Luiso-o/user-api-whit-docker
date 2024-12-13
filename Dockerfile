# Crear una imagen modelo
FROM eclipse-temurin:21.0.3_9-jdk

# Informar el puerto donde se ejecuta el contenedor (Informativo)
EXPOSE 8080

# Definir directorio raiz del contenedor
WORKDIR /root

# Copiar y pegar archivos dentro del contenedor
COPY ./pom.xml /root
COPY ./.mvn /root/.mvn
COPY ./mvnw /root

# Descargar las dependencias
RUN ./mvnw dependency:go-offline

# Copiar el codigo fuente dentro del contenedor
COPY ./src /root/src

# Construir la aplicacion
RUN ./mvnw clean install -DskipTests #saltar tests

# Levantar la app cuando el contenedor inicie
ENTRYPOINT ["java", "-jar", "/root/target/SpringDocker-0.0.1-SNAPSHOT.jar"]

