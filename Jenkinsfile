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

	}
}
