
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
                vaultKey: 'username'
              ],
              [
                envVar: 'DOCKER_TOKEN',
                vaultKey: 'API Token'
              ]
            //,
            //   [
            //     envVar: 'MONDOO_CONFIG',
            //     vaultKey: 'mondoo'
            //   ]
            ]
        ]
]

def configuration = [vaultUrl: 'https://vault.home.nitram.at:8200',
                         vaultCredentialId: 'vault_jenkins',
                         engineVersion: 2]

pipeline {
    agent {
        kubernetes {
            inheritFrom 'default'
            defaultContainer 'build'
            yaml '''
---
metadata:
  labels:
    job-name: cicd_application
spec:
  containers:
    - name: build
      image: mabunixda/jenkins-slave:go
      imagePullPolicy: Always
      command:
        - sleep
      args:
        - 99d      
      tty: true
      env:
      - name: DOCKER_HOST
        value: tcp://buildkit-buildkit-service.automation.svc:1234
      - name: DOCKER_TLS_VERIFY
        value: 1
      securityContext:
        privileged: true
        '''
        }
    }
    options {
        ansiColor('xterm')
    }
    parameters {
        booleanParam(name: 'fullBuild', defaultValue: false, description: 'run through all available images')
    }
    stages {
        stage('analyze') {
            steps {
                sh '''
            echo "$(find . -iname '*Dockerfile' | sed 's|./||' | sort) )" > targets
            '''

                sh '''
            git config --global --add safe.directory $WORKSPACE
            touch inctargets
            COMMIT_ID=$(git rev-parse HEAD)
            for d in $(for f in $(git diff-tree --no-commit-id --name-only -r $COMMIT_ID); do echo $(dirname $f); done | sort | uniq ); do
                if [ -f "$d/Dockerfile" ]; then
                    echo  "$d/Dockerfile" >> inctargets
                fi
            done
            '''

                script {
                    filename = 'inctargets'
                    if (params.fullBuild) {
                        filename = 'targets'
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
                    # docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
                    # docker buildx rm multi
                    docker login -u "$DOCKER_USER" --password "$DOCKER_TOKEN"
                    docker buildx create --use --driver=remote tcp://buildkit-buildkit-service.automation.svc:1234
                    '''
                }
            }
        }
        stage('build') {
            steps {
                script {
                    if (buildTargets.size() == 0) {
                        currentBuild.result = 'SUCCESS'
                } else {
                        parallel parallelStagesMap
                    }
                }
            }
        }
    }
}

