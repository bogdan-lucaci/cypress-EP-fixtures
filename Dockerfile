#FROM node:lts-alpine as build
#FROM node:18
#FROM cypress/included:latest
FROM cypress/included:cypress-13.0.0-node-18.15.0-chrome-106.0.5249.61-1-ff-99.0.1-edge-114.0.1823.51-1
RUN apt-get update -y && \
    apt-get install -y build-essential \
    curl \
    unixodbc-dev
CMD node --version
# Microsoft Repo Debian 11 
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/debian/11/prod.list > /etc/apt/sources.list.d/mssql-release.list

# Updating repos
RUN apt-get update -y

# Install MSODBC17 Driver
RUN ACCEPT_EULA=Y apt-get install -y msodbcsql17
RUN ACCEPT_EULA=Y apt-get install -y mssql-tools
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
RUN apt-get install -y unixodbc-dev

RUN mkdir -p /data/repo

WORKDIR /data/repo
ARG user
ARG pass
ARG ip

RUN pwd
RUN git clone https://${user}:${pass}@dev.azure.com/nuvei/DigitalPayments/_git/APM.Automation.CypressEP
#RUN git clone --branch feature/docker_test https://${user}:${pass}@dev.azure.com/nuvei/DigitalPayments/_git/APM.Automation.CypressEP

ENV HTTP_PROXY=ipv4.${ip}.webdefence.global.blackspider.com:80


# tried this to solve:

#Error: Webpack Compilation Error
#Module not found: Error: Can't resolve 'process/browser.js' in '/data/repo/APM.Automation.CypressEP/node_modules/js-md5/src'
#Cannot read properties of undefined (reading 'module')

#WORKDIR /usr/local/lib/node_modules/corepack
#RUN npm install


WORKDIR /data/repo/APM.Automation.CypressEP
RUN npm install
COPY ./EP/env.properties.json ./nuvei-cypress/EP/env.properties.json


#RUN pwd
#RUN ls -la
#RUN ls -la node-modules

#ENTRYPOINT ["tail", "-f", "/dev/null"]


#========================
# Usage:
#========================

#docker build . -t ep-fixtures --build-arg="user=<git user>" --build-arg="pass=<git pass>" --build-arg="ip=<my ip>"
#docker run -it -e NO_PROXY="*" ep-fixtures cypress run --config-file nuvei-cypress/EP/cypress.config.js --spec cypress/e2e/EP_Tests_Engine.spec.cy.js --env grepTags=methodName_mrcash
#109.99.108.161
