
def buildTargets = []
def parallelStagesMap
def generateStage(job) {
    return {
        stage("${job}") {
            sh "./build_all.sh dofile ${job}"
        }
    }
}

def secrets = [
        [ path: 'kv/jenkins/docker',
          engineVersion: 2,
          secretValues: [
              [
                envVar: 'DOCKER_USER',
                vaultKey: 'docker_user'
              ],
              [
                envVar: 'DOCKER_TOKEN',
                vaultKey: 'docker_pass'
              ]

            ]
        ]
]

def configuration = [vaultUrl: 'https://vault.home.nitram.at:8200',
                         vaultCredentialId: 'vault_jenkins',
                         engineVersion: 2]

pipeline {
  agent any
  options {
        ansiColor('xterm')
  }
  parameters {
    booleanParam(name: 'fullBuild', defaultValue: false, description: 'run through all available images')
  }
  stages {

    stage("analyze") {
        steps {
            sh '''
            echo "$(find . -iname '*Dockerfile' | sed 's|./||' | sort) )" > targets
            '''
            script {
                if( params.fullBuild ) {
                    def file = readFile('targets')
                    buildTargets = file.readLines()
                }
            }

            sh '''
            echo "" > targets
            COMMIT_ID=$(git rev-parse HEAD)
            for d in $(for f in $(git diff-tree --no-commit-id --name-only -r $COMMIT_ID); do echo $(dirname $f); done | sort | uniq ); do
                if [ -f "$d/Dockerfile" ]; then
                    echo  "$d/Dockerfile" >> targets
                fi
            done
            '''
            script {
                if( params.fullBuild == false​​ ) {
                    def file = readFile('targets')
                    buildTargets = file.readLines()
                }
            }
        }
    }

    stage('prepare') {
        steps {
            script {
                parallelStagesMap = buildTargets.collectEntries {
                        ["${it}" : generateStage(it)]
                }
            }
            withVault([configuration: configuration, vaultSecrets: secrets]) {
                sh 'echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin'
            }
        }
    }
    stage('build') {
            steps {
                script {
                    parallel parallelStagesMap
                }
            }
        }

  }
}

