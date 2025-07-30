#import "ZjsdkFlutterPlugin.h"
#import <ZJSDK/ZJSDK.h>
#import "ZJAdEventHandler.h"
#import "ZJPlatformTool.h"
#import <ZJSDKCore/ZJSDKInitConfig.h>
#import <ZJSDKCore/ZJSDKPrivacyProvider.h>
#import "ZJSplashAdWrapper.h"
#import "ZJInterstitialAdWrapper.h"
#import "ZJRewardVideoAdWrapper.h"
#import "ZJH5AdWrapper.h"
#import "ZJNewsAdWrapper.h"
#import "ZJBannerAdPlatformView.h"
#import "ZJNativeExpressPlatformView.h"
#import "ZJNewsAdPlatformView.h"
#import "ZJFeedFullVideoPlatformView.h"
#import "ZJContentAdPlatformView.h"
#import "ZJPlayletAdPlatformView.h"

@interface ZjsdkFlutterPlugin ()

@property (nonatomic, strong) ZJSplashAdWrapper *splashAdWrapper;

@property (nonatomic, strong) ZJInterstitialAdWrapper *interstitialAdWrapper;

@property (nonatomic, strong) ZJRewardVideoAdWrapper *rewardVideoAdWrapper;

@property (nonatomic, strong) ZJH5AdWrapper *h5AdWrapper;

@property (nonatomic, strong) ZJNewsAdWrapper *newsAdWrapper;

@end


@implementation ZjsdkFlutterPlugin

static FlutterBasicMessageChannel *_messageChannel = nil;

+ (instancetype)sharedInstance
{
    static ZjsdkFlutterPlugin *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ZjsdkFlutterPlugin alloc] init];
    });
    return instance;
}

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
//  banner
    ZJBannerAdPlatformViewFactory *bannerAdFactory = [[ZJBannerAdPlatformViewFactory alloc] initWithRegistrar:registrar];
    [registrar registerViewFactory:bannerAdFactory withId:@"ios_zjsdk_flutter_plugin/banner"];
//  信息流
    ZJNativeExpressPlatformViewFactory *nativeExpressPlatformViewFactory = [[ZJNativeExpressPlatformViewFactory alloc] initWithRegistrar:registrar];
    [registrar registerViewFactory:nativeExpressPlatformViewFactory withId:@"ios_zjsdk_flutter_plugin/nativeExpress"];
//    新闻资讯
    ZJNewsAdPlatformViewFactory *newsAdPlatformViewFactory = [[ZJNewsAdPlatformViewFactory alloc] initWithRegistrar:registrar];
    [registrar registerViewFactory:newsAdPlatformViewFactory withId:@"ios_zjsdk_flutter_plugin/newsAd"];
//    视频流
    ZJFeedFullVideoPlatformViewFactory *feedFullVideoPlatformViewFactory = [[ZJFeedFullVideoPlatformViewFactory alloc] initWithRegistrar:registrar];
    [registrar registerViewFactory:feedFullVideoPlatformViewFactory withId:@"ios_zjsdk_flutter_plugin/feedFullVideo"];
//    视频内容
    ZJContentAdPlatformViewFactory *contentAdPlatformViewFactory = [[ZJContentAdPlatformViewFactory alloc] initWithRegistrar:registrar];
    [registrar registerViewFactory:contentAdPlatformViewFactory withId:@"ios_zjsdk_flutter_plugin/contentAd"];
