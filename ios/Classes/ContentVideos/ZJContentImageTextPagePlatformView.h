//
//  ZJContentImageTextPagePlatformView.h
//  zjsdk_flutter
//
//  Created by 麻明康 on 2023/2/17.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>
#import <ZJSDK/ZJImageTextPage.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJContentImageTextPagePlatformView : NSObject<FlutterPlatformView,ZJContentPageHorizontalFeedCallBackDelegate,ZJImageTextDetailDelegate>

@end
@interface ZJContentImageTextPagePlatformViewFactory : NSObject<FlutterPlatformViewFactory>
- (instancetype)initWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar;
@end
NS_ASSUME_NONNULL_END