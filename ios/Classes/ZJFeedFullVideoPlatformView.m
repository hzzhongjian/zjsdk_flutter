//
//  ZJFeedFullVideoPlatformView.m
//  ios_zjsdk_flutter_plugin
//
//  Created by 麻明康 on 2025/7/18.
//

#import "ZJFeedFullVideoPlatformView.h"
#import <ZJSDKCore/ZJCommon.h>
#import "ZJPlatformTool.h"
#import <ZJSDK/ZJFeedFullVideoProvider.h>
#import "ZjsdkFlutterPlugin.h"
#import "ZJAdEventHandler.h"

@interface ZJFeedFullVideoPlatformView () <ZJFeedFullVideoProviderDelegate>

@property (nonatomic, assign) int64_t viewId;

@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, strong) ZJFeedFullVideoProvider *adProvider;

@property (nonatomic, strong) ZJFeedFullVideoView *feedFullVideoView;

@end

@implementation ZJFeedFullVideoPlatformView


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
        int adCount = [[args objectForKey:@"adCount"] intValue];
        UIViewController *rootVierController = [ZJPlatformTool findCurrentShowingViewController];
        if (!rootVierController) {
            rootVierController = [ZJCommon getCurrentVC];
        }

        if (!self.adProvider) {
            self.adProvider = [[ZJFeedFullVideoProvider alloc] initWithPlacementId:posId];
            self.adProvider.delegate = self;
            self.adProvider.adSize = CGSizeMake(width, height);
        }
        [self.adProvider loadAd:adCount];
        
        self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        self.containerView.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (UIView *)view
{
    return _containerView;
}

#pragma mark - ZJFeedFullVideoProviderDelegate

/**
 * 广告加载成功
 */
- (void)zj_feedFullVideoProviderLoadSuccess:(ZJFeedFullVideoProvider *)provider views:(NSArray<__kindof ZJFeedFullVideoView *> *)views
{
    [self.containerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.feedFullVideoView = views.firstObject;
    UIViewController *rootVierController = [ZJPlatformTool findCurrentShowingViewController];
    if (!rootVierController) {
        rootVierController = [ZJCommon getCurrentVC];
    }
    self.feedFullVideoView.rootViewController = rootVierController;
    [self.feedFullVideoView render];
    [self.feedFullVideoView setFrame:self.containerView.bounds];
    [self.containerView addSubview:self.feedFullVideoView];
    [[ZjsdkFlutterPlugin sharedInstance] sendMessageWithType:DRAW_AD action:ZJSDKFlutterPluginOnAdLoadedAction viewId:(int)self.viewId code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
}


/**
* 广告加载失败
*/
- (void)zj_feedFullVideoProviderLoadFail:(ZJFeedFullVideoProvider *)provider error:(NSError *_Nullable)error
{
    if (self.containerView) {
        [self.containerView removeFromSuperview];
        self.containerView = nil;
    }
    [[ZjsdkFlutterPlugin sharedInstance] sendMessageWithType:DRAW_AD action:ZJSDKFlutterPluginOnAdErrorAction viewId:(int)self.viewId code:(int)error.code msg:error.convertJSONString extra:@""];
}

/**
 * 广告渲染成功, ZJFeedFullVideoView.size.height has been updated
 */
- (void)zj_feedFullVideoAdViewRenderSuccess:(ZJFeedFullVideoProvider *)provider view:(ZJFeedFullVideoView *) adView
{
    
}

/**
 * 广告渲染失败
 */
- (void)zj_feedFullVideoAdViewRenderFail:(ZJFeedFullVideoProvider *)provider view:(ZJFeedFullVideoView *) adView error:(NSError *_Nullable)error
{
    
}

/**
 * 广告曝光回调
 */
- (void)zj_feedFullVideoAdViewWillShow:(ZJFeedFullVideoProvider *)provider view:(ZJFeedFullVideoView *) adView
{
    [[ZjsdkFlutterPlugin sharedInstance] sendMessageWithType:DRAW_AD action:ZJSDKFlutterPluginOnAdShowAction viewId:(int)self.viewId code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
}

/**
视频广告播放状态更改回调
*/
- (void)zj_feedFullVideoAdViewStateDidChanged:(ZJFeedFullVideoProvider *)provider view:(ZJFeedFullVideoView *) adView state:(ZJMediaPlayerStatus)playerState
{
    
}
/**
视频广告播放完毕
*/
- (void)zj_feedFullVideoAdViewPlayerDidPlayFinish:(ZJFeedFullVideoProvider *)provider view:(ZJFeedFullVideoView *) adView
{
    [[ZjsdkFlutterPlugin sharedInstance] sendMessageWithType:DRAW_AD action:ZJSDKFlutterPluginOnAdDidPlayFinishAction viewId:(int)self.viewId code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
}

/**
 * 广告点击回调
 */
- (void)zj_feedFullVideoAdViewDidClick:(ZJFeedFullVideoProvider *)provider view:(ZJFeedFullVideoView *) adView
{
    [[ZjsdkFlutterPlugin sharedInstance] sendMessageWithType:DRAW_AD action:ZJSDKFlutterPluginOnAdClickAction viewId:(int)self.viewId code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
}

/**
* 广告详情页面即将展示回调
*/
- (void)zj_feedFullVideoAdViewDetailViewWillPresentScreen:(ZJFeedFullVideoProvider *)provider view:(ZJFeedFullVideoView *) adView
{
    [[ZjsdkFlutterPlugin sharedInstance] sendMessageWithType:DRAW_AD action:ZJSDKFlutterPluginOnAdOpenOtherControllerAction viewId:(int)self.viewId code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
}

/**
 *广告详情页关闭回调
 */
- (void)zj_feedFullVideoAdViewDetailViewClosed:(ZJFeedFullVideoProvider *)provider view:(ZJFeedFullVideoView *) adView
{
    [[ZjsdkFlutterPlugin sharedInstance] sendMessageWithType:DRAW_AD action:ZJSDKFlutterPluginOnAdCloseOtherControllerAction viewId:(int)self.viewId code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
}

@end


// ****************************************************** //

@interface ZJFeedFullVideoPlatformViewFactory ()

@property (nonatomic, strong) NSObject <FlutterPluginRegistrar> *registrar;

@end

@implementation ZJFeedFullVideoPlatformViewFactory

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
    return [[ZJFeedFullVideoPlatformView alloc] initWithFrame:frame viewIdentifier:viewId arguments:args registrar:_registrar];
}


@end