//    短剧
    ZJPlayletAdPlatformViewFactory *playletAdPlatformFactory = [[ZJPlayletAdPlatformViewFactory alloc] initWithRegistrar:registrar];
    [registrar registerViewFactory:playletAdPlatformFactory withId:@"ios_zjsdk_flutter_plugin/playletAd"];
    
    FlutterMethodChannel *channel = [FlutterMethodChannel
                                     methodChannelWithName:@"ios_zjsdk_flutter_plugin/sdk_method"
                                     binaryMessenger:[registrar messenger]];
    ZjsdkFlutterPlugin *instance = [ZjsdkFlutterPlugin sharedInstance];
    [registrar addMethodCallDelegate:instance channel:channel];
    
    _messageChannel = [FlutterBasicMessageChannel messageChannelWithName:@"ios_zjsdk_flutter_plugin/sdk_message" binaryMessenger:[registrar messenger] codec:FlutterJSONMessageCodec.sharedInstance];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"getSdkVersion" isEqualToString:call.method]) {
        result([ZJAdSDK SDKVersion]);
    } else if ([@"setPersonalRecommend" isEqualToString:call.method]) {
        [self setPersonalRecommend:call];
        result(NULL);
    } else if ([@"setProgrammaticRecommend" isEqualToString:call.method]) {
        [self setProgrammaticRecommend:call];
        result(NULL);
    } else if ([@"registerAppId" isEqualToString:call.method]) {
      [self registerSDK:call];
      result(NULL);
    } else if ([@"splash" isEqualToString:call.method]) {
        [self loadSplashAd:call];
        result(NULL);
    } else if ([@"interstitial" isEqualToString:call.method]) {
        [self loadInterstitialAd:call];
        result(NULL);
    } else if ([@"Reward" isEqualToString:call.method]) {
        [self loadRewardAd:call];
        result(NULL);
    } else if ([@"h5Page" isEqualToString:call.method]) {
        [self loadH5Ad:call];
        result(NULL);
    } else if ([@"newsAd" isEqualToString:call.method]) {
        [self loadNewsAd:call];
    } else {
    result(FlutterMethodNotImplemented);
  }
}


- (void)sendMessageWithType:(int)type
                      action:(NSString *)action
                      viewId:(int)viewId
                        code:(int)code
                         msg:(NSString *)msg
                       extra:(NSString *)extra
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params addEntriesFromDictionary:@{ZJSDKFlutterPluginTypeKey : @(type)}];
    [params addEntriesFromDictionary:@{ZJSDKFlutterPluginViewIdKey : @(viewId)}];
    if (action && action.length > 0) {
        [params addEntriesFromDictionary:@{ZJSDKFlutterPluginActionKey : action}];
    }
    [params addEntriesFromDictionary:@{ZJSDKFlutterPluginCodeKey : @(code)}];
    if (msg && msg.length > 0) {
        [params addEntriesFromDictionary:@{ZJSDKFlutterPluginMsgKey : msg}];
    }
    if (extra && extra.length > 0) {
        [params addEntriesFromDictionary:@{ZJSDKFlutterPluginExtraKey : extra}];
    }
    [_messageChannel sendMessage:params];
}

#pragma mark - 配置个性化推荐开关
- (void)setPersonalRecommend:(FlutterMethodCall *)call
{
    id arguments = call.arguments;
    ZJSDKPersionalizedState state = [[arguments objectForKey:@"state"] isEqual:@(1)] ? ZJSDKPersionalizedState_ON : ZJSDKPersionalizedState_OFF;
    [ZJAdSDK persionalizedState:state];
}

#pragma mark - 配置程序化推荐开关
- (void)setProgrammaticRecommend:(FlutterMethodCall *)call
{
    id arguments = call.arguments;
    ZJSDKProgrammaticRecommend state = [[arguments objectForKey:@"state"] isEqual:@(1)] ? ZJSDKProgrammaticRecommend_ON : ZJSDKProgrammaticRecommend_OFF;
    [ZJAdSDK programmaticRecommend:state];
}

