FROM alpine:latest
RUN apk update && \
apk add maven openjdk11 git
RUN git clone https://github.com/ichibanbosi/for_HW_12.git && cd for_HW_12
WORKDIR /for_HW_12
RUN cp ./WebContent/Config.properties /mnt
RUN mvn package
RUN cp /for_HW_12/target/App42PaaS-Java-MySQL-Sample-0.0.1-SNAPSHOT.war /mnt

FROM tomcat:alpine
RUN mkdir /usr/local/tomcat/ROOT/
COPY --from=0 /mnt/Config.properties /usr/local/tomcat/ROOT/
COPY --from=0 /mnt/App42PaaS-Java-MySQL-Sample-0.0.1-SNAPSHOT.war /usr/local/tomcat/webapps