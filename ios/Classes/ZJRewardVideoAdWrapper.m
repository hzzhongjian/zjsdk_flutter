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
-(void)loadRewardVideoAdWithAdId:(NSString *)adId userId:(NSString *)userId{
    self.rewardVideoAd = [[ZJRewardVideoAd alloc]initWithPlacementId:adId userId:userId];
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
        self.rewardVideoLoadSuccess();
    }
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
@end
