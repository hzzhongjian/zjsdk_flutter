//
//  ZJRewardVideoAdWrapper.m
//  ZJSDK_flutter_demo
//
//  Created by Rare on 2021/3/26.
//

#import "ZJRewardVideoAdWrapper.h"
#import <ZJSDK/ZJSDK.h>

@interface ZJRewardVideoAdWrapper()<ZJRewardVideoAdDelegate>

@property (nonatomic,strong)ZJRewardVideoAd *rewardVideoAd;

@end

@implementation ZJRewardVideoAdWrapper

-(void)loadRewardVideoAdWithAdId:(NSString *)adId
                          userId:(NSString *)userId
                     reward_name:(NSString *)reward_name
                   reward_amount:(int)reward_amount
                           extra:(NSString *)extra{
    self.rewardVideoAd = [[ZJRewardVideoAd alloc]initWithPlacementId:adId userId:userId];
    if (reward_name && reward_name.length > 0) {
        self.rewardVideoAd.reward_name = reward_name;
    }
    if (reward_amount > 0) {
        self.rewardVideoAd.reward_amount = reward_amount;
    }
    if (extra && extra.length > 0) {
        self.rewardVideoAd.extra = extra;
    }
    self.rewardVideoAd.delegate = self;
    [self.rewardVideoAd loadAd];
}

-(void)showRewardVideoAdWithViewController:(UIViewController *)vc{
    [self.rewardVideoAd showAdInViewController:vc];
}
/**
广告数据加载成功回调

@param rewardedVideoAd ZJRewardVideoAd 实例
*/
- (void)zj_rewardVideoAdDidLoad:(ZJRewardVideoAd *)rewardedVideoAd{
    
}
/**
视频数据下载成功回调，已经下载过的视频会直接回调

@param rewardedVideoAd ZJRewardVideoAd 实例
*/
- (void)zj_rewardVideoAdVideoDidLoad:(ZJRewardVideoAd *)rewardedVideoAd{
    if (self.rewardVideoLoadSuccess) {
        NSDictionary *param = @{
            @"ecpm":@(rewardedVideoAd.eCPM)
        };
        self.rewardVideoLoadSuccess(param);
    }
    [self showRewardVideoAdWithViewController:[ZJCommon getCurrentVC]];
}

/**
 视频广告展示

 @param rewardedVideoAd ZJRewardVideoAd 实例
 */
- (void)zj_rewardVideoAdDidShow:(ZJRewardVideoAd *)rewardedVideoAd{
    if (self.rewardVideoAdDidShow) {
        self.rewardVideoAdDidShow();
    }
}

/**
 视频播放页关闭

 @param rewardedVideoAd ZJRewardVideoAd 实例
 */
- (void)zj_rewardVideoAdDidClose:(ZJRewardVideoAd *)rewardedVideoAd{
    if (self.rewardVideoAdDidClose) {
        self.rewardVideoAdDidClose();
    }
}

/**
 视频广告信息点击

 @param rewardedVideoAd ZJRewardVideoAd 实例
 */
- (void)zj_rewardVideoAdDidClicked:(ZJRewardVideoAd *)rewardedVideoAd{
    if (self.rewardVideoAdDidClicked) {
        self.rewardVideoAdDidClicked();
    }
}


//奖励触发
- (void)zj_rewardVideoAdDidRewardEffective:(ZJRewardVideoAd *)rewardedVideoAd{
    if (self.rewardVideoDidRewardEffective) {
        self.rewardVideoDidRewardEffective(rewardedVideoAd.trade_id,rewardedVideoAd.validationDictionary);
    }
}
/**
 视频广告视频播放完成

 @param rewardedVideoAd ZJRewardVideoAd 实例
 */
- (void)zj_rewardVideoAdDidPlayFinish:(ZJRewardVideoAd *)rewardedVideoAd{
    if (self.rewardVideoAdDidPlayFinish) {
        self.rewardVideoAdDidPlayFinish();
    }
}


/**
 视频广告各种错误信息回调

 @param rewardedVideoAd ZJRewardVideoAd 实例
 @param error 具体错误信息
 */
- (void)zj_rewardVideoAd:(ZJRewardVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error{
    if (self.rewardVideoAdError) {
        self.rewardVideoAdError(error);
    }
}

/**
 视频广告播放错误信息回调
 @param rewardedVideoAd ZJRewardVideoAd 实例
 @param error 具体错误信息
 */
- (void)zj_rewardVideoAd:(ZJRewardVideoAd *)rewardedVideoAd displayFailWithError:(NSError *)error
{
    if (self.rewardVideoAdError) {
        self.rewardVideoAdError(error);
    }
}

/**
 用户点击视频跳过按钮
 @param rewardedVideoAd ZJRewardVideoAd 实例
 */
- (void)zj_rewardVideoAdDidClickSkip:(ZJRewardVideoAd *)rewardedVideoAd
{
    if (self.rewardVideoAdDidClickSkip) {
        self.rewardVideoAdDidClickSkip();
    }
}

// 广告详情页关闭回调
- (void)zj_rewardVideoAdDidCloseOtherController:(ZJRewardVideoAd *)rewardedVideoAd
{
    if (self.rewardVideoAdDidCloseOtherController) {
        self.rewardVideoAdDidCloseOtherController();
    }
}


// 进入广告详情页回调
- (void)zj_rewardVideoAdDidPresentFullScreen:(ZJRewardVideoAd *)rewardedVideoAd
{
    if (self.rewardVideoAdDidPresentFullScreen) {
        self.rewardVideoAdDidPresentFullScreen();
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
    if (self.rewardVideoAd) {
        [self.rewardVideoAd setBidEcpm:ecpm highestLossEcpm:highestLossEcpm];
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
    if (self.rewardVideoAd) {
        [self.rewardVideoAd reportAdExposureFailed:failureCode reportParam:reportParam];
    }
}


@end
