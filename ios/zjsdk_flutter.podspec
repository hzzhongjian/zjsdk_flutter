#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint zjsdk_flutter.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'zjsdk_flutter'
  s.version          = '0.1.7'
  s.static_framework = true
  s.summary          = 'zjsdk ads flutter plusin package.'
  s.description      = <<-DESC
A new Flutter project.
                       DESC
  s.homepage         = 'https://github.com/hzzhongjian/zjsdk_flutter.git'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'hzzhongjian' => 'opentwo@hzzhongjian.cn' }
  s.source           = { :git => 'https://github.com/hzzhongjian/zjsdk_flutter.git', :tag => s.version.to_s }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'ZJSDK'
  s.platform = :ios, '11.0'
  s.static_framework = true

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386,arm64' }
end
