//
//  ZJAdWrapper.h
//  ZJSDK_flutter_demo
//
//  Created by Rare on 2021/3/25.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <ZJSDK/ZJSplashAd.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJSplashAdWrapper : NSObject

//加载开屏广告
- (void)loadSplashAdWithAdId:(NSString *)adId fetchDelay:(CGFloat)fetchDelay;

- (void)showSplashAdInWindow:(UIWindow *)window;

//开屏加载成功回调
@property (nonatomic,copy)void(^splashAdDidLoad)(NSDictionary *param);

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

/**
 * @brief 设置竞价价格，单位（分）
 * @param ecpm              竞价价格
 * @param highestLossEcpm   最大竞价失败方出价
 */
- (void)setBidEcpm:(NSInteger)ecpm
   highestLossEcpm:(NSInteger)highestLossEcpm;


/**
 * @brief 广告曝光失败后上报失败原因
 * @param failureCode 曝光失败原因类型
 * @param reportParam 曝光失败原因描述
 *        reportParam.winEcpm 胜出者的ecpm报价（单位：分）
 *        reportParam.adnType 胜出方，见ZJAdExposureReportParam.h 中ZJAdExposureAdnType定义
 *        reportParam.adnName 胜出平台名，见ZJAdExposureReportParam.h 中ZJAdADNType平台定义
 */
- (void)reportAdExposureFailed:(int)failureCode reportParam:(ZJAdExposureReportParam *)reportParam;

@end

NS_ASSUME_NONNULL_END
