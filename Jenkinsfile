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
        stage("Code coverage") {
            steps {
                echo "Code coverage..."
                sh "./gradlew jacocoTestReport"
                publishHTML (target: [
                reportDir: 'build/reports/jacoco/test/html',
                reportFiles: 'index.html',
                reportName: "JaCoCo Report"
                ])
                sh "./gradlew jacocoTestCoverageVerification"
            }
        }
        stage("Static code analysis") {
            steps {
                echo "Static code analysis..."
                sh "./gradlew checkstyleMain"
                publishHTML (target: [
                 reportDir: 'build/reports/checkstyle/',
                 reportFiles: 'main.html',
                 reportName: "Checkstyle Report"
                ])
            }
        }
    }
}