#pragma mark - 注册SDK
- (void)registerSDK:(FlutterMethodCall*)call
{
    id arguments = call.arguments;
    NSString *appId = [arguments objectForKey:@"appId"];
    __weak typeof(self) weakSelf = self;
    if ([arguments objectForKey:@"customController"]) {
        NSDictionary *customControllerDict = [arguments objectForKey:@"customController"];
        ZJSDKPrivacyAuthorityModel *privacyAuthorityModel = [[ZJSDKPrivacyAuthorityModel alloc] init];
        privacyAuthorityModel.canUseLocation = [[customControllerDict objectForKey:@"canUseLocation"] boolValue];
        privacyAuthorityModel.canUseWiFiBSSID = [[customControllerDict objectForKey:@"canUseWiFiBSSID"] boolValue];
        privacyAuthorityModel.canUseIDFA = [[customControllerDict objectForKey:@"canUseIDFA"] boolValue];
        privacyAuthorityModel.canUseIDFV = [[customControllerDict objectForKey:@"canUseIDFV"] boolValue];
        privacyAuthorityModel.canUsePhoneStatus = [[customControllerDict objectForKey:@"canUsePhoneStatus"] boolValue];
        privacyAuthorityModel.canUseDeviceId = [[customControllerDict objectForKey:@"canUseDeviceId"] boolValue];
        privacyAuthorityModel.canUseOSVersionName = [[customControllerDict objectForKey:@"canUseOSVersionName"] boolValue];
        privacyAuthorityModel.canUseOSVersionCode = [[customControllerDict objectForKey:@"canUseOSVersionCode"] boolValue];
        privacyAuthorityModel.canUsePackageName = [[customControllerDict objectForKey:@"canUsePackageName"] boolValue];
        privacyAuthorityModel.canUseAppVersionName = [[customControllerDict objectForKey:@"canUseAppVersionName"] boolValue];
        privacyAuthorityModel.canUseAppVersionCode = [[customControllerDict objectForKey:@"canUseAppVersionCode"] boolValue];
        privacyAuthorityModel.canUseBrand = [[customControllerDict objectForKey:@"canUseBrand"] boolValue];
        privacyAuthorityModel.canUseModel = [[customControllerDict objectForKey:@"canUseModel"] boolValue];
        privacyAuthorityModel.canUseScreen = [[customControllerDict objectForKey:@"canUseScreen"] boolValue];
        privacyAuthorityModel.canUseOrient = [[customControllerDict objectForKey:@"canUseOrient"] boolValue];
        privacyAuthorityModel.canUseNetworkType = [[customControllerDict objectForKey:@"canUseNetworkType"] boolValue];
        privacyAuthorityModel.canUseMNC = [[customControllerDict objectForKey:@"canUseMNC"] boolValue];
        privacyAuthorityModel.canUseMCC = [[customControllerDict objectForKey:@"canUseMCC"] boolValue];
        privacyAuthorityModel.canUseOSLanguage = [[customControllerDict objectForKey:@"canUseOSLanguage"] boolValue];
        privacyAuthorityModel.canUseTimeZone = [[customControllerDict objectForKey:@"canUseTimeZone"] boolValue];
        privacyAuthorityModel.canUseUserAgent = [[customControllerDict objectForKey:@"canUseUserAgent"] boolValue];
        privacyAuthorityModel.isCanUseMotionManager = [[customControllerDict objectForKey:@"isCanUseMotionManager"] boolValue];
        [ZJSDKInitConfig sharedInstance].privacyAuthorityModel = privacyAuthorityModel;
    }
    [ZJAdSDK registerAppId:appId callback:^(BOOL completed, NSDictionary * _Nonnull info) {
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf sendMessageWithType:INIT action:completed ? ZJSDKFlutterPluginInitSuccessAction : ZJSDKFlutterPluginOnInitFailedAction viewId:-1 code:completed ? ZJSDKFlutterPluginCode_SUCCESS : ZJSDKFlutterPluginCode_FAILURE msg:[ZJPlatformTool mapToString:info] extra:@""];
    }];
}

#pragma mark - SplashAd
- (void)loadSplashAd:(FlutterMethodCall*)call
{
    id arguments = call.arguments;
    NSString *posId = [arguments objectForKey:@"posId"];
    self.splashAdWrapper = [[ZJSplashAdWrapper alloc] init];
    __weak typeof(self) weakSelf = self;
    //开屏加载成功回调
    [self.splashAdWrapper setSplashAdDidLoad:^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf sendMessageWithType:SPLASH action:ZJSDKFlutterPluginOnAdLoadedAction viewId:-1 code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
    }];
    //开屏广告成功展示回调
    [self.splashAdWrapper setSplashAdSuccessPresentScreen:^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf sendMessageWithType:SPLASH action:ZJSDKFlutterPluginOnAdShowAction viewId:-1 code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
    }];
    //开屏广告点击回调
    [self.splashAdWrapper setSplashAdClicked:^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf sendMessageWithType:SPLASH action:ZJSDKFlutterPluginOnAdClickAction viewId:-1 code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
    }];
    //开屏广告将要关闭回调
    [self.splashAdWrapper setSplashAdWillClosed:^{
        
    }];
    //开屏广告关闭回调
    [self.splashAdWrapper setSplashAdClosed:^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf sendMessageWithType:SPLASH action:ZJSDKFlutterPluginOnAdCloseAction viewId:-1 code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
    }];
    //应用进入后台时回调 详解: 当点击下载应用时会调用系统程序打开，应用切换到后台
    [self.splashAdWrapper setSplashAdApplicationWillEnterBackground:^{
        
    }];
    //开屏广告倒记时结束回调
    [self.splashAdWrapper setSplashAdCountdownEnd:^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf sendMessageWithType:SPLASH action:ZJSDKFlutterPluginOnAdCountdownEndAction viewId:-1 code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
    }];
    //开屏广告错误回调
    [self.splashAdWrapper setSplashAdError:^(NSError * _Nonnull error) {
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf sendMessageWithType:SPLASH action:ZJSDKFlutterPluginOnAdErrorAction viewId:-1 code:(int)error.code msg:error.convertJSONString extra:@""];
    }];
    //开屏广告播放错误
    [self.splashAdWrapper setSplashAdDisplayError:^(NSError * _Nonnull error) {
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf sendMessageWithType:SPLASH action:ZJSDKFlutterPluginOnAdErrorAction viewId:-1 code:(int)error.code msg:error.convertJSONString extra:@""];
    }];
    // 落地页打开
    [self.splashAdWrapper setSplashAdDetailViewShow:^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf sendMessageWithType:SPLASH action:ZJSDKFlutterPluginOnAdOpenOtherControllerAction viewId:-1 code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
    }];

    // 落地页关闭
    [self.splashAdWrapper setSplashAdDetailViewClose:^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf sendMessageWithType:SPLASH action:ZJSDKFlutterPluginOnAdCloseOtherControllerAction viewId:-1 code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
    }];
    [self.splashAdWrapper loadSplashAdWithAdId:posId fetchDelay:5.0];
}

