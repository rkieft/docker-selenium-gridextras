FROM ubuntu:16.04

MAINTAINER Richard Kieft <richard@detesters.nl>

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

RUN apt-get update -y \
    && apt-get -y --no-install-recommends install openjdk-8-jre-headless wget ca-certificates sudo lsof \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/selenium && wget --no-check-certificate -O /opt/selenium/SeleniumGridExtras.jar \
    "https://github.com/groupon/Selenium-Grid-Extras/releases/download/v2.0.1/SeleniumGridExtras-2.0.1-SNAPSHOT-jar-with-dependencies.jar"

RUN chmod +x /opt/selenium/SeleniumGridExtras.jar

ADD hub_4444.json /opt/selenium/hub_4444.json
ADD selenium_grid_extras_config.json /opt/selenium/selenium_grid_extras_config.json

EXPOSE 3000 4444

WORKDIR /opt/selenium/

CMD ["java", "-jar", "/opt/selenium/SeleniumGridExtras.jar"]