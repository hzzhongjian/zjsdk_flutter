//
//  ZJAdEventHandler.m
//  ios_zjsdk_flutter_plugin
//
//  Created by 麻明康 on 2025/7/14.
//

#import "ZJAdEventHandler.h"

ZJSDKFlutterPluginKey const ZJSDKFlutterPluginTypeKey = @"type";
ZJSDKFlutterPluginKey const ZJSDKFlutterPluginViewIdKey = @"viewId";
ZJSDKFlutterPluginKey const ZJSDKFlutterPluginActionKey = @"action";
ZJSDKFlutterPluginKey const ZJSDKFlutterPluginCodeKey = @"code";
ZJSDKFlutterPluginKey const ZJSDKFlutterPluginMsgKey = @"msg";
ZJSDKFlutterPluginKey const ZJSDKFlutterPluginExtraKey = @"extra";

ZJSDKFlutterPluginAction const ZJSDKFlutterPluginInitSuccessAction = @"onInitSuccess";
ZJSDKFlutterPluginAction const ZJSDKFlutterPluginOnInitFailedAction = @"onInitFailed";
ZJSDKFlutterPluginAction const ZJSDKFlutterPluginOnAdErrorAction = @"onAdError";
ZJSDKFlutterPluginAction const ZJSDKFlutterPluginOnAdLoadedAction = @"onAdLoaded";
ZJSDKFlutterPluginAction const ZJSDKFlutterPluginOnAdShowAction = @"onAdShow";
ZJSDKFlutterPluginAction const ZJSDKFlutterPluginOnAdClickAction = @"onAdClick";
ZJSDKFlutterPluginAction const ZJSDKFlutterPluginOnAdRewardAction = @"onAdReward";
ZJSDKFlutterPluginAction const ZJSDKFlutterPluginOnAdCloseAction = @"onAdClose";
ZJSDKFlutterPluginAction const ZJSDKFlutterPluginOnAdDidPlayFinishAction = @"onAdPlayFinish";
ZJSDKFlutterPluginAction const ZJSDKFlutterPluginOnAdOpenOtherControllerAction = @"OnAdOpenOtherController";
ZJSDKFlutterPluginAction const ZJSDKFlutterPluginOnAdCloseOtherControllerAction = @"onAdCloseOtherController";
ZJSDKFlutterPluginAction const ZJSDKFlutterPluginOnVideoDidStartPlayAction = @"onVideoDidStartPlay";
ZJSDKFlutterPluginAction const ZJSDKFlutterPluginOnVideoDidPausePlayAction = @"onVideoDidPausePlay";
ZJSDKFlutterPluginAction const ZJSDKFlutterPluginOnVideoDidResumePlayAction = @"onVideoDidResumePlay";
ZJSDKFlutterPluginAction const ZJSDKFlutterPluginOnVideoDidEndPlayAction = @"onVideoDidEndPlay";
ZJSDKFlutterPluginAction const ZJSDKFlutterPluginOnVideoDidFailedToPlayAction = @"onVideoDidFailedToPlay";
ZJSDKFlutterPluginAction const ZJSDKFlutterPluginOnContentDidFullDisplayAction = @"onContentDidFullDisplay";
ZJSDKFlutterPluginAction const ZJSDKFlutterPluginOnContentDidEndDisplayAction = @"onContentDidEndDisplay";
ZJSDKFlutterPluginAction const ZJSDKFlutterPluginOnContentDidPauseAction = @"onContentDidPause";
ZJSDKFlutterPluginAction const ZJSDKFlutterPluginOnContentDidResumeAction = @"onContentDidResume";
ZJSDKFlutterPluginAction const ZJSDKFlutterPluginOnContentTaskCompleteAction = @"onContentTaskComplete";


@implementation ZJAdEventHandler

@end