#pragma mark - InterstitialAd
- (void)loadInterstitialAd:(FlutterMethodCall *)call
{
    id arguments = call.arguments;
    NSString *posId = [arguments objectForKey:@"posId"];
    BOOL mutedIfCan = [[arguments objectForKey:@"mutedIfCan"] boolValue];
    CGFloat adWidth = [[arguments objectForKey:@"adWidth"] doubleValue];
    CGFloat adHeight = [[arguments objectForKey:@"adHeight"] doubleValue];
    CGSize adSize = CGSizeMake(adWidth, adHeight);
    __weak typeof(self) weakSelf = self;
    self.interstitialAdWrapper = [[ZJInterstitialAdWrapper alloc] init];
    //插屏广告加载成功回调
    [self.interstitialAdWrapper setInterstitialAdDidLoad:^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf sendMessageWithType:INTERSTITIAL action:ZJSDKFlutterPluginOnAdLoadedAction viewId:-1 code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
    }];
    //插屏广告错误
    [self.interstitialAdWrapper setInterstitialAdError:^(NSError * _Nonnull error) {
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf sendMessageWithType:INTERSTITIAL action:ZJSDKFlutterPluginOnAdErrorAction viewId:-1 code:(int)error.code msg:error.convertJSONString extra:@""];
    }];
    //插屏广告点击
    [self.interstitialAdWrapper setInterstitialAdDidClick:^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf sendMessageWithType:INTERSTITIAL action:ZJSDKFlutterPluginOnAdClickAction viewId:-1 code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
    }];
    //插屏广告关闭
    [self.interstitialAdWrapper setInterstitialAdDidClose:^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf sendMessageWithType:INTERSTITIAL action:ZJSDKFlutterPluginOnAdCloseAction viewId:-1 code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
    }];
    //插屏广告展示
    [self.interstitialAdWrapper setInterstitialAdDidPresentScreen:^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf sendMessageWithType:INTERSTITIAL action:ZJSDKFlutterPluginOnAdShowAction viewId:-1 code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
    }];
    //插屏广告关闭详情页
    [self.interstitialAdWrapper setInterstitialAdDetailDidClose:^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf sendMessageWithType:INTERSTITIAL action:ZJSDKFlutterPluginOnAdCloseOtherControllerAction viewId:-1 code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
    }];
    [self.interstitialAdWrapper setInterstitialAdDetailDidPresentFullScreen:^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf sendMessageWithType:INTERSTITIAL action:ZJSDKFlutterPluginOnAdOpenOtherControllerAction viewId:-1 code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
    }];
    [self.interstitialAdWrapper loadInterstitialAdWithAdId:posId mutedIfCan:mutedIfCan adSize:adSize];
}

