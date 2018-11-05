#!/bin/bash

if [ ${JENKINS_HOME+x} ] && [ ${LDAP_SECRET+x} ] && [ -f "${JENKINS_HOME}/config.xml" ]; then
  echo "found config.xml file, adjusting LDAP password"
  sed -i.bak "s#\(<managerPasswordSecret>\).*\(</managerPasswordSecret>\)#\1${LDAP_SECRET}\2#g" "${JENKINS_HOME}/config.xml"
else
  echo "config.xml or ldap settings not found"
fi
