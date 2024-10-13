#import "ZjsdkFlutterPlugin.h"
#import "ZJSplashAdWrapper.h"
#import "ZJInterstitialAdWrapper.h"
#import "ZJH5AdWrapper.h"
#import "ZJRewardVideoAdWrapper.h"
#import "ZJBannerAdPlatformView.h"
#import "ZJContentListPagePlatformView.h"
#import "ZJContentFeedPagePlatformView.h"
#import "ZJContentHorizontalPagePlatformView.h"
#import "ZJContentImageTextPagePlatformView.h"

#import "ZJNativeExpressAdPlatformView.h"
#import "ZJPlatformTool.h"
#import "ZJImageTextVC.h"
#import "ZJContentListPageVC.h"
#import "ZJFeedPageVC.h"
#import "ZJHorizontalFeedPageVC.h"
@interface ZjsdkFlutterPlugin ()
@property (nonatomic,strong)ZJSplashAdWrapper *splashAd;
@property (nonatomic,strong)ZJRewardVideoAdWrapper *rewardVideoAd;
@property (nonatomic,strong)ZJInterstitialAdWrapper *interstitialAd;
@property (nonatomic,strong)ZJH5AdWrapper *h5Ad;

@property (nonatomic, strong) FlutterResult callback;

@property (nonatomic, assign) BOOL methodChannelCreated;


@end

@implementation ZjsdkFlutterPlugin
static ZjsdkFlutterPlugin *zjsdkFlutterPlugin = nil;
+ (ZjsdkFlutterPlugin *)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        zjsdkFlutterPlugin = [[self alloc] init];
    });
    return zjsdkFlutterPlugin;
}

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    ZJBannerAdPlatformViewFactory *bannerFactory = [[ZJBannerAdPlatformViewFactory alloc] initWithRegistrar:registrar];
    [registrar registerViewFactory:bannerFactory withId:@"com.zjad.adsdk/banner"];
    
    ZJNativeExpressAdPlatformViewFactory *nativeExpressFactory = [[ZJNativeExpressAdPlatformViewFactory alloc] initWithRegistrar:registrar];
    [registrar registerViewFactory:nativeExpressFactory withId:@"com.zjad.adsdk/nativeExpress"];
  
    ZJContentListPagePlatformViewFactory *contentListFactory = [[ZJContentListPagePlatformViewFactory alloc] initWithRegistrar:registrar];
    [registrar registerViewFactory:contentListFactory withId:@"com.zjad.adsdk/contentVideoList"];
    
    ZJContentFeedPagePlatformViewFactory *contentFeedFactory = [[ZJContentFeedPagePlatformViewFactory alloc] initWithRegistrar:registrar];
    [registrar registerViewFactory:contentFeedFactory withId:@"com.zjad.adsdk/contentVideoFeed"];
    
    ZJContentHorizontalPagePlatformViewFactory *contentHorizontalFactory = [[ZJContentHorizontalPagePlatformViewFactory alloc] initWithRegistrar:registrar];
    [registrar registerViewFactory:contentHorizontalFactory withId:@"com.zjad.adsdk/contentVideoHorizontal"];

    ZJContentImageTextPagePlatformViewFactory *contentImageTextFactory = [[ZJContentImageTextPagePlatformViewFactory alloc] initWithRegistrar:registrar];
    [registrar registerViewFactory:contentImageTextFactory withId:@"com.zjad.adsdk/contentVideoImageText"];
    
    [ZjsdkFlutterPlugin shareInstance].messenger = registrar.messenger;
    
    NSString *channelId = @"8080";
    NSString *channel = [NSString stringWithFormat:@"com.zjsdk.adsdk/event_%@", channelId];
    FlutterEventChannel *eventChannel = [FlutterEventChannel eventChannelWithName:channel binaryMessenger:[ZjsdkFlutterPlugin shareInstance].messenger];
    //设置FlutterStreamHandler协议代理
    [eventChannel setStreamHandler:[ZjsdkFlutterPlugin shareInstance]];
}