#pragma mark - RewardVideoAd
- (void)loadRewardAd:(FlutterMethodCall *)call
{
    id arguments = call.arguments;
    NSString *posId = [arguments objectForKey:@"posId"];
    NSString *userId = [arguments objectForKey:@"userId"];
    NSString *reward_name = [arguments objectForKey:@"reward_name"];
    int reward_amount = [[arguments objectForKey:@"reward_amount"] intValue];
    NSString *extra = [arguments objectForKey:@"extra"];
    self.rewardVideoAdWrapper = [[ZJRewardVideoAdWrapper alloc] init];
    __weak typeof(self) weakSelf = self;
    [self.rewardVideoAdWrapper setRewardVideoLoadSuccess:^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf sendMessageWithType:REWARD_VIDEO action:ZJSDKFlutterPluginOnAdLoadedAction viewId:-1 code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
    }];
    [self.rewardVideoAdWrapper setRewardVideoAdDidShow:^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf sendMessageWithType:REWARD_VIDEO action:ZJSDKFlutterPluginOnAdShowAction viewId:-1 code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
    }];
    [self.rewardVideoAdWrapper setRewardVideoAdDidClose:^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf sendMessageWithType:REWARD_VIDEO action:ZJSDKFlutterPluginOnAdCloseAction viewId:-1 code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
    }];
    [self.rewardVideoAdWrapper setRewardVideoAdDidClicked:^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf sendMessageWithType:REWARD_VIDEO action:ZJSDKFlutterPluginOnAdClickAction viewId:-1 code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
    }];
    [self.rewardVideoAdWrapper setRewardVideoAdDidPlayFinish:^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf sendMessageWithType:REWARD_VIDEO action:ZJSDKFlutterPluginOnAdDidPlayFinishAction viewId:-1 code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
    }];
    [self.rewardVideoAdWrapper setRewardVideoAdError:^(NSError * _Nonnull error) {
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf sendMessageWithType:REWARD_VIDEO action:ZJSDKFlutterPluginOnAdErrorAction viewId:-1 code:(int)error.code msg:error.convertJSONString extra:@""];
    }];
    [self.rewardVideoAdWrapper setRewardVideoDidRewardEffective:^(NSString * _Nonnull transId, NSDictionary * _Nonnull validationDictionary) {
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf sendMessageWithType:REWARD_VIDEO action:ZJSDKFlutterPluginOnAdRewardAction viewId:-1 code:ZJSDKFlutterPluginCode_SUCCESS msg:transId extra:[ZJPlatformTool mapToString:validationDictionary]];
    }];
    [self.rewardVideoAdWrapper setRewardVideoAdDidClickSkip:^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf sendMessageWithType:REWARD_VIDEO action:ZJSDKFlutterPluginOnAdClickSkipAction viewId:-1 code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
    }];
    [self.rewardVideoAdWrapper setRewardVideoAdDidPresentFullScreen:^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf sendMessageWithType:REWARD_VIDEO action:ZJSDKFlutterPluginOnAdOpenOtherControllerAction viewId:-1 code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
    }];
    [self.rewardVideoAdWrapper setRewardVideoAdDidCloseOtherController:^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf sendMessageWithType:REWARD_VIDEO action:ZJSDKFlutterPluginOnAdCloseOtherControllerAction viewId:-1 code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
    }];
    [self.rewardVideoAdWrapper loadRewardVideoAdWithAdId:posId userId:userId reward_name:reward_name reward_amount:reward_amount extra:extra];
}

