//
//  ZJH5AdWrapper.h
//  ZJSDK_flutter_demo
//
//  Created by Rare on 2021/9/1.
//

#import <Foundation/Foundation.h>
#import <ZJSDK/ZJH5Page.h>
NS_ASSUME_NONNULL_BEGIN

@interface ZJH5AdWrapper : NSObject

//加载H5广告
-(void)loadAdWithAdId:(NSString *)adId user:(ZJUser *)user; 

-(void)showAdWithViewController:(UIViewController *)vc;



//h5加载成功回调
@property (nonatomic,copy)void(^onAdDidLoad)(void);

//广告错误
@property (nonatomic,copy)void(^onAdError)(NSError *error);

//h5激励视频广告加载成功
@property (nonatomic,copy)void(^onRewardAdDidLoad)(void);

//激励视频获得奖励
@property (nonatomic,copy)void(^onRewardAdRewardEffective)(NSString *transId);

//激励视频点击
@property (nonatomic,copy)void(^onRewardAdDidClick)(void);

//激励视频错误
@property (nonatomic,copy)void(^onRewardAdDidError)(NSError *error);

@end

NS_ASSUME_NONNULL_END
