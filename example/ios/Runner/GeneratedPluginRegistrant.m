//
//  Generated file. Do not edit.
//

// clang-format off

#import "GeneratedPluginRegistrant.h"

#if __has_include(<integration_test/IntegrationTestPlugin.h>)
#import <integration_test/IntegrationTestPlugin.h>
#else
@import integration_test;
#endif

#if __has_include(<zjsdk_flutter/ZjsdkFlutterPlugin.h>)
#import <zjsdk_flutter/ZjsdkFlutterPlugin.h>
#else
@import zjsdk_flutter;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [IntegrationTestPlugin registerWithRegistrar:[registry registrarForPlugin:@"IntegrationTestPlugin"]];
  [ZjsdkFlutterPlugin registerWithRegistrar:[registry registrarForPlugin:@"ZjsdkFlutterPlugin"]];
}

@end
