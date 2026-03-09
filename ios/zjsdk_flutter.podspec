#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint zjsdk_flutter.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'zjsdk_flutter'
  s.version          = '0.2.6'
  s.summary          = 'zjsdk ads flutter plugin package.'
  s.description      = <<-DESC
A new Flutter plugin project.
                       DESC
  s.homepage         = 'https://github.com/hzzhongjian/zjsdk_flutter.git'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'hzzhongjian' => 'opentwo@hzzhongjian.cn' }
  s.source           = { :git => 'https://github.com/hzzhongjian/zjsdk_flutter.git', :tag => s.version.to_s  }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '11.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
    # 对接广告需要引入的依赖
  s.dependency 'ZJSDK'

#        ss.dependency 'Ads-CN/CSJMediation-Only'
#        ss.dependency 'Ads-CN/BUAdLive'
#        ss.dependency 'TTSDKFramework/Player-SR', '1.46.2.7-premium'
#        ss.dependency 'TTSDKFramework/LivePull', '1.46.2.7-premium'
#        ss.dependency 'PangrowthX/shortplay', '2.9.0.5'
end
