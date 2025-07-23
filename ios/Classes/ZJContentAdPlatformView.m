//
//  ZJContentAdPlatformView.m
//  ios_zjsdk_flutter_plugin
//
//  Created by 麻明康 on 2025/7/18.
//

#import "ZJContentAdPlatformView.h"
#import <ZJSDKCore/ZJCommon.h>
#import "ZJPlatformTool.h"
#import "ZjsdkFlutterPlugin.h"
#import "ZJAdEventHandler.h"
#import <ZJSDK/ZJContentPageAd.h>


@interface ZJContentAdPlatformView () <ZJContentPageVideoStateDelegate, ZJContentPageStateDelegate, ZJContentPageLoadCallBackDelegate>

@property (nonatomic, assign) int64_t viewId;

@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, strong) ZJContentPageAd *contentPageAd;

@end

@implementation ZJContentAdPlatformView

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

        self.contentPageAd = [[ZJContentPageAd alloc] initWithPlacementId:posId];
        self.contentPageAd.videoStateDelegate = self;
        self.contentPageAd.stateDelegate = self;
        self.contentPageAd.loadCallBackDelegate = self;
        [self.contentPageAd loadAd];
        
        self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        self.containerView.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (UIView *)view
{
    return _containerView;
}

#pragma mark - ZJContentPageVideoStateDelegate

/**
 * 视频开始播放
 * @param videoContent 内容模型
 */
- (void)zj_videoDidStartPlay:(id<ZJContentInfo>)videoContent
{
    [[ZjsdkFlutterPlugin sharedInstance] sendMessageWithType:CONTENT_AD action:ZJSDKFlutterPluginOnVideoDidStartPlayAction viewId:(int)self.viewId code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
}
/**
* 视频暂停播放
* @param videoContent 内容模型
*/
- (void)zj_videoDidPause:(id<ZJContentInfo>)videoContent
{
    [[ZjsdkFlutterPlugin sharedInstance] sendMessageWithType:CONTENT_AD action:ZJSDKFlutterPluginOnVideoDidPausePlayAction viewId:(int)self.viewId code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
}
/**
* 视频恢复播放
* @param videoContent 内容模型
*/
- (void)zj_videoDidResume:(id<ZJContentInfo>)videoContent
{
    [[ZjsdkFlutterPlugin sharedInstance] sendMessageWithType:CONTENT_AD action:ZJSDKFlutterPluginOnVideoDidResumePlayAction viewId:(int)self.viewId code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
}
/**
* 视频停止播放
* @param videoContent 内容模型
* @param finished     是否播放完成
*/
- (void)zj_videoDidEndPlay:(id<ZJContentInfo>)videoContent isFinished:(BOOL)finished
{
    [[ZjsdkFlutterPlugin sharedInstance] sendMessageWithType:CONTENT_AD action:ZJSDKFlutterPluginOnVideoDidEndPlayAction viewId:(int)self.viewId code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
}
/**
* 视频播放失败
* @param videoContent 内容模型
* @param error        失败原因
*/
- (void)zj_videoDidFailedToPlay:(id<ZJContentInfo>)videoContent withError:(NSError *)error
{
    if (self.containerView) {
        [self.containerView removeFromSuperview];
        self.containerView = nil;
    }
    [[ZjsdkFlutterPlugin sharedInstance] sendMessageWithType:CONTENT_AD action:ZJSDKFlutterPluginOnVideoDidFailedToPlayAction viewId:(int)self.viewId code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
}

#pragma mark - ZJContentPageStateDelegate

/**
* 内容展示
* @param content 内容模型
*/
- (void)zj_contentDidFullDisplay:(id<ZJContentInfo>)content
{
    [[ZjsdkFlutterPlugin sharedInstance] sendMessageWithType:CONTENT_AD action:ZJSDKFlutterPluginOnContentDidFullDisplayAction viewId:(int)self.viewId code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
}
/**
* 内容隐藏
* @param content 内容模型
*/
- (void)zj_contentDidEndDisplay:(id<ZJContentInfo>)content
{
    [[ZjsdkFlutterPlugin sharedInstance] sendMessageWithType:CONTENT_AD action:ZJSDKFlutterPluginOnContentDidEndDisplayAction viewId:(int)self.viewId code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
}
/**
* 内容暂停显示，ViewController disappear或者Application resign active
* @param content 内容模型
*/
- (void)zj_contentDidPause:(id<ZJContentInfo>)content
{
    [[ZjsdkFlutterPlugin sharedInstance] sendMessageWithType:CONTENT_AD action:ZJSDKFlutterPluginOnContentDidPauseAction viewId:(int)self.viewId code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
}
/**
* 内容恢复显示，ViewController appear或者Application become active
* @param content 内容模型
*/
- (void)zj_contentDidResume:(id<ZJContentInfo>)content
{
    [[ZjsdkFlutterPlugin sharedInstance] sendMessageWithType:CONTENT_AD action:ZJSDKFlutterPluginOnContentDidResumeAction viewId:(int)self.viewId code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
}

/// 任务完成回调
- (void)zjAdapter_contentTaskComplete:(id<ZJContentInfo>)content
{
    [[ZjsdkFlutterPlugin sharedInstance] sendMessageWithType:CONTENT_AD action:ZJSDKFlutterPluginOnContentTaskCompleteAction viewId:(int)self.viewId code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
}

#pragma mark - ZJContentPageLoadCallBackDelegate

/// 内容加载成功
- (void)zj_contentPageLoadSuccess
{
    [self.containerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UIViewController *contentVC = self.contentPageAd.contentPageViewController;
    if (contentVC) {
        [contentVC.view setFrame:self.containerView.bounds];
        [self.containerView addSubview:contentVC.view];
    }
    [[ZjsdkFlutterPlugin sharedInstance] sendMessageWithType:CONTENT_AD action:ZJSDKFlutterPluginOnAdLoadedAction viewId:(int)self.viewId code:ZJSDKFlutterPluginCode_SUCCESS msg:@"" extra:@""];
}

/// 内容加载失败
- (void)zj_contentPageLoadFailure:(NSError *)error
{
    if (self.containerView) {
        [self.containerView removeFromSuperview];
        self.containerView = nil;
    }
    [[ZjsdkFlutterPlugin sharedInstance] sendMessageWithType:CONTENT_AD action:ZJSDKFlutterPluginOnAdErrorAction viewId:(int)self.viewId code:(int)error.code msg:error.convertJSONString extra:@""];
}

@end


// ****************************************************** //

@interface ZJContentAdPlatformViewFactory ()

@property (nonatomic, strong) NSObject <FlutterPluginRegistrar> *registrar;

@end

@implementation ZJContentAdPlatformViewFactory

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
    return [[ZJContentAdPlatformView alloc] initWithFrame:frame viewIdentifier:viewId arguments:args registrar:_registrar];
}


@end
