//
//  ZJInterstitialAdWrapper.h
//  ZJSDK_flutter_demo
//
//  Created by Rare on 2021/4/6.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <ZJSDK/ZJInterstitialAd.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJInterstitialAdWrapper : NSObject

//加载插屏广告
-(void)loadInterstitialAdWithAdId:(NSString *)adId
                       mutedIfCan:(BOOL)mutedIfCan
                           adSize:(CGSize)adSize;
//展示
-(void)showInViewController:(UIViewController *)vc;

//插屏广告加载成功回调
@property (nonatomic,copy)void(^interstitialAdDidLoad)(NSDictionary *param);
//插屏广告错误
@property (nonatomic,copy)void(^interstitialAdError)(NSError *error);
//插屏广告点击
@property (nonatomic,copy)void(^interstitialAdDidClick)(void);
//插屏广告关闭
@property (nonatomic,copy)void(^interstitialAdDidClose)(void);
//插屏广告展示
@property (nonatomic,copy)void(^interstitialAdDidPresentScreen)(void);
//插屏广告关闭详情页
@property (nonatomic,copy)void(^interstitialAdDetailDidClose)(void);
//插屏广告打开详情页
@property (nonatomic,copy)void(^interstitialAdDetailDidPresentFullScreen)(void);

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
