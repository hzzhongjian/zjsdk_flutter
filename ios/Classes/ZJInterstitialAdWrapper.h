//
//  ZJInterstitialAdWrapper.h
//  ZJSDK_flutter_demo
//
//  Created by Rare on 2021/4/6.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface ZJInterstitialAdWrapper : NSObject

//加载插屏广告
-(void)loadInterstitialAdWithAdId:(NSString *)adId
                       mutedIfCan:(BOOL)mutedIfCan
                           adSize:(CGSize)adSize;
//展示
-(void)showInViewController:(UIViewController *)vc;

//插屏广告加载成功回调
@property (nonatomic,copy)void(^interstitialAdDidLoad)(void);
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

@end

NS_ASSUME_NONNULL_END
