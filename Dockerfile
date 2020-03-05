FROM jboss/base-jdk:8

ENV KEYCLOAK_VERSION 6.0.1
ENV JDBC_MYSQL_VERSION 5.1.46

ENV LAUNCH_JBOSS_IN_BACKGROUND 1
ENV PROXY_ADDRESS_FORWARDING false
ENV JBOSS_HOME /opt/jboss/keycloak
ENV LANG en_US.UTF-8

USER root

RUN yum install -y epel-release git && yum install -y jq openssl which && yum clean all

ADD keycloak /opt/jboss/keycloak
ADD tools /opt/jboss/tools
RUN /opt/jboss/tools/build-keycloak.sh

USER 1000

EXPOSE 8080
EXPOSE 8443

ENTRYPOINT [ "/opt/jboss/tools/docker-entrypoint.sh" ]

CMD ["-b", "0.0.0.0"]
