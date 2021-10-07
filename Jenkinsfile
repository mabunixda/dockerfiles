def generateStage(jobName, job) {
    return {
        stage("${jobName}") {
             sh './build_all.sh dofile ${job}'
        }
    }
}


 pipeline {
  agent any
  options {
        ansiColor('xterm')
  }
  parameters {
    booleanParam(name: 'fullBuild', defaultValue: false, description: 'run all builds')
  }
  def buildTargets
  stage('prepare') {

    steps {
      when {
        equals expected: true, actual: params.fullBuild
      }
      sh '''
      echo "$(find . -iname '*Dockerfile' | sed 's|./||' | sort) )" > targets
      '''
      script {
        buildTargets = readFile('targets')
      }
    }
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
      script {
        buildTargets = readFile('targets')
      }
    }
  }



  stage('build') {
    stepsForParallel = [:]
    for (int i = 0; i < buildTargets.size(); i++) {
      def s = buildTargets.get(i)
      def stepName = s.replaceFirst(~/\.[^\.]+$/, '')
      stepsForParallel[stepName] = generateStage(stepName, s)
    }
    stepsForParallel['failFast'] = false
    parallel stepsForParallel
  }
}
