
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
              ],
              [
                envVar: 'MONDOO_CONFIG',
                vaultKey: 'mondoo'
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

            sh '''
            touch inctargets
            COMMIT_ID=$(git rev-parse HEAD)
            for d in $(for f in $(git diff-tree --no-commit-id --name-only -r $COMMIT_ID); do echo $(dirname $f); done | sort | uniq ); do
                if [ -f "$d/Dockerfile" ]; then
                    echo  "$d/Dockerfile" >> inctargets
                fi
            done
            '''

            script {
                filename = "inctargets"
                if( params.fullBuild) {
                    filename = "targets"
                }
                def file = readFile(filename)
                buildTargets = file.readLines()
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
                sh '''
                docker login -u "$DOCKER_USER" --password "$DOCKER_TOKEN"
                docker buildx inspect multi && exit 0 || echo "creating multi builder..."
                docker buildx create --name multi --platform linux/amd64,linux/arm/v7,linux/arm64
                echo "$MONDOO_CONFIG" | base64 -d > $HOME/mondoo.json
                '''
            }
        }
    }
    stage('build') {
        steps {
            script {
                if ( buildTargets.size() == 0 ) {
                    currentBuild.result = 'SUCCESS'
                } else {
                    parallel parallelStagesMap
                }
            }
        }
    }
  }
}

