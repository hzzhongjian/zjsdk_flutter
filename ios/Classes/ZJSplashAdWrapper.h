//
//  ZJAdWrapper.h
//  ZJSDK_flutter_demo
//
//  Created by Rare on 2021/3/25.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface ZJSplashAdWrapper : NSObject

//加载开屏广告
- (void)loadSplashAdWithAdId:(NSString *)adId fetchDelay:(CGFloat)fetchDelay;

- (void)showSplashAdInWindow:(UIWindow *)window;

//开屏加载成功回调
@property (nonatomic,copy)void(^splashAdDidLoad)(void);

//开屏广告成功展示回调
@property (nonatomic,copy)void(^splashAdSuccessPresentScreen)(void);

//开屏广告点击回调
@property (nonatomic,copy)void(^splashAdClicked)(void);

//开屏广告将要关闭回调
@property (nonatomic,copy)void(^splashAdWillClosed)(void);

//开屏广告关闭回调
@property (nonatomic,copy)void(^splashAdClosed)(void);

//应用进入后台时回调 详解: 当点击下载应用时会调用系统程序打开，应用切换到后台
@property (nonatomic,copy)void(^splashAdApplicationWillEnterBackground)(void);

//开屏广告倒记时结束回调
@property (nonatomic,copy)void(^splashAdCountdownEnd)(void);

//开屏广告错误回调
@property (nonatomic,copy)void(^splashAdError)(NSError *error);

//开屏广告播放错误
@property (nonatomic,copy)void(^splashAdDisplayError)(NSError *error);

/// 开屏广告落地页打开 -- 部分联盟有回调
@property (nonatomic, copy) void (^splashAdDetailViewShow)(void);

/// 开屏广告落地页关闭 -- 部分联盟有回调
@property (nonatomic, copy) void (^splashAdDetailViewClose)(void);


@end

NS_ASSUME_NONNULL_END
