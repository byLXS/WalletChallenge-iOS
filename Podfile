platform :ios, '11.0'

use_frameworks!

workspace 'WalletChallenge-iOS'

#core module
def core_pods
    pod 'Kingfisher'
end
 
target 'WalletCore' do
   project 'WalletCore/WalletCore.project'
  core_pods
end

#application module
def application_pods
end
 
target 'WalletChallengeApp' do
   project 'WalletChallengeApp/WalletChallengeApp.project'
   application_pods
   core_pods
end
