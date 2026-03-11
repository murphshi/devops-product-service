pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh 'npm ci'
            }
        }

        stage('Test') {
            steps {
                sh 'npx jest --passWithNoTests'
            }
        }

        stage('Security Scan') {
            steps {
                echo 'Static analysis placeholder for product-service'
            }
        }

        stage('Container Build') {
            steps {
                script {
                    env.IMAGE_TAG = "build-${env.BUILD_NUMBER}"
                    sh "docker build -t product-service:${env.IMAGE_TAG} ."
                }
            }
        }

        stage('Build Environment Validation') {
            when {
                expression {
                    return !(env.GIT_BRANCH?.contains('develop') ||
                             env.GIT_BRANCH?.contains('release/') ||
                             env.GIT_BRANCH?.contains('main'))
                }
            }
            steps {
                echo "Build pipeline executed for feature branch or pull request validation on ${env.GIT_BRANCH}"
                echo "Image tag prepared: ${env.IMAGE_TAG}"
            }
        }

        stage('Deploy to Dev') {
            when {
                expression {
                    return env.GIT_BRANCH?.contains('develop')
                }
            }
            steps {
                echo "Deploying product-service to dev environment from ${env.GIT_BRANCH}"
                sh 'bash /Users/shidonglizhen/Desktop/mpcs-devops/devops-k8s/product-service/render-deployment.sh ${IMAGE_TAG}'
                echo "Kubernetes deployment rendered with image tag ${env.IMAGE_TAG}"
            }
        }

        stage('Deploy to Staging') {
            when {
                expression {
                    return env.GIT_BRANCH?.contains('release/')
                }
            }
            steps {
                echo "Deploying product-service to staging environment from ${env.GIT_BRANCH}"
                sh 'bash /Users/shidonglizhen/Desktop/mpcs-devops/devops-k8s/product-service/render-deployment.sh ${IMAGE_TAG}'
                echo "Kubernetes deployment rendered with image tag ${env.IMAGE_TAG}"
            }
        }

        stage('Prod Approval') {
            when {
                expression {
                    return env.GIT_BRANCH?.contains('main')
                }
            }
            steps {
                input message: 'Approve deployment to production?', ok: 'Deploy'
            }
        }

        stage('Deploy to Prod') {
            when {
                expression {
                    return env.GIT_BRANCH?.contains('main')
                }
            }
            steps {
                echo "Deploying product-service to production environment from ${env.GIT_BRANCH}"
                sh 'bash /Users/shidonglizhen/Desktop/mpcs-devops/devops-k8s/product-service/render-deployment.sh ${IMAGE_TAG}'
                echo "Kubernetes deployment rendered with image tag ${env.IMAGE_TAG}"
            }
        }
    }
}