#pragma mark =============== 保存messager，建立接收Flutter通信通道 ===============
- (void)setMessenger:(NSObject<FlutterBinaryMessenger> *)messenger{
    _messenger = messenger;
    
    ///建立通信通道 用来 监听Flutter 的调用和 调用Fluttter 方法 这里的名称要和Flutter 端保持一致
    _methodChannel = [FlutterMethodChannel methodChannelWithName:@"com.zjsdk.adsdk/method" binaryMessenger:messenger];
    __weak __typeof__(self) weakSelf = self;
    //  ZjsdkFlutterPlugin* instance = [[ZjsdkFlutterPlugin alloc] init];
    //  [registrar addMethodCallDelegate:instance channel:channel];
    [_methodChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        [weakSelf handleMethodCall:call result:result];
    }];
}

#pragma mark -- Flutter 交互监听
- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result{
    NSLog(@"ad plugin -> handleMethodCall:%@, args:%@", call.method, call.arguments);
    //监听flutter
    if ([[call method] isEqualToString:@"changeNativeTitle"]) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"changeNativeTitle" object:call.arguments];
    }
    if ([call.method isEqualToString:@"createZJMethodChannel"]) {
        [self createZJMethodChannel:call];
        return;
    }
    if(!_methodChannelCreated){
        [self createZJMethodChannel:call];
    }
    // 调用方法
    if ([call.method isEqualToString:@"setUserId"]) {
        NSString *uid = call.arguments[@"userId"];
    }else if ([call.method isEqualToString:@"registerAppId"]) {
        NSLog(@"------------注册SDK");
        [self registerAppId:call];
    } else if ([call.method isEqualToString:@"getSDKVersion"]) {
        [self getSDKVersion:call];
    } else if ([call.method isEqualToString:@"persionalizedState"]) {
        [self setPersionalizedState:call];
    } else if ([call.method isEqualToString:@"programmaticRecommend"]) {
        [self setProgrammaticRecommend:call];
    } else if ([call.method isEqualToString:@"showSplashAd"]) {
//        NSString *groupId = call.arguments[@"adId"];
        // 加载开屏广告
        [self loadSplashAd:call];
        
    }else if (([call.method isEqualToString:@"showRewardVideoAd"])) {
//        NSString *adId = call.arguments[@"adId"];
        [self loadRewardVideoAd:call];
        
    }else if ([call.method isEqualToString:@"showInterstitialAd"]) {
//        NSString *adId = call.arguments[@"adId"];
        [self loadInterstitialAd:call];
        // 加载插屏广告
        
    }else if ([call.method isEqualToString:@"showH5Ad"]) {
        //        NSString *adId = call.arguments[@"adId"];
        [self loadH5Ad:call];
    }else if ([call.method isEqualToString:@"showContentVideoListPage"]) {
//        ZJContentPageAdapter
        [self showContentVideoListPage:call];
    }else if ([call.method isEqualToString:@"showContentVideoFeedPage"]) {
//        ZJFeedPageAdapter
        //        NSString *adId = call.arguments[@"adId"];
        [self showContentVideoFeedPage:call];
    }else if ([call.method isEqualToString:@"showContentVideoHorizontal"]) {
//        ZJHorizontalFeedAdapter
        //        NSString *adId = call.arguments[@"adId"];
        [self showContentVideoHorizontal:call];
    }else if ([call.method isEqualToString:@"showContentVideoImageText"]) {
//        ZJImageTextAdapter
        //        NSString *adId = call.arguments[@"adId"];
        [self showContentVideoImageText:call];
    }else{
        NSLog(@"未实现方法异常===============>>%@", call.method);
        result(@"未实现方法异常");
//        result(FlutterMethodNotImplemented);
    }
}
#pragma mark =============== 广告加载 ===============
-(void)createZJMethodChannel:(FlutterMethodCall *)call{
    // 建立监听
//    NSString *channelId = call.arguments[@"_channelId"];
//    if ([channelId isKindOfClass:[NSNumber class]]) {
//        NSString *channel = [NSString stringWithFormat:@"com.zjsdk.adsdk/event_%@", channelId];
//        NSLog(@"建立监听===============com.zjsdk.adsdk/event_%@",channelId);
//        FlutterEventChannel *eventChannel = [FlutterEventChannel eventChannelWithName:channel binaryMessenger:[ZjsdkFlutterPlugin shareInstance].messenger];
//        //设置FlutterStreamHandler协议代理
//        [eventChannel setStreamHandler:[ZjsdkFlutterPlugin shareInstance]];
//    }
}

