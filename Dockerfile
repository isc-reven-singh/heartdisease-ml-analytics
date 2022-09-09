ARG IMAGE=intersystems/iris-community:2022.1.0.191.0
ARG IMAGE=intersystemsdc/iris-community:latest
FROM $IMAGE

USER root

WORKDIR /opt/heartapp
RUN chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /opt/heartapp
USER ${ISC_PACKAGE_MGRUSER}

COPY Installer.cls .
COPY src /usr/irissys/mgr/src

USER root
RUN chown -R ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /usr/irissys/mgr/src

USER ${ISC_PACKAGE_MGRUSER}
COPY iris.script /tmp/iris.script


#revert user
USER ${ISC_PACKAGE_MGRUSER}

# run iris and initial 
RUN iris start IRIS \
	&& iris session IRIS < /tmp/iris.script
