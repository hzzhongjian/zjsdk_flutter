//
//  ZJNativeExpressPlatformView.m
//  ios_zjsdk_flutter_plugin
//
//  Created by 麻明康 on 2025/7/17.
//

#import "ZJNativeExpressPlatformView.h"
#import "ZJPlatformTool.h"
#import <ZJSDKCore/ZJCommon.h>
#import <ZJSDK/ZJNativeExpressFeedAdManager.h>
#import "ZjsdkFlutterPlugin.h"
#import "ZJAdEventHandler.h"

@interface ZJNativeExpressPlatformView () <ZJNativeExpressFeedAdManagerDelegate,ZJNativeExpressFeedAdDelegate,ZJNativeExpressFeedAdDelegate>

@property (nonatomic, assign) int64_t viewId;

@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, strong) ZJNativeExpressFeedAdManager *feedAdManager;

@property (nonatomic, strong) ZJNativeExpressFeedAd *feedAd;

@end

@implementation ZJNativeExpressPlatformView

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
        BOOL mutedIfCan = [[args objectForKey:@"mutedIfCan"] boolValue];
        UIViewController *rootVierController = [ZJPlatformTool findCurrentShowingViewController];
        if (!rootVierController) {
            rootVierController = [ZJCommon getCurrentVC];
        }
        self.feedAdManager = [[ZJNativeExpressFeedAdManager alloc] initWithPlacementId:posId size:CGSizeMake(width, height)];
        self.feedAdManager.delegate = self;
        self.feedAdManager.mutedIfCan = mutedIfCan;
        self.feedAdManager.rootViewController = rootVierController;
        [self.feedAdManager loadAdWithCount:adCount];
        self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        self.containerView.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (UIView *)view
{
    return _containerView;
}

#pragma mark - ZJNativeExpressFeedAdManagerDelegate
///加载成功
- (void)ZJ_nativeExpressFeedAdManagerSuccessToLoad:(ZJNativeExpressFeedAdManager *)adsManager nativeAds:(NSArray<ZJNativeExpressFeedAd *> *_Nullable)multipleResultObject
{
    [[ZjsdkFlutterPlugin sharedInstance] sendMessageWithType:NATIVE_EXPRESS action:ZJSDKFlutterPluginOnAdLoadedAction viewId:(int)self.viewId code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
    self.feedAd = multipleResultObject.firstObject;
    UIViewController *rootVierController = [ZJPlatformTool findCurrentShowingViewController];
    if (!rootVierController) {
        rootVierController = [ZJCommon getCurrentVC];
    }
    self.feedAd.rootViewController = rootVierController;
    self.feedAd.delegate = self;
    [self.feedAd render];
    [self.containerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.feedAd.feedView setFrame:self.containerView.bounds];
    [self.containerView addSubview:self.feedAd.feedView];
}

///加载失败
- (void)ZJ_nativeExpressFeedAdManager:(ZJNativeExpressFeedAdManager *)adsManager didFailWithError:(NSError *_Nullable)error
{
    if (self.containerView) {
        [self.containerView removeFromSuperview];
        self.containerView = nil;
    }
    [[ZjsdkFlutterPlugin sharedInstance] sendMessageWithType:NATIVE_EXPRESS action:ZJSDKFlutterPluginOnAdErrorAction viewId:(int)self.viewId code:(int)error.code msg:error.convertJSONString extra:@""];
}

#pragma mark - ZJNativeExpressFeedAdDelegate
/**
 * 广告渲染成功
 */
- (void)ZJ_nativeExpressFeedAdRenderSuccess:(ZJNativeExpressFeedAd *)feedAd
{
    
}
/**
 * 广告渲染失败
 */
- (void)ZJ_nativeExpressFeedAdRenderFail:(ZJNativeExpressFeedAd *)feedAd
{
    
}

/**
 *广告即将展示
 */
- (void)ZJ_nativeExpressFeedAdViewWillShow:(ZJNativeExpressFeedAd *)feedAd
{
    [[ZjsdkFlutterPlugin sharedInstance] sendMessageWithType:NATIVE_EXPRESS action:ZJSDKFlutterPluginOnAdShowAction viewId:(int)self.viewId code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
}

/**
 *广告展示错误
 */
- (void)ZJ_nativeExpressFeedAdViewShowError:(ZJNativeExpressFeedAd *)feedAd error:(NSError *)error
{
    [[ZjsdkFlutterPlugin sharedInstance] sendMessageWithType:NATIVE_EXPRESS action:ZJSDKFlutterPluginOnAdErrorAction viewId:(int)self.viewId code:(int)error.code msg:error.convertJSONString extra:@""];
}

/**
 *广告点击
 */
- (void)ZJ_nativeExpressFeedAdDidClick:(ZJNativeExpressFeedAd *)feedAd
{
    [[ZjsdkFlutterPlugin sharedInstance] sendMessageWithType:NATIVE_EXPRESS action:ZJSDKFlutterPluginOnAdClickAction viewId:(int)self.viewId code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
}
/**
 *不喜欢该广告
 */
- (void)ZJ_nativeExpressFeedAdDislike:(ZJNativeExpressFeedAd *)feedAd
{
    if (self.containerView) {
        [self.containerView removeFromSuperview];
        self.containerView = nil;
    }
    [[ZjsdkFlutterPlugin sharedInstance] sendMessageWithType:NATIVE_EXPRESS action:ZJSDKFlutterPluginOnAdCloseAction viewId:(int)self.viewId code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
}
/**
 *展示落地页
 */
- (void)ZJ_nativeExpressFeedAdDidShowOtherController:(ZJNativeExpressFeedAd *)nativeAd
{
    [[ZjsdkFlutterPlugin sharedInstance] sendMessageWithType:NATIVE_EXPRESS action:ZJSDKFlutterPluginOnAdOpenOtherControllerAction viewId:(int)self.viewId code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
}
/**
 *关闭落地页
 */
- (void)ZJ_nativeExpressFeedAdDidCloseOtherController:(ZJNativeExpressFeedAd *)nativeAd
{
    [[ZjsdkFlutterPlugin sharedInstance] sendMessageWithType:NATIVE_EXPRESS action:ZJSDKFlutterPluginOnAdCloseOtherControllerAction viewId:(int)self.viewId code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
}

@end


//**********************************************************************//

@interface ZJNativeExpressPlatformViewFactory ()

@property (nonatomic, strong) NSObject <FlutterPluginRegistrar> *registrar;

@end

@implementation ZJNativeExpressPlatformViewFactory

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
    return [[ZJNativeExpressPlatformView alloc] initWithFrame:frame viewIdentifier:viewId arguments:args registrar:_registrar];
}




@end
