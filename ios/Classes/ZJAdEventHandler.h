//
//  ZJAdEventHandler.h
//  ios_zjsdk_flutter_plugin
//
//  Created by 麻明康 on 2025/7/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * 消息的key
 */
typedef NSString *ZJSDKFlutterPluginKey;

extern ZJSDKFlutterPluginKey const ZJSDKFlutterPluginTypeKey;
extern ZJSDKFlutterPluginKey const ZJSDKFlutterPluginViewIdKey;
extern ZJSDKFlutterPluginKey const ZJSDKFlutterPluginActionKey;
extern ZJSDKFlutterPluginKey const ZJSDKFlutterPluginCodeKey;
extern ZJSDKFlutterPluginKey const ZJSDKFlutterPluginMsgKey;
extern ZJSDKFlutterPluginKey const ZJSDKFlutterPluginExtraKey;

typedef NSString *ZJSDKFlutterPluginAction;

extern ZJSDKFlutterPluginAction const ZJSDKFlutterPluginInitSuccessAction;
extern ZJSDKFlutterPluginAction const ZJSDKFlutterPluginOnInitFailedAction;;
extern ZJSDKFlutterPluginAction const ZJSDKFlutterPluginOnAdErrorAction;
extern ZJSDKFlutterPluginAction const ZJSDKFlutterPluginOnAdLoadedAction;
extern ZJSDKFlutterPluginAction const ZJSDKFlutterPluginOnAdShowAction;
extern ZJSDKFlutterPluginAction const ZJSDKFlutterPluginOnAdClickAction;
extern ZJSDKFlutterPluginAction const ZJSDKFlutterPluginOnAdRewardAction;
extern ZJSDKFlutterPluginAction const ZJSDKFlutterPluginOnAdCloseAction;
extern ZJSDKFlutterPluginAction const ZJSDKFlutterPluginOnAdDidPlayFinishAction;
extern ZJSDKFlutterPluginAction const ZJSDKFlutterPluginOnAdOpenOtherControllerAction;
extern ZJSDKFlutterPluginAction const ZJSDKFlutterPluginOnAdCloseOtherControllerAction;
extern ZJSDKFlutterPluginAction const ZJSDKFlutterPluginOnAdCountdownEndAction;
extern ZJSDKFlutterPluginAction const ZJSDKFlutterPluginOnAdClickSkipAction;
// 以下为视频内容使用的
extern ZJSDKFlutterPluginAction const ZJSDKFlutterPluginOnVideoDidStartPlayAction;
extern ZJSDKFlutterPluginAction const ZJSDKFlutterPluginOnVideoDidPausePlayAction;
extern ZJSDKFlutterPluginAction const ZJSDKFlutterPluginOnVideoDidResumePlayAction;
extern ZJSDKFlutterPluginAction const ZJSDKFlutterPluginOnVideoDidEndPlayAction;
extern ZJSDKFlutterPluginAction const ZJSDKFlutterPluginOnVideoDidFailedToPlayAction;
extern ZJSDKFlutterPluginAction const ZJSDKFlutterPluginOnContentDidFullDisplayAction;
extern ZJSDKFlutterPluginAction const ZJSDKFlutterPluginOnContentDidEndDisplayAction;
extern ZJSDKFlutterPluginAction const ZJSDKFlutterPluginOnContentDidPauseAction;
extern ZJSDKFlutterPluginAction const ZJSDKFlutterPluginOnContentDidResumeAction;
extern ZJSDKFlutterPluginAction const ZJSDKFlutterPluginOnContentTaskCompleteAction;

/**
 * 类别
 */
typedef NS_ENUM(NSUInteger, ZJSDKFlutterPluginAdType) {
    // 初始化
    INIT = 0,
    // 开屏
    SPLASH = 1,
    // 激励视频
    REWARD_VIDEO = 2,
    // 插全屏
    INTERSTITIAL = 3,
    // 横幅
    BANNER = 4,
    // 信息流
    NATIVE_EXPRESS = 5,
    // 视频流
    DRAW_AD = 6,
    // 视频内容
    CONTENT_AD = 7,
    // 新闻资讯
    NEWS_AD = 8,
    // H5页面
    H5_PAGE = 9,
    // 短剧
    TUBE_AD = 10,
};

typedef NS_ENUM(NSUInteger, ZJSDKFlutterPluginCode) {
    ZJSDKFlutterPluginCode_SUCCESS = 200,
    ZJSDKFlutterPluginCode_FAILURE = 500,
};

@interface ZJAdEventHandler : NSObject

@end

NS_ASSUME_NONNULL_END
