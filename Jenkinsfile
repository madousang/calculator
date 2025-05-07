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
        stage("Package") {
            steps {
                echo "Packaging..."
                sh "./gradlew build"
            }
        }
        stage("Docker build") {
            steps {
                echo "Docker build..."
                sh "docker-compose build -t madou0178/calculator ."
            }
            post {
                failure {
                    echo "Docker build failed. Cleaning up..."
                }
            }
        }
        stage("Docker push") {
            steps {
                echo "Docker push image on Docker Hub..."
                sh "docker login"
                sh "docker-compose push madou0178/calculator"
            }
        }
        stage("Deploy to staging") {
            steps {
                echo "Deploy container Calculator App on test environment"
                sh "docker-compose up --build -d"
            }
        }
        stage("Acceptance test") {
            steps {
                echo "Exec Acceptance test"
                sleep 60
                sh "docker logs calculator"
                sh "./acceptance_test.sh"
            }
            post {
                always {
                    echo "Destroy container App Calculator"
                    sh "docker-compose down"
                }
            }
        }
    }
}