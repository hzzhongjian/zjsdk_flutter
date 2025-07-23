//
//  ZJNewsAdPlatformView.m
//  ios_zjsdk_flutter_plugin
//
//  Created by 麻明康 on 2025/7/18.
//

#import "ZJNewsAdPlatformView.h"
#import <ZJSDKCore/ZJCommon.h>
#import <ZJSDK/ZJNewsAd.h>
#import "ZJPlatformTool.h"
#import "ZjsdkFlutterPlugin.h"
#import "ZJAdEventHandler.h"

@interface ZJNewsAdPlatformView () <ZJNewsAdDelegate>

@property (nonatomic, assign) int64_t viewId;

@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, strong) ZJNewsAd *newsAd;

@end

@implementation ZJNewsAdPlatformView

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
        NSString *userId = [args objectForKey:@"userId"];
        UIViewController *rootVierController = [ZJPlatformTool findCurrentShowingViewController];
        if (!rootVierController) {
            rootVierController = [ZJCommon getCurrentVC];
        }
        CGRect frame = CGRectMake(0, 0, width, height);
        self.newsAd = [[ZJNewsAd alloc] initWithPlacementId:posId frame:frame];
        self.newsAd.userId = userId;
        self.newsAd.delegate = self;
        [self.newsAd loadAd];
        
        self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        self.containerView.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (UIView *)view
{
    return _containerView;
}

#pragma mark - ZJNewsAdDelegate

/**
 news广告加载成功
 */
- (void)zj_newsAdDidLoad:(ZJNewsAd *)newsAd
{
    [self.containerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.containerView addSubview:self.newsAd.newAdView];
    [[ZjsdkFlutterPlugin sharedInstance] sendMessageWithType:NEWS_AD action:ZJSDKFlutterPluginOnAdLoadedAction viewId:(int)self.viewId code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
}

/**
 news广告加载失败
 */
- (void)zj_newsAd:(ZJNewsAd *)newsAd didLoadFailWithError:(NSError * _Nullable)error
{
    if (self.containerView) {
        [self.containerView removeFromSuperview];
        self.containerView = nil;
    }
    [[ZjsdkFlutterPlugin sharedInstance] sendMessageWithType:NEWS_AD action:ZJSDKFlutterPluginOnAdErrorAction viewId:(int)self.viewId code:(int)error.code msg:error.convertJSONString extra:@""];
}

/**
 newsAdView曝光回调
 */
- (void)zj_newsAdDidShow:(ZJNewsAd *)newsAd
{
    [[ZjsdkFlutterPlugin sharedInstance] sendMessageWithType:NEWS_AD action:ZJSDKFlutterPluginOnAdShowAction viewId:(int)self.viewId code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
}

/**
 关闭news广告回调
 */
- (void)zj_newsAdRewardEffective:(ZJNewsAd *)newsAd
{
    [[ZjsdkFlutterPlugin sharedInstance] sendMessageWithType:NEWS_AD action:ZJSDKFlutterPluginOnAdRewardAction viewId:(int)self.viewId code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
}

/**
 点击news广告回调
 */
- (void)zj_newsAdDidClick:(ZJNewsAd *)newsAd
{
    [[ZjsdkFlutterPlugin sharedInstance] sendMessageWithType:NEWS_AD action:ZJSDKFlutterPluginOnAdClickAction viewId:(int)self.viewId code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
}

/**
 canGoBack状态监听
 */
- (void)zj_newsAd:(ZJNewsAd *)newsAd newsAdCanGoBackStateChange:(BOOL)canGoBack
{

}

@end

// ****************************************************** //

@interface ZJNewsAdPlatformViewFactory ()

@property (nonatomic, strong) NSObject <FlutterPluginRegistrar> *registrar;

@end

@implementation ZJNewsAdPlatformViewFactory

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

- (nonnull NSObject<FlutterPlatformView> *)createWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id _Nullable)args {
    return [[ZJNewsAdPlatformView alloc] initWithFrame:frame viewIdentifier:viewId arguments:args registrar:_registrar];
}


@end
