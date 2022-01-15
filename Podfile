# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

def tools 
  pod 'SwiftLint'
end

def common_pods
  pod 'Kingfisher'
  pod 'Moya'
end

def ui 
  pod 'VanillaConstraints'
  pod 'MBProgressHUD', '1.2.0'
  pod 'Reusable'
  pod 'ImageSlideshow', '~> 1.9.0'
  pod "ImageSlideshow/Kingfisher"
end

target 'Classie' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  tools
  common_pods
  ui

  target 'ClassieTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'ClassieUITests' do
    # Pods for testing
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
      config.build_settings['GCC_WARN_INHIBIT_ALL_WARNINGS'] = "YES"
    end
  end
end
