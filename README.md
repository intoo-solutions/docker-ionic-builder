[![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/intoo/docker-ionic-builder.svg)](https://hub.docker.com/r/intoo/docker-ionic-builder/builds)
[![Docker Cloud Automated build](https://img.shields.io/docker/cloud/automated/intoo/docker-ionic-builder.svg)](https://hub.docker.com/r/intoo/docker-ionic-builder/builds)

# docker-ionic-builder

Image based on [beevelop/ionic](https://hub.docker.com/r/beevelop/ionic/), with ChromeHeadless in order to run tests. 

The versionning follows the base image.

The Chrome installation is inspired by [SeleniumHQ/docker-selenium](https://github.com/SeleniumHQ/docker-selenium) . 

## Usage in Jenkins

This image can be used in a Jenkins Pipeline in order to build  an Ionic project, and especially to run the tests which need a headless Chrome.

```groovy
docker.image('intoo/docker-ionic-builder:v4.12.0').inside('-u root') {
    stage('check tools') {
        parallel(
            java: {
                sh "java -version"
            },
            node: {
                sh "node -v"
            },
            npm:{
                sh "npm -v"
            }
            
        )
    }
    
    stage('accept licences') {
        sh "yes | cordova -v"
        sh 'echo "y" | $ANDROID_HOME/tools/bin/sdkmanager --update'
    }
    
    stage('install tools'){
        sh  "npm i -D -E @ionic/app-scripts"
    }

    stage('test'){
        sh "npm run test-headless"
    }

    ...
     
}
```


## Headless chrmoe in ionic project. 

In order to run tests with a headless chrome , you can install `karma-chrome-launcher` and use a goal like `"test-headless": "ng test --watch=false --browsers=ChromeHeadless",`.

If the following error happen `Cannot start ChromeHeadless [] Running as root without --no-sandbox is not supported. See https://crbug.com/638180` then you need to update the configuration and launch ChromeHeadless with the flag `--no-sandbox` as described in https://github.com/karma-runner/karma-chrome-launcher/issues/158




