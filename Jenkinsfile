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

		stage('Unit Testing') {
			steps {
				sh 'mvn test'
			}
		}

		stage('Integration Testing') {
			steps {
				sh 'mvn verify -DskipUnitTests'
			}
		}

		stage('Maven Build') {
			steps {
				sh 'mvn clean install'
			}
		}

		stage('Static Code Analysis') {
			steps {
				script {
					withSonarQubeEnv(credentialsId: 'sonar-key') {
						sh 'mvn clean package sonar:sonar'
					}
				}
			}
		}

		stage('Quality Gate') {
			steps {
				script {
					waitForQualityGate abortPipeline: false, credentialsId: 'sonar-key'
				}
			}
		}

		stage('Nexus Upload') {
			steps {
				script {
					nexusArtifactUploader artifacts: [
						[
						artifactId: 'springboot', 
						classifier: '', 
						file: 'target/Uber.jar', 
						type: 'jar'
						]
					], 
					credentialsId: 'nexus-key', 
					groupId: 'com.example', 
					nexusUrl: 'localhost:8081', 
					nexusVersion: 'nexus3', 
					protocol: 'http', 
					repository: 'domingo-release', 
					version: '1.0.0'
				}
			}
		}

	}
}
