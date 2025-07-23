//
//  ZJNewsAdWrapper.m
//  ios_zjsdk_flutter_plugin
//
//  Created by 麻明康 on 2025/7/15.
//

#import "ZJNewsAdWrapper.h"
#import <ZJSDK/ZJNewsAd.h>
#import <ZJSDKCore/ZJCommon.h>

@interface ZJNewsAdWrapper () <ZJNewsAdDelegate>

@property (nonatomic, strong) ZJNewsAd *newsAd;

@property (nonatomic, strong) UINavigationController *NC;

@property (nonatomic, strong) UIViewController *newsAdVC;

@end

@implementation ZJNewsAdWrapper

- (void)loadNewsAdWithAdId:(NSString *)adId
                    userId:(NSString *)userId
{
    
    CGRect frame = [UIScreen mainScreen].bounds;
    UIWindow *keyWindow = [ZJCommon getKeyWindow];
    frame.origin.y = keyWindow.safeAreaInsets.top + self.NC.navigationBar.frame.size.height;
    frame.size.height = frame.size.height - keyWindow.safeAreaInsets.top - self.NC.navigationBar.frame.size.height;
    self.newsAd = [[ZJNewsAd alloc] initWithPlacementId:adId frame:frame];
    self.newsAd.userId = userId;
    self.newsAd.delegate = self;
    [self.newsAd loadAd];
}

#pragma mark - ZJNewsAdDelegate
/**
 news广告加载成功
 */
- (void)zj_newsAdDidLoad:(ZJNewsAd *)newsAd
{
    [self.newsAdVC.view addSubview:self.newsAd.newAdView];
    [[ZJCommon getCurrentVC] presentViewController:self.NC animated:YES completion:nil];
    if (self.newsAdDidLoad) {
        self.newsAdDidLoad();
    }
}

- (void)didTapBack
{
    if (self.newsAdDidClose) {
        self.newsAdDidClose();
    }
    [self.newsAdVC dismissViewControllerAnimated:YES completion:^{
            
    }];
}

/**
 news广告加载失败
 */
- (void)zj_newsAd:(ZJNewsAd *)newsAd didLoadFailWithError:(NSError * _Nullable)error
{
    if (self.newsLoadFailWithError) {
        self.newsLoadFailWithError(error);
    }
}

/**
 newsAdView曝光回调
 */
- (void)zj_newsAdDidShow:(ZJNewsAd *)newsAd
{
    if (self.newsAdDidShow) {
        self.newsAdDidShow();
    }
}

/**
 关闭news广告回调
 */
- (void)zj_newsAdRewardEffective:(ZJNewsAd *)newsAd
{
    if (self.newsAdRewardEffective) {
        self.newsAdRewardEffective();
    }
}

/**
 点击news广告回调
 */
- (void)zj_newsAdDidClick:(ZJNewsAd *)newsAd
{
    if (self.newsAdDidClick) {
        self.newsAdDidClick();
    }
}

/**
 canGoBack状态监听
 */
- (void)zj_newsAd:(ZJNewsAd *)newsAd newsAdCanGoBackStateChange:(BOOL)canGoBack
{
    if (self.newsCanGoBackStateChange) {
        self.newsCanGoBackStateChange(canGoBack);
    }
}

- (UIViewController *)newsAdVC
{
    if (!_newsAdVC) {
        self.newsAdVC = [[UIViewController alloc] init];
        self.newsAdVC.view.backgroundColor = [UIColor whiteColor];
        self.newsAdVC.modalPresentationStyle = UIModalPresentationFullScreen;
        self.newsAdVC.navigationItem.title = @"新闻资讯";
        UIImage *backImage = [self makeBackArrowImageWithColor:[UIColor blackColor]
                                                         size:CGSizeMake(12, 21)];
        self.newsAdVC.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backImage
                                                                                          style:UIBarButtonItemStylePlain
                                                                                         target:self
                                                                                         action:@selector(didTapBack)];
    }
    return _newsAdVC;
}

// 创建返回箭头图片的方法
- (UIImage *)makeBackArrowImageWithColor:(UIColor *)color size:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (!context) {
        UIGraphicsEndImageContext();
        return nil;
    }
    [color setStroke];
    CGContextSetLineWidth(context, 2);
    CGContextMoveToPoint(context, size.width, 0);
    CGContextAddLineToPoint(context, 0, size.height/2);
    CGContextAddLineToPoint(context, size.width, size.height);
    CGContextStrokePath(context);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

- (UINavigationController *)NC
{
    if (!_NC) {
        self.NC = [[UINavigationController alloc] initWithRootViewController:self.newsAdVC];
        self.NC.modalPresentationStyle = UIModalPresentationFullScreen;
        self.NC.navigationBar.backgroundColor = [UIColor whiteColor];
        self.NC.navigationBar.tintColor = [UIColor blackColor];
    }
    return _NC;
}

@end
