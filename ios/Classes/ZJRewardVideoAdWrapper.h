//
//  ZJRewardVideoAdWrapper.h
//  ZJSDK_flutter_demo
//
//  Created by Rare on 2021/3/26.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
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
@property (nonatomic,copy)void(^rewardVideoLoadSuccess)(void);
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

@end

NS_ASSUME_NONNULL_END