-(void)initMethodChannelCallBackDelay{
    NSLog(@"===delay0.5");
    [self callbackWithEvent:@"methodChannelCreated" otherDic:nil error:nil];
}

-(void)registerAppId:(FlutterMethodCall *)call{
    __weak __typeof(self) weakSelf = self;
    NSDictionary  *dic = call.arguments;
    NSString *appId = [dic objectForKey:@"appId"];
    [ZJAdSDK registerAppId:appId callback:^(BOOL completed, NSDictionary * _Nonnull info) {
        [weakSelf callbackWithEvent:completed?@"success":@"fail" otherDic:@{@"info":info} error:nil];
    }];
}

/**获取SDK的Version*/
- (void)getSDKVersion:(FlutterMethodCall *)call
{
    [self callbackWithEvent:@"SDKVersion" otherDic:@{@"SDKVersion":[ZJAdSDK SDKVersion]} error:nil];
}

- (void)setPersionalizedState:(FlutterMethodCall *)call
{
    NSDictionary  *dic = call.arguments;
    BOOL state = [[dic objectForKey:@"state"] boolValue];
    ZJSDKPersionalizedState SDKPersionalizedState = state ? ZJSDKPersionalizedState_ON : ZJSDKPersionalizedState_OFF;
    [ZJAdSDK persionalizedState:SDKPersionalizedState];
}

- (void)setProgrammaticRecommend:(FlutterMethodCall *)call
{
    NSDictionary  *dic = call.arguments;
    BOOL state = [[dic objectForKey:@"state"] boolValue];
    ZJSDKProgrammaticRecommend SDKProgrammaticRecommendState = state ? ZJSDKProgrammaticRecommend_ON : ZJSDKProgrammaticRecommend_OFF;
    [ZJAdSDK programmaticRecommend:SDKProgrammaticRecommendState];
}

