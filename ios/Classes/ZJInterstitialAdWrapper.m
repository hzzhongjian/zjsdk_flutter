//
//  ZJInterstitialAdWrapper.m
//  ZJSDK_flutter_demo
//
//  Created by Rare on 2021/4/6.
//

#import "ZJInterstitialAdWrapper.h"
#import <ZJSDK/ZJSDK.h>
@interface ZJInterstitialAdWrapper()<ZJInterstitialAdDelegate>
@property (nonatomic,strong)ZJInterstitialAd *interstitialAd;
@end

@implementation ZJInterstitialAdWrapper

-(void)loadInterstitialAdWithAdId:(NSString *)adId
                       mutedIfCan:(BOOL)mutedIfCan
                           adSize:(CGSize)adSize
{
    self.interstitialAd = [[ZJInterstitialAd alloc]initWithPlacementId:adId];
    self.interstitialAd.delegate = self;
    self.interstitialAd.mutedIfCan = mutedIfCan;
    if (!CGSizeEqualToSize(adSize, CGSizeZero)) {
        self.interstitialAd.adSize = adSize;
    }
    self.interstitialAd.adSize = adSize;
    [self.interstitialAd loadAd];
}

-(void)showInViewController:(UIViewController *)vc{
    [self.interstitialAd presentAdFromRootViewController:vc];
}

- (void)zj_interstitialAdDidLoad:(ZJInterstitialAd*) ad{
    if (self.interstitialAdDidLoad) {
        NSDictionary *param = @{
            @"ecpm":@(ad.eCPM)
        };
        self.interstitialAdDidLoad(param);
    }
    [self showInViewController:[ZJCommon getCurrentVC]];
}

- (void)zj_interstitialAdDidLoadFail:(ZJInterstitialAd*) ad error:(NSError * __nullable)error{
    if (self.interstitialAdError) {
        self.interstitialAdError(error);
    }
}

- (void)zj_interstitialAdDidPresentScreen:(ZJInterstitialAd*) ad{
    if (self.interstitialAdDidPresentScreen) {
        self.interstitialAdDidPresentScreen();
    }
}

- (void)zj_interstitialAdDidClick:(ZJInterstitialAd*) ad{
    if (self.interstitialAdDidClick) {
        self.interstitialAdDidClick();
    }
}

- (void)zj_interstitialAdDidClose:(ZJInterstitialAd*) ad{
    if (self.interstitialAdDidClose) {
        self.interstitialAdDidClose();
    }
}

- (void)zj_interstitialAdDetailDidClose:(ZJInterstitialAd*) ad{
    if (self.interstitialAdDetailDidClose) {
        self.interstitialAdDetailDidClose();
    }
}

- (void)zj_interstitialAdDidFail:(ZJInterstitialAd*) ad error:(NSError * __nullable)error{
    if (self.interstitialAdError) {
        self.interstitialAdError(error);
    }
}

///插屏广告详情页展示回调
- (void)zj_interstitialAdDetailDidPresentFullScreen:(ZJInterstitialAd*)ad
{
    if (self.interstitialAdDetailDidPresentFullScreen) {
        self.interstitialAdDetailDidPresentFullScreen();
    }
}

/**
 * @brief 设置竞价价格，单位（分）
 * @param ecpm              竞价价格
 * @param highestLossEcpm   最大竞价失败方出价
 */
- (void)setBidEcpm:(NSInteger)ecpm
   highestLossEcpm:(NSInteger)highestLossEcpm
{
    if (self.interstitialAd) {
        [self.interstitialAd setBidEcpm:ecpm highestLossEcpm:highestLossEcpm];
    }
}


/**
 * @brief 广告曝光失败后上报失败原因
 * @param failureCode 曝光失败原因类型
 * @param reportParam 曝光失败原因描述
 *        reportParam.winEcpm 胜出者的ecpm报价（单位：分）
 *        reportParam.adnType 胜出方，见ZJAdExposureReportParam.h 中ZJAdExposureAdnType定义
 *        reportParam.adnName 胜出平台名，见ZJAdExposureReportParam.h 中ZJAdADNType平台定义
 */
- (void)reportAdExposureFailed:(int)failureCode reportParam:(ZJAdExposureReportParam *)reportParam
{
    if (self.interstitialAd) {
        [self.interstitialAd reportAdExposureFailed:failureCode reportParam:reportParam];
    }
}

@end
