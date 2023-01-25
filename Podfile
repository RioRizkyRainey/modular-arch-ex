# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

workspace "Modular-Arch.xcworkspace"

target 'Modular-Arch' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Modular-Arch

end

target 'Store' do
  def main_dependencies
    pod 'RxSwift', '6.5.0'
    pod 'RxCocoa', '6.5.0'
    pod 'UIKitExtension', :path => "Libraries/UIKitExtension/.module.podspec"
    pod 'DomainStore', :path => "Domains/DomainStore/.module.podspec"
  end

  project "Features/Store/Store.xcodeproj"

  main_dependencies
end

target 'DomainStore' do
  def main_dependencies
    pod 'HttpHandler', :path => "Libraries/HttpHandler/.module.podspec"
  end

  project "Domains/DomainStore/DomainStore.xcodeproj"

  main_dependencies
end

target 'FeatureLivestream-Demo' do
  def main_dependencies
    pod 'FeatureLivestream', :path => "Features/FeatureLivestream/.module.podspec"
    pod 'FeatureLogin', :path => "Features/FeatureLogin/.module.podspec"
  end

  project "Domains/DomainStore/DomainStore.xcodeproj"

  main_dependencies
end

target 'UIKitExtension' do
  project "Libraries/UIKitExtension/UIKitExtension.xcodeproj"

  def main_dependencies
    pod 'SDWebImage'
  end

  main_dependencies
end

target 'HttpHandler' do
  project "Libraries/HttpHandler/HttpHandler.xcodeproj"

  def main_dependencies
  end

  main_dependencies
end

target 'Router' do
  project "Libraries/Router/Router.xcodeproj"

  def main_dependencies
    pod 'Hero'
  end

  main_dependencies
end
