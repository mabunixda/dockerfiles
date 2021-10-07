
def buildTargets


pipeline {
  agent any
  options {
        ansiColor('xterm')
  }
  parameters {
    booleanParam(name: 'fullBuild', defaultValue: false, description: 'run all builds')
  }
    stages {

    stage('prepare') {
        stage("fullbuild"){
            steps {
            when {
                equals expected: true, actual: params.fullBuild
            }
            sh '''
            echo "$(find . -iname '*Dockerfile' | sed 's|./||' | sort) )" > targets
            '''
            }
        }
        stage("incremental") {
            steps {
            when {
                not { equals expected: true, actual: params.fullBuild }
            }
            sh '''
            echo "" > targets
            for d in $(for f in $(git diff-tree --no-commit-id --name-only -r $BITBUCKET_COMMIT); do echo $(dirname $f); done | sort | uniq ); do
                if [ -f "${d}/Dockerfile" ]; then
                    echo "${d}/Dockerfile" >> targets
                fi
            done
            '''
            }
        }
        stage("targets") {
            steps {
                script {
                    def file = readFile('targets')
                    buildTargets = file.readLines()
                }
            }
        }
    }



    stage('build') {
        steps {
            script {
                buildTargets.eachLine {
                    def stepName = it.replaceFirst(~/\.[^\.]+$/, '')
                    stage("${stepName}") {
                        sh "build_all.sh dofile ${it}"
                    }
                }
            }
        }
    }
  }
}
