#!/bin/sh

BUGFIX=2
MINOR=16
MAJOR=2
STABLE_EXTENSIONS=querylayer-plugin,importer-plugin
COMMUNITY_EXTENSIONS=gwc-azure-blobstore-plugin
# Build Geoserver
echo "Building GeoServer ${MAJOR}.${MINOR}.${BUGFIX} "

docker build \
  --build-arg COMMUNITY_EXTENSIONS=${COMMUNITY_EXTENSIONS} \
  --build-arg STABLE_EXTENSIONS=${STABLE_EXTENSIONS} \
  --build-arg GS_VERSION=${MAJOR}.${MINOR}.${BUGFIX} \
  --build-arg TOMCAT_EXTRAS=true \
  --build-arg SAMPLE_DATA=true \
  -t oinf/geoserver:${MAJOR}.${MINOR}.${BUGFIX} .

# Build Arguments - To change the defaults when building the image
#need to specify a different value.

#--build-arg ORACLE_JDK=true
#--build-arg COMMUNITY_MODULES=true
#--build-arg TOMCAT_EXTRAS=false
#--build-arg WAR_URL=http://downloads.sourceforge.net/project/geoserver/GeoServer/<GS_VERSION>/geoserver-<GS_VERSION>-war.zip
#--build-arg INITIAL_MEMORY=2G
#--build-arg MAXIMUM_MEMORY=4G




