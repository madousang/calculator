pipeline {
    agent { label 'node1' }
    stages {
        stage("Compile") {
            steps {
                echo "Compilation..."
                sh "./gradlew compileJava"
            }
        }
        stage("Unit test") {
            steps {
                echo "Unit test..."
                 sh "./gradlew test"
            }
        }
    }
}