/**开屏广告加载*/
-(void)loadSplashAd:(FlutterMethodCall *)call{
    //--------开屏广告--------
    __weak __typeof(self) weakSelf = self;
    NSDictionary  *dic = call.arguments;
    NSString *adId = [dic objectForKey:@"adId"];
    NSNumber *fetchDelay = [dic objectForKey:@"fetchDelay"];
    if (!self.splashAd) {
        self.splashAd = [[ZJSplashAdWrapper alloc]init];
    }
    //加载开屏广告
    [self.splashAd loadSplashAdWithAdId:adId fetchDelay:fetchDelay.floatValue];
    //开屏广告加载成功
    self.splashAd.splashAdDidLoad = ^{
        [weakSelf callbackWithEvent:@"splashAdDidLoad" otherDic:nil error:nil];
    };
    //开屏广告展示
    self.splashAd.splashAdSuccessPresentScreen = ^{
        [weakSelf callbackWithEvent:@"splashAdSuccessPresentScreen" otherDic:nil error:nil];
    };
    //开屏广告点击
    self.splashAd.splashAdClicked = ^{
        [weakSelf callbackWithEvent:@"splashAdClicked" otherDic:nil error:nil];
    };
    //开屏广告倒计时结束
    self.splashAd.splashAdCountdownEnd = ^{
        [weakSelf callbackWithEvent:@"splashAdCountdownEnd" otherDic:nil error:nil];
    };
    //开屏广告关闭
    self.splashAd.splashAdClosed = ^{
        [weakSelf callbackWithEvent:@"splashAdClosed" otherDic:nil error:nil];
    };
    self.splashAd.splashAdApplicationWillEnterBackground = ^{
        [weakSelf callbackWithEvent:@"splashAdApplicationWillEnterBackground" otherDic:nil error:nil];
    };
    //开屏广告错误-方便查看错误信息
    self.splashAd.splashAdError = ^(NSError * _Nonnull error) {
        [weakSelf callbackWithEvent:@"splashAdError" otherDic:nil error:error];
    };
}
/**激励视频加载*/
-(void)loadRewardVideoAd:(FlutterMethodCall *)call{
    //--------激励视频---------
    __weak __typeof(self) weakSelf = self;
    NSDictionary  *dic = call.arguments;
    NSString *adId = [dic objectForKey:@"adId"];
    NSString *userId = [dic objectForKey:@"userId"];
    if (!self.rewardVideoAd) {
        self.rewardVideoAd = [[ZJRewardVideoAdWrapper alloc]init];
    }
    //加载激励视频
    [self.rewardVideoAd loadRewardVideoAdWithAdId:adId userId:userId];
    //激励视频加载成功
    self.rewardVideoAd.rewardVideoLoadSuccess = ^{
        //广告加载成功-调用show
        [weakSelf.rewardVideoAd showRewardVideoAdWithViewController:[ZJPlatformTool findCurrentShowingViewController]];
        [weakSelf callbackWithEvent:@"rewardVideoLoadSuccess" otherDic:nil error:nil];
    };
    //奖励触发
    self.rewardVideoAd.rewardVideoDidRewardEffective = ^(NSString * _Nonnull transId,NSDictionary *validationDictionary) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:transId forKey:@"transId"];
        [dic setObject:validationDictionary?:@{} forKey:@"validationDictionary"];
        [weakSelf callbackWithEvent:@"rewardVideoDidRewardEffective" otherDic:dic error:nil];
    };
    //视频广告各种错误信息回调
    self.rewardVideoAd.rewardVideoAdError = ^(NSError * _Nonnull error) {
        [weakSelf callbackWithEvent:@"rewardVideoAdError" otherDic:nil error:error];
    };
    //视频广告展示
    self.rewardVideoAd.rewardVideoAdDidShow = ^{
        [weakSelf callbackWithEvent:@"rewardVideoAdDidShow" otherDic:nil error:nil];
    };
    //视频播放页关闭
    self.rewardVideoAd.rewardVideoAdDidClose = ^{
        [weakSelf callbackWithEvent:@"rewardVideoAdDidClose" otherDic:nil error:nil];
    };
    //视频广告信息点击
    self.rewardVideoAd.rewardVideoAdDidClicked = ^{
        [weakSelf callbackWithEvent:@"rewardVideoAdDidClicked" otherDic:nil error:nil];
    };
    //视频广告视频播放完成
    self.rewardVideoAd.rewardVideoAdDidPlayFinish = ^{
        [weakSelf callbackWithEvent:@"rewardVideoAdDidPlayFinish" otherDic:nil error:nil];
    };
}

/**插屏广告加载*/
-(void)loadInterstitialAd:(FlutterMethodCall *)call{
    //--------插屏---------
    __weak __typeof(self) weakSelf = self;
    NSDictionary  *dic = call.arguments;
    NSString *adId = [dic objectForKey:@"adId"];
    if (!self.interstitialAd) {
        self.interstitialAd = [[ZJInterstitialAdWrapper alloc]init];
    }
    [self.interstitialAd loadInterstitialAdWithAdId:adId];
    self.interstitialAd.interstitialAdDidLoad = ^{
        [weakSelf.interstitialAd showInViewController:[ZJPlatformTool findCurrentShowingViewController]];
        [weakSelf callbackWithEvent:@"interstitialAdDidLoad" otherDic:nil error:nil];
    };
    self.interstitialAd.interstitialAdError = ^(NSError * _Nonnull error) {
        [weakSelf callbackWithEvent:@"interstitialAdError" otherDic:nil error:error];
    };
    self.interstitialAd.interstitialAdDidClick = ^{
        [weakSelf callbackWithEvent:@"interstitialAdDidClick" otherDic:nil error:nil];
    };
    self.interstitialAd.interstitialAdDidClose = ^{
        [weakSelf callbackWithEvent:@"interstitialAdDidClose" otherDic:nil error:nil];
    };
    self.interstitialAd.interstitialAdDidPresentScreen = ^{
        [weakSelf callbackWithEvent:@"interstitialAdDidPresentScreen" otherDic:nil error:nil];
    };
    self.interstitialAd.interstitialAdDetailDidClose = ^{
        [weakSelf callbackWithEvent:@"interstitialAdDetailDidClose" otherDic:nil error:nil];
    };
}

