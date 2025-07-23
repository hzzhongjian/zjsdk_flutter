//
//  ZJContentAdPlatformView.h
//  ios_zjsdk_flutter_plugin
//
//  Created by 麻明康 on 2025/7/18.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJContentAdPlatformView : NSObject <FlutterPlatformView>

@end


@interface ZJContentAdPlatformViewFactory : NSObject <FlutterPlatformViewFactory>

- (instancetype)initWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar;

@end

NS_ASSUME_NONNULL_END
