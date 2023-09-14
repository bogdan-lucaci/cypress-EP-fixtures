# function volumeExists {
#   if [ "$(docker volume ls -f name=$1 | awk '{print $NF}' | grep -E '^'$1'$')" ]; then
#     return 0
#   else
#     return 1
#   fi
# }

"$PWD\EP\results\screenshots"
#--opt device=D:\\_work\\Smart2Pay\\automation\\_GIT_dockerization\\nuvei-cypress-EP-fixtures\\EP\\results\\screenshots `

#-e HTTP_PROXY="ipv4.$ExternalIp.webdefence.global.blackspider.com:80" `
#--mount source=ep-fixtures-vol,target=/data/repo/APM.Automation.CypressEP/cypress/screenshots/ `

# $ExternalIpRequest = Invoke-WebRequest -URI http://myexternalip.com/raw
# $ExternalIp = $ExternalIpRequest.Content

#docker volume rm ep-fixtures-vol
# docker volume create --driver local `
#     --opt type=block `
#     --opt device="\D\_work\Smart2Pay\automation\_GIT_dockerization\nuvei-cypress-EP-fixtures\EP\results\screenshots" `
#     ep-fixtures-vol
    
docker rm -f ep-fixtures-container
docker run --name ep-fixtures-container `
    -v $PWD\EP\results\screenshots:/data/repo/APM.Automation.CypressEP/cypress/screenshots/ `
    -e NO_PROXY="*" `
    ep-fixtures-img `
    cypress run `
    --config-file nuvei-cypress/EP/cypress.config.js `
    --spec cypress/e2e/EP_Tests_Engine.spec.cy.js `
    --env grepTags=methodName_mrcash `
    --config video=false



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