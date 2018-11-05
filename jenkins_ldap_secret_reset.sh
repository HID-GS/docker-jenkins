#!/bin/bash

if [ ${LDAP_SECRET+x} ]; then
  JENKINS_LDAP_SECRET=${LDAP_SECRET}
fi

if [ -f "/run/secrets/jenkins_ldap_password" ]; then
  JENKINS_LDAP_SECRET=$(cat /run/secrets/jenkins_ldap_password)
fi

if [ ${JENKINS_HOME+x} ] && [ ${JENKINS_LDAP_SECRET+x} ] && [ -f "${JENKINS_HOME}/config.xml" ]; then
  echo "found config.xml file, adjusting LDAP password"
  sed -i.bak "s#\(<managerPasswordSecret>\).*\(</managerPasswordSecret>\)#\1${JENKINS_LDAP_SECRET}\2#g" "${JENKINS_HOME}/config.xml"
else
  echo "config.xml or ldap settings not found"
fi
