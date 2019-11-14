FROM jenkins/jenkins:2.204-alpine
USER root
RUN apk add --update --no-cache \
    docker
USER jenkins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

USER root

COPY jenkins_ldap_secret_reset.sh /usr/local/bin/jenkins_ldap_secret_reset.sh
RUN sed -e '3i/usr/local/bin/jenkins_ldap_secret_reset.sh' -i /usr/local/bin/jenkins.sh

USER ${user}
