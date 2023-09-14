#FROM node:lts-alpine as build
#FROM node:18
#FROM cypress/included:latest
#FROM cypress/included:cypress-13.0.0-node-18.15.0-chrome-106.0.5249.61-1-ff-99.0.1-edge-114.0.1823.51-1
FROM cypress/included:cypress-12.13.0-node-18.16.0-chrome-113.0.5672.92-1-ff-113.0-edge-113.0.1774.35-1
RUN apt-get update -y && \
    apt-get install -y build-essential \
    curl \
    unixodbc-dev

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

RUN git clone https://${user}:${pass}@dev.azure.com/nuvei/DigitalPayments/_git/APM.Automation.CypressEP
#RUN git clone --branch feature/docker_test https://${user}:${pass}@dev.azure.com/nuvei/DigitalPayments/_git/APM.Automation.CypressEP

ENV HTTP_PROXY=ipv4.${ip}.webdefence.global.blackspider.com:80


# tried this to solve:

#Error: Webpack Compilation Error
#Module not found: Error: Can't resolve 'process/browser.js' in '/data/repo/APM.Automation.CypressEP/node_modules/js-md5/src'
#Cannot read properties of undefined (reading 'module')

# fixed by using cypress/included:cypress-12.13.0-node-18.16.0-chrome-113.0.5672.92-1-ff-113.0-edge-113.0.1774.35-1

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
# 1. run build.ps1
# 2. run start.ps1
#docker build . -t ep-fixtures --build-arg="user=<git user>" --build-arg="pass=<git pass>" --build-arg="ip=<my ip>"
#docker run -it -e NO_PROXY="*" ep-fixtures cypress run --config-file nuvei-cypress/EP/cypress.config.js --spec cypress/e2e/EP_Tests_Engine.spec.cy.js --env grepTags=methodName_mrcash --config video=false

##docker run --name ep-fixtures -v /EP/results/screenshots:/data/repo/APM.Automation.CypressEP/cypress/screenshots -it `
##docker run --name ep-fixtures -v /data/repo/APM.Automation.CypressEP/cypress/screenshots/EP_Tests_Engine.spec.cy.js/:/EP/results/screenshots -it `
# docker run --name ep-fixtures `
#     -v ${PWD}/EP/results/screenshots/:/data/repo/APM.Automation.CypressEP/cypress/screenshots/ -it `
#     -e HTTP_PROXY="ipv4.109.99.108.161.webdefence.global.blackspider.com:80" `
#     -e NO_PROXY="*.smart2pay.com" `
#     ep-fixtures `
#     cypress run `
#     --config-file nuvei-cypress/EP/cypress.config.js `
#     --spec cypress/e2e/EP_Tests_Engine.spec.cy.js `
#     --env grepTags=methodName_mrcash `
#     --config video=false
#109.99.108.161