/**H5广告加载*/
-(void)loadH5Ad:(FlutterMethodCall *)call{
    //--------H5---------
    __weak __typeof(self) weakSelf = self;
    NSDictionary  *dic = call.arguments;
    NSString *adId = [dic objectForKey:@"adId"];
    NSString *userID = [dic objectForKey:@"userID"];
    NSString *userName = [dic objectForKey:@"userName"];
    NSString *userAvatar = [dic objectForKey:@"userAvatar"];
    NSNumber *userIntegral = [dic objectForKey:@"userIntegral"];
    NSString *ext = [dic objectForKey:@"ext"];
//    if (!self.h5Ad) {
        self.h5Ad = [[ZJH5AdWrapper alloc]init];
//    }
    ZJUser *user = [[ZJUser alloc]init];
    if ([userID isKindOfClass:[NSString class]] && userID) {
        user.userID = userID;
    }
    if ([userName isKindOfClass:[NSString class]] && userName) {
        user.userName = userName;
    }
    if ([userAvatar isKindOfClass:[NSString class]] && userAvatar) {
        user.userAvatar = userAvatar;
    }
    if ([userIntegral isKindOfClass:[NSNumber class]]) {
        user.userIntegral = userIntegral.integerValue;
    }
    if ([ext isKindOfClass:[NSString class]] && ext) {
        user.ext = ext;
    }
    
    self.h5Ad.onAdDidLoad = ^{
        [weakSelf.h5Ad showAdWithViewController:[ZJPlatformTool findCurrentShowingViewController]];
        [weakSelf callbackWithEvent:@"h5AdDidLoad" otherDic:nil error:nil];
    };
    self.h5Ad.onAdError = ^(NSError * _Nonnull error) {
        [weakSelf callbackWithEvent:@"h5AdError" otherDic:nil error:error];
    };
    self.h5Ad.onRewardAdDidLoad = ^ {
        [weakSelf callbackWithEvent:@"h5_rewardAdDidLoad" otherDic:nil error:nil];
    };
    self.h5Ad.onRewardAdRewardEffective = ^(NSString * _Nonnull transId) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:transId forKey:@"transId"];
        [weakSelf callbackWithEvent:@"h5_rewardAdRewardEffective" otherDic:dic error:nil];
    };
    self.h5Ad.onRewardAdDidClick = ^ {
        [weakSelf callbackWithEvent:@"h5_rewardAdRewardClick" otherDic:nil error:nil];
    };
    self.h5Ad.onRewardAdDidError = ^ (NSError * _Nonnull error){
        [weakSelf callbackWithEvent:@"h5_rewardAdRewardError" otherDic:nil error:error];
    };
    
    [self.h5Ad loadAdWithAdId:adId user:user];
}

