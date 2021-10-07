
def buildTargets


pipeline {
  agent any
  options {
        ansiColor('xterm')
  }
  stages {

    stage('prepare') {
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

    stage('build') {
        steps {
            script {
                for(int i=0; i < buildTargets.size(); i++) {
                    def s = buildTargets[i]
                    // def stepName = String.replaceFirst(~/\.[^\.]+$/, '')
                    stage("${s}") {
                        sh "build_all.sh dofile ${s}"
                    }
                }
            }
        }
    }
  }
}

