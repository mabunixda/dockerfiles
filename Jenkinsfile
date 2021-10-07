
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

    // stage('build') {
    //     steps {
    //         script {
    //             buildTargets.eachLine {
    //                 def stepName = it.replaceFirst(~/\.[^\.]+$/, '')
    //                 stage("${stepName}") {
    //                     steps {
    //                         sh "build_all.sh dofile ${it}"
    //                     }
    //                 }
    //             }
    //         }
    //     }
    // }
  }
}