#pragma mark =============== 视频内容各个样式 ===============
/**视频内容列表*/
-(void)showContentVideoListPage:(FlutterMethodCall *)call{
    NSDictionary  *dic = call.arguments;
    NSString *adId = [dic objectForKey:@"adId"];
    ZJContentListPageVC *vc = [[ZJContentListPageVC alloc]init];
    vc.contentId = adId;
    __weak __typeof(self) weakSelf = self;
    vc.videoDidStartPlay = ^{
        [weakSelf callbackWithEvent:@"videoDidStartPlay" otherDic:nil error:nil];
    };
    vc.videoDidPause = ^{
        [weakSelf callbackWithEvent:@"videoDidPause" otherDic:nil error:nil];
    };
    vc.videoDidResume = ^{
        [weakSelf callbackWithEvent:@"videoDidResume" otherDic:nil error:nil];
    };
    vc.videoDidEndPlay = ^{
        [weakSelf callbackWithEvent:@"videoDidEndPlay" otherDic:nil error:nil];
    };
    vc.videoDidFailedToPlay = ^(NSError * _Nonnull error) {
        [weakSelf callbackWithEvent:@"videoDidFailedToPlay" otherDic:nil error:error];
    };
    vc.contentDidFullDisplay = ^{
        [weakSelf callbackWithEvent:@"contentDidFullDisplay" otherDic:nil error:nil];
    };
    vc.contentDidEndDisplay = ^{
        [weakSelf callbackWithEvent:@"contentDidEndDisplay" otherDic:nil error:nil];
    };
    vc.contentDidPause = ^{
        [weakSelf callbackWithEvent:@"contentDidPause" otherDic:nil error:nil];
    };
    vc.contentDidResume = ^{
        [weakSelf callbackWithEvent:@"contentDidResume" otherDic:nil error:nil];
    };
    [self presentNavViewcontroller:vc];
}

/**视频内容瀑布流*/
-(void)showContentVideoFeedPage:(FlutterMethodCall *)call{
    NSDictionary  *dic = call.arguments;
    NSString *adId = [dic objectForKey:@"adId"];
    ZJFeedPageVC *vc = [[ZJFeedPageVC alloc]init];
    vc.contentId = adId;
    __weak __typeof(self) weakSelf = self;
    vc.videoDidStartPlay = ^{
        [weakSelf callbackWithEvent:@"videoDidStartPlay" otherDic:nil error:nil];
    };
    vc.videoDidPause = ^{
        [weakSelf callbackWithEvent:@"videoDidPause" otherDic:nil error:nil];
    };
    vc.videoDidResume = ^{
        [weakSelf callbackWithEvent:@"videoDidResume" otherDic:nil error:nil];
    };
    vc.videoDidEndPlay = ^{
        [weakSelf callbackWithEvent:@"videoDidEndPlay" otherDic:nil error:nil];
    };
    vc.videoDidFailedToPlay = ^(NSError * _Nonnull error) {
        [weakSelf callbackWithEvent:@"videoDidFailedToPlay" otherDic:nil error:error];
    };
    vc.contentDidFullDisplay = ^{
        [weakSelf callbackWithEvent:@"contentDidFullDisplay" otherDic:nil error:nil];
    };
    vc.contentDidEndDisplay = ^{
        [weakSelf callbackWithEvent:@"contentDidEndDisplay" otherDic:nil error:nil];
    };
    vc.contentDidPause = ^{
        [weakSelf callbackWithEvent:@"contentDidPause" otherDic:nil error:nil];
    };
    vc.contentDidResume = ^{
        [weakSelf callbackWithEvent:@"contentDidResume" otherDic:nil error:nil];
    };
    [self presentNavViewcontroller:vc];
}

