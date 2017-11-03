platform :ios, '9.0'

target 'DynamicTypeShowcase' do
  use_frameworks!

  pod 'KUIPopOver'
  pod 'TGPControls'
  pod 'SwiftLint'

  target 'DynamicTypeShowcaseTests' do
    inherit! :search_paths
  end

  target 'DynamicTypeShowcaseUITests' do
    inherit! :search_paths
  end
end

post_install do |_installer|
  require 'fileutils'
  FileUtils.cp_r(
    'Pods/Target Support Files/Pods-DynamicTypeShowcase/Pods-DynamicTypeShowcase-acknowledgements.plist',
    'DynamicTypeShowcase/Settings.bundle/Pods-acknowledgements.plist',
    remove_destination: true
  )
end
