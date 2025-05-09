FROM maven:3.9.9-eclipse-temurin-24 AS build
WORKDIR /app
COPY src ./src
COPY pom.xml ./
RUN mvn -f ./pom.xml clean package -DskipTests

FROM eclipse-temurin:24-jdk
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]