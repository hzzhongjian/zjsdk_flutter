//
//  ZJFeedFullVideoPlatformView.h
//  ios_zjsdk_flutter_plugin
//
//  Created by 麻明康 on 2025/7/18.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJFeedFullVideoPlatformView : NSObject <FlutterPlatformView>

@end


@interface ZJFeedFullVideoPlatformViewFactory : NSObject <FlutterPlatformViewFactory>

- (instancetype)initWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar;

@end

NS_ASSUME_NONNULL_END
