#
# Be sure to run `pod lib lint UITestUtils.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'UITestUtils'
  s.version          = '1.0.1'
  s.summary          = 'Utility support write UI Testing in iOS'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/nvduc2910/UITestUtils'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'nvduc2910' => 'v.ducnv29@vinid.net' }
  s.source           = { :git => 'https://github.com/nvduc2910/UITestUtils.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '12.1'

  s.source_files = 'UITestUtils/Classes/**/*'
  
  # s.resource_bundles = {
  #   'UITestUtils' => ['UITestUtils/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  
  s.framework = "XCTest"
  s.requires_arc = true
  s.user_target_xcconfig = { 'FRAMEWORK_SEARCH_PATHS' => '$(PLATFORM_DIR)/Developer/Library/Frameworks' }
  s.pod_target_xcconfig = {
    'APPLICATION_EXTENSION_API_ONLY' => 'YES',
    'ENABLE_BITCODE' => 'NO',
    'OTHER_LDFLAGS' => '$(inherited) -Xlinker -no_application_extension',
  }
  
  s.cocoapods_version = '>= 1.4.0'
  if s.respond_to?(:swift_versions) then
    s.swift_versions = ['4.2', '5.0']
  else
    s.swift_version = '4.2'
  end
  
  s.dependency 'Embassy', '~> 4.1.1'
  s.dependency 'EnvoyAmbassador', '~> 4.0.5'
  s.dependency 'ObjectMapper', '~> 3.5.2'
  s.dependency 'Then', '~> 2.6.0'
end
