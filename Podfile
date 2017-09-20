# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'FBook' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  pod 'SwiftLint', '0.22.0'
  pod 'Moya', '8.0.5'
  pod 'TPKeyboardAvoiding', '1.3.1'
  pod 'Kingfisher', '3.12.1'
  pod 'SVProgressHUD', '2.1.2'
  pod 'ObjectMapper', '2.2.8'
  pod 'Fabric', '1.6.12'
  pod 'Crashlytics', '3.8.5'
  pod 'FirebaseMessaging', '2.0.2'
  pod 'FBSDKCoreKit', '4.26.0'
  pod 'FBSDKLoginKit', '4.26.0'
  pod 'ReactiveCocoa', '6.0.1'
  pod 'RxSwift', '3.6.1'
  pod 'RxCocoa', '3.6.1'
  pod 'SwiftHEXColors'
  pod 'Cosmos', '~> 11.0'

  # Pods for FBook

  target 'FBookTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'FBookUITests' do
    inherit! :search_paths
    # Pods for testing
  end

  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '3.2'
      end
    end
  end

end
