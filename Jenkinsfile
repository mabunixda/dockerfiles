
def buildTargets
def parallelStagesMap
def generateStage(job) {
    return {
        stage("${job}") {
            sh "./build_all.sh dofile ${job}"
        }
    }
}

pipeline {
  agent any
  options {
        ansiColor('xterm')
  }
  parameters {
    booleanParam(name: 'fullBuild', defaultValue: false, description: 'run through all available images')
  }
  stages {

    stage('analyze') {
        stage("fullbuild") {
            when {
                equals expected: true, actual: params.fullBuild
            }
            steps {
                sh '''
                echo "$(find . -iname '*Dockerfile' | sed 's|./||' | sort) )" > targets
                '''
                script {
                    def file = readFile('targets')
                    buildTargets = file.readLines()
                }
            }

        }
        stage('changes') {
            when {
                equals expected: true, actual: buildTargets.isEmpty()​​
            }
            steps {
                sh '''
                echo "" > targets
                for d in $(for f in $(git diff-tree --no-commit-id --name-only -r $BITBUCKET_COMMIT); do echo $(dirname $f); done | sort | uniq ); do
                    if [ -f "${d}/Dockerfile" ]; then
                        echo  "${d}/Dockerfile" > targets
                    fi
                done
                '''
                script {
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
                sh 'docker login '
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