/**视频内容横版*/
-(void)showContentVideoHorizontal:(FlutterMethodCall *)call{
    NSDictionary  *dic = call.arguments;
    NSString *adId = [dic objectForKey:@"adId"];
    ZJHorizontalFeedPageVC *vc = [[ZJHorizontalFeedPageVC alloc]init];
    vc.contentId = adId;
    __weak __typeof(self) weakSelf = self;
    vc.videoDidStartPlay = ^{
        [weakSelf callbackWithEvent:@"videoDidStartPlay" otherDic:nil error:nil];
    };
    vc.videoDidPause = ^{
        [weakSelf callbackWithEvent:@"videoDidPause" otherDic:nil error:nil];
    };
    vc.videoDidResume = ^{
        [weakSelf callbackWithEvent:@"videoDidResume" otherDic:nil error:nil];
    };
    vc.videoDidEndPlay = ^{
        [weakSelf callbackWithEvent:@"videoDidEndPlay" otherDic:nil error:nil];
    };
    vc.videoDidFailedToPlay = ^(NSError * _Nonnull error) {
        [weakSelf callbackWithEvent:@"videoDidFailedToPlay" otherDic:nil error:error];
    };
    vc.contentDidFullDisplay = ^{
        [weakSelf callbackWithEvent:@"contentDidFullDisplay" otherDic:nil error:nil];
    };
    vc.contentDidEndDisplay = ^{
        [weakSelf callbackWithEvent:@"contentDidEndDisplay" otherDic:nil error:nil];
    };
    vc.contentDidPause = ^{
        [weakSelf callbackWithEvent:@"contentDidPause" otherDic:nil error:nil];
    };
    vc.contentDidResume = ^{
        [weakSelf callbackWithEvent:@"contentDidResume" otherDic:nil error:nil];
    };
    vc.horizontalFeedDetailDidEnter = ^{
        [weakSelf callbackWithEvent:@"horizontalFeedDetailDidEnter" otherDic:nil error:nil];
    };
    vc.horizontalFeedDetailDidLeave = ^{
        [weakSelf callbackWithEvent:@"horizontalFeedDetailDidLeave" otherDic:nil error:nil];
    };
    vc.horizontalFeedDetailDidAppear = ^{
        [weakSelf callbackWithEvent:@"horizontalFeedDetailDidAppear" otherDic:nil error:nil];
    };
    vc.horizontalFeedDetailDidDisappear = ^{
        [weakSelf callbackWithEvent:@"horizontalFeedDetailDidDisappear" otherDic:nil error:nil];
    };
    [self presentNavViewcontroller:vc];
}

/**视频内容瀑图文*/
-(void)showContentVideoImageText:(FlutterMethodCall *)call{
    NSDictionary  *dic = call.arguments;
    NSString *adId = [dic objectForKey:@"adId"];
    ZJImageTextVC *VC = [[ZJImageTextVC alloc]init];
    VC.contentId = adId;
    [self presentNavViewcontroller:VC];
}

-(void)presentNavViewcontroller:(UIViewController *)vc{
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    nav.modalPresentationStyle = 0;
    [zj_getCurrentVC() presentViewController:nav animated:YES completion:nil];
}
#pragma mark =============== 回调给Flutter ===============
/**回调事件*/
-(void)callbackWithEvent:(NSString *)event otherDic:(NSDictionary *)otherDic error:(NSError *)error{
    if (self.callback) {
        NSMutableDictionary *result = [NSMutableDictionary dictionary];
        [result setObject:event.length > 0 ?event :@"未知事件" forKey:@"event"];
        if(error){
            [result setObject:[error convertJSONString] forKey:@"error"];
        }else{
            [result setObject:@"" forKey:@"error"];
        }
        if (otherDic) {
            [result addEntriesFromDictionary:otherDic];
        }
        self.callback(result);
    }
}


- (void)dealloc {
    NSLog(@"ad plugin -> dealloc");
}
#pragma mark =============== 实现FlutterStreamHandler协议 ===============
- (FlutterError * _Nullable)onCancelWithArguments:(id _Nullable)arguments {
//    if([arguments isKindOfClass:[FlutterError class]]){
//        NSLog(@"FlutterError:code=%@,message=%@,details=%@,",[(FlutterError *)arguments code],[(FlutterError *)arguments message],[(FlutterError *)arguments details]);
//    }
//    NSLog(@"ad plugin -> onCancelListen:%@", arguments);
    self.callback = nil;
    return nil;
}

- (FlutterError * _Nullable)onListenWithArguments:(id _Nullable)arguments eventSink:(nonnull FlutterEventSink)events {
//    NSLog(@"ad plugin -> onListen:%@", arguments);
//    if([arguments isKindOfClass:[FlutterError class]]){
//        NSLog(@"FlutterError:code=%@,message=%@,details=%@,",[(FlutterError *)arguments code],[(FlutterError *)arguments message],[(FlutterError *)arguments details]);
//    }
    if (events) {
        self.callback = events;
        if(!_methodChannelCreated){
            _methodChannelCreated = YES;
            [self callbackWithEvent:@"methodChannelCreated" otherDic:nil error:nil];
        }
    }
    return nil;
}

@end
