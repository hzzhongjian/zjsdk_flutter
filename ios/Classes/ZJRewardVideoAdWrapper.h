//
//  ZJRewardVideoAdWrapper.h
//  ZJSDK_flutter_demo
//
//  Created by Rare on 2021/3/26.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <ZJSDK/ZJRewardVideoAd.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJRewardVideoAdWrapper : NSObject

//加载激励视频广告
-(void)loadRewardVideoAdWithAdId:(NSString *)adId 
                          userId:(NSString *)userId
                     reward_name:(NSString *)reward_name
                   reward_amount:(int)reward_amount
                           extra:(NSString *)extra;

//显示激励视频广告对对应的控制器上
-(void)showRewardVideoAdWithViewController:(UIViewController *)vc;


//激励视频加载成功回调
@property (nonatomic,copy)void(^rewardVideoLoadSuccess)(NSDictionary *param);
//视频广告展示
@property (nonatomic,copy)void(^rewardVideoAdDidShow)(void);
//视频播放页关闭
@property (nonatomic,copy)void(^rewardVideoAdDidClose)(void);
//视频广告信息点击
@property (nonatomic,copy)void(^rewardVideoAdDidClicked)(void);
//视频广告视频播放完成
@property (nonatomic,copy)void(^rewardVideoAdDidPlayFinish)(void);
//视频广告各种错误信息回调
@property (nonatomic,copy)void(^rewardVideoAdError)(NSError *error);

//激励视频触发奖励回调-返回交易id
@property (nonatomic,copy)void(^rewardVideoDidRewardEffective)(NSString *transId,NSDictionary *validationDictionary);

// 用户点击视频跳过按钮
@property (nonatomic, copy) void(^rewardVideoAdDidClickSkip)(void);

// 广告详情页关闭回调
@property (nonatomic, copy) void(^rewardVideoAdDidCloseOtherController)(void);

// 进入广告详情页回调
@property (nonatomic, copy) void(^rewardVideoAdDidPresentFullScreen)(void);

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
