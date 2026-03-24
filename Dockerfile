#Build du WAR avec Gradle + JDK 21
FROM eclipse-temurin:21-jdk AS build
WORKDIR /app

COPY gradlew .
COPY gradle gradle
COPY build.gradle settings.gradle ./
COPY src src


RUN chmod +x gradlew

RUN ./gradlew clean bootWar

#Tomcat
FROM tomcat:10.1.24-jre21-temurin

# clean Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR in Tomcat
COPY --from=build /app/build/libs/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
