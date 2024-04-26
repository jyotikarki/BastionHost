pipeline {
    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION    = credentials('AWS_DEFAULT_REGION')
    }

    agent any

    stages {
        stage('checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/jyotikarki/BastionHost.git'
            }
        }

        stage('Plan') {
            steps {
                script {
                    withEnv(['PATH+EXTRA=/usr/bin/']) {
                        sh """
                            terraform init -input=false
                            terraform plan -input=false -out tfplan 
                        """
                    }
                }
            }
        }

        stage('User Input') {
            steps {
                script {
                    def action = input(
                        message: 'Select action:',
                        parameters: [
                            choice(
                                name: 'Action',
                                choices: ['Apply', 'Destroy'],
                                description: 'Choose to apply or destroy infrastructure'
                            )
                        ]
                    )

                    // Store the selected action in an environment variable for later stages
                    env.ACTION = action
                }
            }
        } // Added the missing closing curly brace here

        stage('Apply or Destroy') {
            when {
                expression {
                    return env.ACTION == 'Apply' || env.ACTION == 'Destroy'
                }
            }
            steps {
                script {
                    withEnv(['PATH+EXTRA=/usr/bin/']) {
                        if (env.ACTION == 'Apply') {
                            sh "terraform apply -input=false tfplan"
                        } else if (env.ACTION == 'Destroy') {
                            sh "terraform destroy -auto-approve tfplan"
                        }
                    }
                }
            }
        }
    }
}