#pragma mark - H5Ad
- (void)loadH5Ad:(FlutterMethodCall *)call
{
    id arguments = call.arguments;
    NSString *posId = [arguments objectForKey:@"posId"];
    NSString *userId = [arguments objectForKey:@"userId"];
    NSString *user_name = [arguments objectForKey:@"userName"];
    NSString *userAvatar = [arguments objectForKey:@"userAvatar"];
    int userIntegral = [[arguments objectForKey:@"userIntegral"] intValue];
    NSString *extra = [arguments objectForKey:@"extra"];
    self.h5AdWrapper = [[ZJH5AdWrapper alloc] init];
    ZJUser *user = [[ZJUser alloc] init];
    user.userID = userId;
    user.userName = user_name;
    user.userAvatar = userAvatar;
    user.userIntegral = userIntegral;
    user.posId = posId;
    user.ext = extra;
    __weak typeof(self) weakSelf = self;
    //广告加载成功回调
    [self.h5AdWrapper setOnAdDidLoad:^{
//        __strong typeof(self) strongSelf = weakSelf;
//        [strongSelf sendMessageWithType:H5_PAGE action:ZJSDKFlutterPluginOnAdLoadedAction viewId:-1 code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
    }];
    //广告错误
    [self.h5AdWrapper setOnAdError:^(NSError * _Nonnull error) {
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf sendMessageWithType:H5_PAGE action:ZJSDKFlutterPluginOnAdErrorAction viewId:-1 code:(int)error.code msg:error.convertJSONString extra:@""];
    }];
    //广告激励视频加载成功
    [self.h5AdWrapper setOnRewardAdDidLoad:^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf sendMessageWithType:H5_PAGE action:ZJSDKFlutterPluginOnAdLoadedAction viewId:-1 code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
    }];
    //激励视频获得奖励
    [self.h5AdWrapper setOnRewardAdRewardEffective:^(NSString * _Nonnull transId) {
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf sendMessageWithType:H5_PAGE action:ZJSDKFlutterPluginOnAdRewardAction viewId:-1 code:ZJSDKFlutterPluginCode_SUCCESS msg:transId extra:@""];
    }];
    //激励视频点击
    [self.h5AdWrapper setOnRewardAdDidClick:^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf sendMessageWithType:H5_PAGE action:ZJSDKFlutterPluginOnAdClickAction viewId:-1 code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
    }];
    //激励视频错误
    [self.h5AdWrapper setOnRewardAdDidError:^(NSError * _Nonnull error) {
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf sendMessageWithType:H5_PAGE action:ZJSDKFlutterPluginOnAdErrorAction viewId:-1 code:(int)error.code msg:error.convertJSONString extra:@""];
    }];
    [self.h5AdWrapper loadAdWithAdId:posId user:user];
}

#pragma mark - H5Ad
- (void)loadNewsAd:(FlutterMethodCall *)call
{
    id arguments = call.arguments;
    NSString *posId = [arguments objectForKey:@"posId"];
    NSString *userId = [arguments objectForKey:@"userId"];
//    double originX = [[arguments objectForKey:@"originX"] doubleValue];
//    double originY = [[arguments objectForKey:@"originY"] doubleValue];
//    double width = [[arguments objectForKey:@"width"] doubleValue];
//    double height = [[arguments objectForKey:@"height"] doubleValue];
//    double adX = 0;
//    double adY = 0;
//    double adWidth = [UIScreen mainScreen].bounds.size.width;
//    double adHeight = [UIScreen mainScreen].bounds.size.height;
//    if (originX > 0) {
//        adX = originX;
//        adWidth = adWidth - adX;
//    }
//    if (originY > 0) {
//        adY = originY;
//        adHeight = adHeight - adY;
//    }
//    if (width > 0) {
//        adWidth = width;
//    }
//    if (height > 0) {
//        adHeight = height;
//    }
    __weak typeof(self) weakSelf = self;
    self.newsAdWrapper = [[ZJNewsAdWrapper alloc] init];
    [self.newsAdWrapper setNewsAdDidLoad:^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf sendMessageWithType:NEWS_AD action:ZJSDKFlutterPluginOnAdLoadedAction viewId:-1 code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
    }];
    [self.newsAdWrapper setNewsLoadFailWithError:^(NSError * _Nonnull error) {
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf sendMessageWithType:NEWS_AD action:ZJSDKFlutterPluginOnAdErrorAction viewId:-1 code:(int)error.code msg:error.convertJSONString extra:@""];
    }];
    [self.newsAdWrapper setNewsAdDidShow:^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf sendMessageWithType:NEWS_AD action:ZJSDKFlutterPluginOnAdShowAction viewId:-1 code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
    }];
    [self.newsAdWrapper setNewsAdRewardEffective:^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf sendMessageWithType:NEWS_AD action:ZJSDKFlutterPluginOnAdRewardAction viewId:-1 code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
    }];
    [self.newsAdWrapper setNewsAdDidClick:^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf sendMessageWithType:NEWS_AD action:ZJSDKFlutterPluginOnAdClickAction viewId:-1 code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
    }];
    [self.newsAdWrapper setNewsCanGoBackStateChange:^(BOOL canGoBack) {
        __strong typeof(self) strongSelf = weakSelf;
    }];
    [self.newsAdWrapper setNewsAdDidClose:^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf sendMessageWithType:NEWS_AD action:ZJSDKFlutterPluginOnAdCloseAction viewId:-1 code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
    }];
    [self.newsAdWrapper loadNewsAdWithAdId:posId userId:userId];
}
@end
