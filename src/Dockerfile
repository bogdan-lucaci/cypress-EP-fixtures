#FROM node:lts-alpine as build
FROM node:20.7-bullseye
#FROM cypress/included:latest
#FROM cypress/included:cypress-13.0.0-node-18.15.0-chrome-106.0.5249.61-1-ff-99.0.1-edge-114.0.1823.51-1
#FROM cypress/included:cypress-12.13.0-node-18.16.0-chrome-113.0.5672.92-1-ff-113.0-edge-113.0.1774.35-1
RUN apt-get update -y && \
    apt-get install -y build-essential \
    curl \
    unixodbc-dev

#Cypres dependencies - https://docs.cypress.io/guides/continuous-integration/introduction#Dependencies
RUN apt-get install -y \
        libgtk2.0-0 \
        libgtk-3-0 \
        libgbm-dev \
        libnotify-dev \
        libgconf-2-4 \
        libnss3 \
        libxss1 \
        libasound2 \
        libxtst6 \
        xauth \
        xvfb

# Microsoft Repo Debian 11 
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/debian/11/prod.list > /etc/apt/sources.list.d/mssql-release.list

RUN apt-get install libgtk-3-0 libxss1 libgconf-2-4 libasound2

# Updating repos
RUN apt-get update -y

# Update OpenSSL to last version
#RUN apk update && apk upgrade openssl

# Install MSODBC17 Driver
RUN ACCEPT_EULA=Y apt-get install -y msodbcsql17
RUN ACCEPT_EULA=Y apt-get install -y mssql-tools
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
RUN apt-get install -y unixodbc-dev

# Install Poweshell
RUN apt-get install -y powershell

# Install custom certificate
COPY ["src/certs/*.crt", "/usr/local/share/ca-certificates/"]
RUN npm --verbose config set cafile="/usr/local/share/ca-certificates/ca-certificates.crt"

RUN mkdir -p /data/repo

WORKDIR /data/repo
ARG user
ARG pass
ARG ip

RUN git clone https://${user}:${pass}@dev.azure.com/nuvei/DigitalPayments/_git/APM.Automation.CypressEP
#ADD ./../../_GIT_DigitalPayments/APM.Automation.CypressEP/* .
# COPY --from=localrepository * .
#RUN git clone --branch feature/docker_test_2 https://${user}:${pass}@dev.azure.com/nuvei/DigitalPayments/_git/APM.Automation.CypressEP

#ENV HTTP_PROXY=ipv4.${ip}.webdefence.global.blackspider.com:80
ENV HTTP_PROXY=87.120.11.143:443



# tried this to solve:

#Error: Webpack Compilation Error
#Module not found: Error: Can't resolve 'process/browser.js' in '/data/repo/APM.Automation.CypressEP/node_modules/js-md5/src'
#Cannot read properties of undefined (reading 'module')

# fixed by using cypress/included:cypress-12.13.0-node-18.16.0-chrome-113.0.5672.92-1-ff-113.0-edge-113.0.1774.35-1

#WORKDIR /usr/local/lib/node_modules/corepack
#RUN npm install


WORKDIR /data/repo/APM.Automation.CypressEP

# overwrite with local files
# COPY ./src/package.json ./package.json
# RUN rm /data/repo/APM.Automation.CypressEP/package-lock.json
# COPY ./EP/cypress.config.js ./nuvei-cypress/EP/cypress.config.js
# COPY ./src/e2e.js ./cypress/support/e2e.js

RUN npm install

# install Cypress for Linux
RUN wget --no-check-certificate https://cdn.cypress.io/desktop/13.2.0/linux-x64/cypress.zip -O /data/cypress.zip
RUN mkdir -p /root/.cache/Cypress/13.2.0
##COPY ./src/cypress.zip /data
RUN unzip /data/cypress.zip -d /root/.cache/Cypress/13.2.0
RUN rm /data/cypress.zip

# overwrite with local env.properties
COPY ./EP/env.properties.json ./nuvei-cypress/EP/env.properties.json

COPY ./src/openssl.cnf /usr/lib/ssl/openssl.cnf

#ENV CYPRESS_CACHE_FOLDER=/data/repo/APM.Automation.CypressEP/node_modules/cypress

#ENTRYPOINT ["tail", "-f", "/dev/null"]


#========================
# Usage:
#========================
# 1. run build.ps1
# 2. run start.ps1
