pipeline {
  agent {
    docker {
      image 'maven:3.8.1-adoptopenjdk-11'
      args '-v /root/.m2:/root/.m2 --net="host"'
    }

  }
  stages {
    stage('Build') {
      steps {
        sh 'mvn -B -DskipTests clean package'
      }
    }

    stage('Static Analysis') {
      steps {
        withSonarQubeEnv('SonarQube') {
          sh 'mvn sonar:sonar'
        }

      }
    }

  }
}
