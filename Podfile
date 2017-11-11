platform :ios, '9.0'

target 'DynamicTypeShowcase' do
  use_frameworks!

  pod 'KUIPopOver'
  pod 'TGPControls'
  pod 'Reusable'
  pod 'RxCocoa'
  pod 'RxSwift'
  pod 'SwiftLint'

  target 'DynamicTypeShowcaseTests' do
    inherit! :search_paths
  end

  target 'DynamicTypeShowcaseUITests' do
    inherit! :search_paths
  end
end

post_install do |installer|
  require 'fileutils'
  FileUtils.cp_r(
    'Pods/Target Support Files/Pods-DynamicTypeShowcase/Pods-DynamicTypeShowcase-acknowledgements.plist',
    'DynamicTypeShowcase/Settings.bundle/Pods-acknowledgements.plist',
    remove_destination: true
  )

  installer.pods_project.targets.each do |target|
    next unless target.name == 'RxSwift'
    target.build_configurations.each do |config|
      if config.name == 'Debug'
        config.build_settings['OTHER_SWIFT_FLAGS'] ||= ['-D', 'TRACE_RESOURCES']
      end
    end
  end
end
