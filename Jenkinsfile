pipeline {
	agent any
	tools {
		maven 'Maven 3.9.0'
	}
	stages {
		stage('Git Checkout') {
			steps {
				git 'https://github.com/freddy-alexis-ht/Demo-CI-CD.git'
			}
		}

		// stage('Unit Testing') {
		// 	steps {
		// 		sh 'mvn test'
		// 	}
		// }

		// stage('Integration Testing') {
		// 	steps {
		// 		sh 'mvn verify -DskipUnitTests'
		// 	}
		// }

		stage('Maven Build') {
			steps {
				sh 'mvn clean install'
			}
		}

		// stage('Static Code Analysis') {
		// 	steps {
		// 		script {
		// 			withSonarQubeEnv(credentialsId: 'sonar-key') {
		// 				sh 'mvn clean package sonar:sonar'
		// 			}
		// 		}
		// 	}
		// }

		// stage('Quality Gate') {
		// 	steps {
		// 		script {
		// 			waitForQualityGate abortPipeline: false, credentialsId: 'sonar-key'
		// 		}
		// 	}
		// }

		// stage('Nexus Upload') {
		// 	steps {
		// 		script {
		// 			def readPomVersion = readMavenPom file: 'pom.xml'
		// 			// Validation to choose specific repo: release|snapshot
		// 			def nexusRepo = readPomVersion.version.endsWith("SNAPSHOT") ? "domingo-snapshot" : "domingo-release"
		// 			nexusArtifactUploader artifacts: [
		// 				[
		// 				artifactId: 'springboot', 
		// 				classifier: '', 
		// 				file: 'target/Uber.jar', 
		// 				type: 'jar'
		// 				]
		// 			], 
		// 			credentialsId: 'nexus-key', 
		// 			groupId: 'com.example', 
		// 			nexusUrl: 'localhost:8081', 
		// 			nexusVersion: 'nexus3', 
		// 			protocol: 'http', 
		// 			//repository: 'domingo-release', 
		// 			repository: nexusRepo, 
		// 			//version: '1.0.0'
		// 			version: "${readPomVersion.version}"
		// 		}
		// 	}
		// }

		stage('Docker Image Build') {
			steps {
				script {
					// Image build: I.e. JOB_NAME: DemoApp / BUILD_ID: 39 => DemoApp:v1.39
					sh 'docker image build -t $JOB_NAME:v1.$BUILD_ID .'
					// Tagging: 1) version / 2) latest
					sh 'docker image tag $JOB_NAME:v1.$BUILD_ID freddyalexis/$JOB_NAME:v1.$BUILD_ID'
					sh 'docker image tag $JOB_NAME:v1.$BUILD_ID freddyalexis/$JOB_NAME:latest'
				}
			}
		}

		stage('Push Image to DockerHub') {
			steps {
				script {
					withCredentials([string(credentialsId: 'dockerhub-key', variable: 'dockerhubvar')]) {
						sh 'docker login -u freddyalexis -p ${dockerhubvar}'
						sh 'docker image push freddyalexis/$JOB_NAME:v1.$BUILD_ID'
						sh 'docker image push freddyalexis/$JOB_NAME:latest'
					}
				}
			}
		}
	}
}
