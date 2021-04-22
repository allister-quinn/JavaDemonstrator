pipeline {
  agent {
        docker {
            image 'maven:3.8.1-adoptopenjdk-11' 
            args '-v /root/.m2:/root/.m2' 
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
                    sonar:sonar
                }
            }
        }
        stage('Quality Gate') {
            steps {
                waitForQualityGate abortPipeline: true
            }
        }
    }
}

stage('Static analysis') {
    steps {
        
    }
}
