
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
  stages {

    stage('analyze') {
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

    stage('prepare') {
        steps {
            script {
                parallelStagesMap = buildTargets.collectEntries {
                        ["${it}" : generateStage(it)]
                }
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

