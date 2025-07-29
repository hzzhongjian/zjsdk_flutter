//
//  ZJBannerAdPlatformView.m
//  ios_zjsdk_flutter_plugin
//
//  Created by 麻明康 on 2025/7/17.
//

#import "ZJBannerAdPlatformView.h"
#import <ZJSDK/ZJBannerAd.h>
#import "ZjsdkFlutterPlugin.h"
#import "ZJAdEventHandler.h"
#import "ZJPlatformTool.h"

@interface ZJBannerAdPlatformView () <ZJBannerAdDelegate>

@property (nonatomic, strong) ZJBannerAd *bannerAd;

@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, assign) int64_t viewId;

@end

@implementation ZJBannerAdPlatformView

- (instancetype)initWithFrame:(CGRect)frame
               viewIdentifier:(int64_t)viewId
                    arguments:(id _Nullable)args
                    registrar:(NSObject<FlutterPluginRegistrar> *)registrar
{
    if (self = [super init]) {
        self.viewId = viewId;
        NSString *posId = [args objectForKey:@"posId"];
        double width = [[args objectForKey:@"width"] doubleValue];
        double height = [[args objectForKey:@"height"] doubleValue];
        UIViewController *rootVierController = [ZJPlatformTool findCurrentShowingViewController];
        if (!rootVierController) {
            rootVierController = [ZJCommon getCurrentVC];
        }
        self.bannerAd = [[ZJBannerAd alloc] initWithPlacementId:posId rootViewController:rootVierController adSize:CGSizeMake(width, height)];
        self.bannerAd.interval = 0;
        self.bannerAd.delegate = self;
        [self.bannerAd loadAd];
        self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        self.containerView.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (UIView *)view
{
    return _containerView;
}

#pragma mark - ZJBannerAdDelegate

/**
 banner广告加载成功
 */
- (void)zj_bannerAdDidLoad:(ZJBannerAd *)bannerAd
{
    [[ZjsdkFlutterPlugin sharedInstance] sendMessageWithType:BANNER action:ZJSDKFlutterPluginOnAdLoadedAction viewId:(int)self.viewId code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
    [self.containerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self performSelector:@selector(showBannerAd) withObject:self afterDelay:0.5];
}

- (void)showBannerAd
{
    [self.bannerAd showAd];
    UIView *bannerView = [self.bannerAd bannerView];
    [self.containerView addSubview:bannerView];
}

/**
 banner广告加载失败
 */
- (void)zj_bannerAd:(ZJBannerAd *)bannerAd didLoadFailWithError:(NSError * _Nullable)error
{
    if (self.containerView) {
        [self.containerView removeFromSuperview];
        self.containerView = nil;
    }
    [[ZjsdkFlutterPlugin sharedInstance] sendMessageWithType:BANNER action:ZJSDKFlutterPluginOnAdLoadedAction viewId:(int)self.viewId code:(int)error.code msg:error.convertJSONString extra:@""];
}

/**
 bannerAdView曝光回调
 */
- (void)zj_bannerAdWillBecomVisible:(ZJBannerAd *)bannerAd
{
    [[ZjsdkFlutterPlugin sharedInstance] sendMessageWithType:BANNER action:ZJSDKFlutterPluginOnAdShowAction viewId:(int)self.viewId code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
}

/**
 关闭banner广告回调
 */
- (void)zj_bannerAdDislike:(ZJBannerAd *)bannerAd
{
    if (self.containerView) {
        [self.containerView removeFromSuperview];
        self.containerView = nil;
    }
    [[ZjsdkFlutterPlugin sharedInstance] sendMessageWithType:BANNER action:ZJSDKFlutterPluginOnAdCloseAction viewId:(int)self.viewId code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
}

/**
 点击banner广告回调
 */
- (void)zj_bannerAdDidClick:(ZJBannerAd *)bannerAd
{
    [[ZjsdkFlutterPlugin sharedInstance] sendMessageWithType:BANNER action:ZJSDKFlutterPluginOnAdClickAction viewId:(int)self.viewId code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
}

/**
 关闭banner广告详情页回调
 */
- (void)zj_bannerAdDidCloseOtherController:(ZJBannerAd *)bannerAd
{
    [[ZjsdkFlutterPlugin sharedInstance] sendMessageWithType:BANNER action:ZJSDKFlutterPluginOnAdCloseOtherControllerAction viewId:(int)self.viewId code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
}

/**
 打开banner广告详情页回调
 */
- (void)zj_bannerAdDetailDidPresentFullScreen:(ZJBannerAd *)bannerAd
{
    [[ZjsdkFlutterPlugin sharedInstance] sendMessageWithType:BANNER action:ZJSDKFlutterPluginOnAdOpenOtherControllerAction viewId:(int)self.viewId code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
}

@end

//**********************************************************************************//

@interface ZJBannerAdPlatformViewFactory ()

@property (nonatomic, strong) NSObject <FlutterPluginRegistrar> *registrar;

@end


@implementation ZJBannerAdPlatformViewFactory


- (instancetype)initWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar
{
    if (self = [super init]) {
        _registrar = registrar;
    }
    return self;
}

- (NSObject<FlutterMessageCodec> *)createArgsCodec
{
    return [FlutterJSONMessageCodec sharedInstance];
}

- (NSObject<FlutterPlatformView> *)createWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id)args {
    return [[ZJBannerAdPlatformView alloc] initWithFrame:frame viewIdentifier:viewId arguments:args registrar:_registrar];
}

@end
