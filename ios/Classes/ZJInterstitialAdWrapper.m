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

-(void)loadInterstitialAdWithAdId:(NSString *)adId{
    self.interstitialAd = [[ZJInterstitialAd alloc]initWithPlacementId:adId];
    self.interstitialAd.delegate = self;
    [self.interstitialAd loadAd];
}

-(void)showInViewController:(UIViewController *)vc{
    [self.interstitialAd presentAdFromRootViewController:vc];
}




- (void) zj_interstitialAdDidLoad:(ZJInterstitialAd*) ad{
    if (self.interstitialAdDidLoad) {
        self.interstitialAdDidLoad();
    }
}

- (void) zj_interstitialAdDidLoadFail:(ZJInterstitialAd*) ad error:(NSError * __nullable)error{
    if (self.interstitialAdError) {
        self.interstitialAdError(error);
    }
}

- (void) zj_interstitialAdDidPresentScreen:(ZJInterstitialAd*) ad{
    if (self.interstitialAdDidPresentScreen) {
        self.interstitialAdDidPresentScreen();
    }
}

- (void) zj_interstitialAdDidClick:(ZJInterstitialAd*) ad{
    if (self.interstitialAdDidClick) {
        self.interstitialAdDidClick();
    }
}

- (void) zj_interstitialAdDidClose:(ZJInterstitialAd*) ad{
    if (self.interstitialAdDidClose) {
        self.interstitialAdDidClose();
    }
}

- (void) zj_interstitialAdDetailDidClose:(ZJInterstitialAd*) ad{
    if (self.interstitialAdDetailDidClose) {
        self.interstitialAdDetailDidClose();
    }
}

- (void) zj_interstitialAdDidFail:(ZJInterstitialAd*) ad error:(NSError * __nullable)error{
    if (self.interstitialAdError) {
        self.interstitialAdError(error);
    }
}

@end
