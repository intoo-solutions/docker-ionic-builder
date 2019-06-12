#!/usr/bin/env groovy

// Ne garder que 5 builds et 5 artefacts
properties([buildDiscarder(logRotator(artifactNumToKeepStr: '5', numToKeepStr: '5'))])

node {
    stage('checkout') {
        checkout scm
    } 

    def dockerImage
    stage('build'){
        // le tag de beeionic
        def tag = 'v4.12.0'
        dockerImage = docker.build("intoo/docker-ionic-builder:${tag}", '.')
        sh "docker tag intoo/docker-ionic-builder:${tag} intoo/docker-ionic-builder:latest"
    }

    stage('push'){
        docker.withRegistry( '', "dockerhub" ) {
		    dockerImage.push()
		}
    }
}