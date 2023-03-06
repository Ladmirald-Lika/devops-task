pipeline {
  agent {
    kubernetes {
      // Specify the Kubernetes namespace where the build will run
      namespace 'default'

      // Use a Kubernetes pod template with a Maven image
      yaml """
        apiVersion: v1
        kind: Pod
        metadata:
          labels:
            app: maven
        spec:
          containers:
            - name: maven
              image: maven:3.8-jdk-11
              command:
                - sleep
                - infinity
      """
    }
  }

  stages {
    stage('Build') {
      steps {
        // Use Maven to build the Java application
        container('maven') {
          sh 'mvn clean package'
        }
      }
    }

    stage('Deploy') {
      steps {
        // Use kubectl to apply the Kubernetes manifest file for the application
        container('maven') {
          sh 'kubectl apply -f deployment.yaml'
        }
      }
    }
  }
}
