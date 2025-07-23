//
//  ZJBannerAdPlatformView.h
//  ios_zjsdk_flutter_plugin
//
//  Created by 麻明康 on 2025/7/17.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>


NS_ASSUME_NONNULL_BEGIN

@interface ZJBannerAdPlatformView : NSObject <FlutterPlatformView>

@end


@interface ZJBannerAdPlatformViewFactory : NSObject <FlutterPlatformViewFactory>

- (instancetype)initWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar;

@end

NS_ASSUME_NONNULL_END

