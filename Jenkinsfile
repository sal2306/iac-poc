pipeline {
    agent any
    environment {
        S3_BUCKET             = 'zantac-terraform-state-bucket'
        STATE_FILE_NAME       = 'terraform.tfstate'
    }

    stages {
        stage('Checkout Terraform') {
            steps {
                dir('/terraform') {
                    git 'https://github.com/sali2306/POC.git'
                }
            }
        }

        stage('Checkout Terraform state file') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'aws-credentials', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    sh "aws s3 cp s3://${S3_BUCKET}/${STATE_FILE_NAME} ./${STATE_FILE_NAME}"
                }
            }
        }    

        stage('Terraform Apply') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'aws-credentials', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    dir('/terraform') {
                        script {
                            // Replace with your Terraform installation path
                            def tfHome = tool name: 'Terraform', type: 'hudson.plugins.terraform.TerraformInstallation'
                            env.PATH = "${tfHome}:${env.PATH}"
                            // Run Terraform commands
                            sh 'terraform init -backend-config="bucket=zantac-terraform-state-bucket" -backend-config="key=terraform.tfstate" -backend-config="region=us-east-1"'
                            sh 'terraform plan -out=tfplan'
                            sh 'terraform apply -auto-approve tfplan'
                        }
                    }  
                }
            }
        }

        stage('Checkout Ansible') {
            steps {
                dir('/ansible') {
                    git 'https://github.com/sali2306/POC.git'
                }
            }
        }

        stage('Deploy with Ansible') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'web-server-credentials', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) { 
                    dir('/ansible') {
                        script {
                            // Replace with your Ansible installation path
                            def ansibleHome = tool name: 'Ansible', type: 'hudson.plugins.ansible.AnsibleInstallation'
                            env.PATH = "${ansibleHome}:${env.PATH}"

                            // Run Ansible playbook
                            sh 'ansible-playbook -i terraform.tfstate web_server.yml'
                        }
                    }
                }
            }
        }
    }
}
