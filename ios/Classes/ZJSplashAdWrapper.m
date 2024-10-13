//
//  ZJAdWrapper.m
//  ZJSDK_flutter_demo
//
//  Created by Rare on 2021/3/25.
//

#import "ZJSplashAdWrapper.h"
#import <ZJSDK/ZJSDK.h>
@interface ZJSplashAdWrapper()<ZJSplashAdDelegate>

@property (nonatomic,strong)ZJSplashAd *splashAd;

@end
@implementation ZJSplashAdWrapper

-(void)loadSplashAdWithAdId:(NSString *)adId fetchDelay:(CGFloat)fetchDelay{
    self.splashAd = [[ZJSplashAd alloc]initWithPlacementId:adId];
    self.splashAd.fetchDelay = fetchDelay;
    self.splashAd.delegate = self;
    [self.splashAd loadAd];
    
}

-(void)showSplashAdInWindow:(UIWindow *)window withBottomView:(nullable UIView *)bottomView{
    [self.splashAd showAdInWindow:window];
}

#pragma mark - ZJSplashAdDelegate
/**
 *  开屏广告素材加载成功
 */
-(void)zj_splashAdDidLoad:(ZJSplashAd *)splashAd{
    
    [self showSplashAdInWindow:[UIApplication sharedApplication].windows.firstObject withBottomView:nil];
    if (self.splashAdDidLoad) {
        self.splashAdDidLoad();
    }
}

/**
 *  开屏广告成功展示
 */
-(void)zj_splashAdSuccessPresentScreen:(ZJSplashAd *)splashAd{
    if (self.splashAdSuccessPresentScreen) {
        self.splashAdSuccessPresentScreen();
    }
}

/**
 *  开屏广告点击回调
 */
- (void)zj_splashAdClicked:(ZJSplashAd *)splashAd{
    if (self.splashAdClicked) {
        self.splashAdClicked();
    }
}

/**
 *  开屏广告关闭回调
 */
- (void)zj_splashAdClosed:(ZJSplashAd *)splashAd{
    if (self.splashAdClosed) {
        self.splashAdClosed();
    }
}

/**
 *  应用进入后台时回调
 *  详解: 当点击下载应用时会调用系统程序打开，应用切换到后台
 */
- (void)zj_splashAdApplicationWillEnterBackground:(ZJSplashAd *)splashAd{
    if (self.splashAdApplicationWillEnterBackground) {
        self.splashAdApplicationWillEnterBackground();
    }
}

/**
 * 开屏广告倒记时结束
 */
- (void)zj_splashAdCountdownEnd:(ZJSplashAd*)splashAd{
    if (self.splashAdCountdownEnd) {
        self.splashAdCountdownEnd();
    }
}

/**
 *  开屏广告错误
 */
- (void)zj_splashAdError:(ZJSplashAd *)splashAd withError:(NSError *)error{
    if (self.splashAdError) {
        self.splashAdError(error);
    }
}

@end
