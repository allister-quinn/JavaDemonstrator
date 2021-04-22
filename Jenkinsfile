pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        sh '''
mvn clean install'''
      }
    }

    stage('Test') {
      steps {
        sh 'mvn sonar:sonar -Dsonar.host.url=http://<IP address>:9000'
      }
    }

  }
}