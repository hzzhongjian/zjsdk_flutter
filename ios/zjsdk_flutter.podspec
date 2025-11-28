#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint zjsdk_flutter.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'zjsdk_flutter'
  s.version          = '0.2.3'
  s.summary          = 'zjsdk ads flutter plugin package.'
  s.description      = <<-DESC
A new Flutter plugin project.
                       DESC
  s.homepage         = 'https://github.com/hzzhongjian/zjsdk_flutter.git'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'hzzhongjian' => 'opentwo@hzzhongjian.cn' }
  s.source           = { :git => 'https://github.com/hzzhongjian/zjsdk_flutter.git', :tag => s.version.to_s }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.platform = :ios, '11.0'
  s.static_framework = true
  
  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386,arm64' }

  # If your plugin requires a privacy manifest, for example if it uses any
  # required reason APIs, update the PrivacyInfo.xcprivacy file to describe your
  # plugin's privacy impact, and then uncomment this line. For more information,
  # see https://developer.apple.com/documentation/bundleresources/privacy_manifest_files
  # s.resource_bundles = {'zjsdk_flutter_privacy' => ['Resources/PrivacyInfo.xcprivacy']}

  # 对接广告需要引入的依赖
  s.dependency 'ZJSDK'

  # s.dependency 'ZJSDK/ZJSDKModuleCSJPlayletSDK'
  # s.dependency 'TTSDKFramework/Player-SR', '1.42.3.4-premium'
  # s.dependency 'PangrowthX/shortplay', '2.8.0.0'

end
