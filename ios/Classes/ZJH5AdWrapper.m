//
//  ZJH5AdWrapper.m
//  ZJSDK_flutter_demo
//
//  Created by Rare on 2021/9/1.
//

#import "ZJH5AdWrapper.h"
#import <ZJSDKCore/ZJCommon.h>

@interface ZJH5AdWrapper()<ZJH5PageDelegate>

@property (nonatomic,strong)ZJH5Page *h5page;
@end

@implementation ZJH5AdWrapper

-(void)loadAdWithAdId:(NSString *)adId user:(ZJUser *)user{
    self.h5page = [[ZJH5Page alloc]initWithPlacementId:adId user:user delegate:self];
    [self.h5page loadH5Page];
}
-(void)showAdWithViewController:(UIViewController *)vc{
    [self.h5page presentH5FromRootViewController:vc animated:NO];
}

//H5Ad加载完成
-(void) onZjH5PageLoaded:(ZJUser*) user error:(nullable NSError*) error{
    if (error) {
        if (self.onAdError) {
            self.onAdError(error);
        }
    }else{
        [self showAdWithViewController:[ZJCommon getCurrentVC]];
        if (self.onAdDidLoad) {
            self.onAdDidLoad();
        }
    }
}

//H5Ad错误
-(void) onZjH5PageError:(ZJUser*) user error:(NSError*) error{
    if (self.onAdError) {
        self.onAdError(error);
    }
}


//H5操作回调
//积分不足
-(void) onIntegralNotEnough:(ZJUser*) user needIntegral:(NSInteger) integral{
    
}
//积分消耗
-(void) onIntegralExpend:(ZJUser*) user expendIntegral:(NSInteger) integral{
    
}

//积分奖励
-(void) onIntegralReward:(ZJUser*) user rewardIntegral:(NSInteger) integral{
    
}

//奖励发放,奖励积分
-(void) onZjH5PageAdRewardProvide:(ZJUser*) user rewardIntegral:(NSInteger) integral{
    
}

//用户页面的行为操作
-(void) onZjH5PageUserBehavior:(ZJUser*) user behavior:(NSString*) behavior{
    
}


//广告回调
//广告激励视频加载成功
-(void) onZjH5PageAdRewardLoaded:(ZJUser*) user trans_id:(NSString*) trans_id{
    if (self.onRewardAdDidLoad) {
        self.onRewardAdDidLoad();
    }
}

//广告激励视频触发激励（观看视频大于一定时长或者视频播放完毕）
-(void) onZjH5PageAdRewardValid:(ZJUser*) user trans_id:(NSString*) trans_id{
    if (self.onRewardAdRewardEffective) {
        self.onRewardAdRewardEffective(trans_id);
    }
}

//广告点击
-(void) onZjH5PageAdRewardClick:(ZJUser*) user {
    if (self.onRewardAdDidClick) {
        self.onRewardAdDidClick();
    }
}

//广告加载错误
-(void) onZjH5PageAdReward:(ZJUser*) user didFailWithError:(NSError*) error{
    if (self.onRewardAdDidError) {
        self.onRewardAdDidError(error);
    }
}

@end
