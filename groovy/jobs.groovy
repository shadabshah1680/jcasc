// theScript = new File('/var/jenkins_conf/test_pipeline.groovy').text
// pipelineJob('Test') {
//   definition {
//     cps {
//       script(theScript)
//       sandbox()
//     }
//   }
// }

    
// listView("SlackTest") {
//     jobs {
//         name('Test')
//     }
//     columns {
//         status()
//         weather()
//         name()
//         lastSuccess()
//         lastFailure()
//         lastDuration()
//       }
// }


// def githubUrl = "https://github.com/m-goos/jenkins-jobdsl-seedrepo-example.git"

// pipelineJob("Seed job 1") {
// definition {
//     cpsScm {
//         scm {
//             git{
//               remote {
//                 url("${githubUrl}")
//                 // credentials("${SSH_CREDENTIALS}")
//               }
//               branch("*/do-not-merge")
//             }
//         }
//     }
//   }
// }