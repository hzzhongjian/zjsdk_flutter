//
//  ZJNewsAdWrapper.h
//  ios_zjsdk_flutter_plugin
//
//  Created by 麻明康 on 2025/7/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJNewsAdWrapper : NSObject

- (void)loadNewsAdWithAdId:(NSString *)adId
                    userId:(NSString *)userId;

// news广告加载成功
@property (nonatomic,copy) void(^newsAdDidLoad)(void);

// news广告加载失败
@property (nonatomic,copy) void(^newsLoadFailWithError)(NSError *error);

// newsAdView曝光回调
@property (nonatomic,copy) void(^newsAdDidShow)(void);

// news获取奖励的广告回调
@property (nonatomic,copy) void(^newsAdRewardEffective)(void);

// 点击news广告回调
@property (nonatomic,copy) void(^newsAdDidClick)(void);

// canGoBack状态监听
@property (nonatomic,copy) void(^newsCanGoBackStateChange)(BOOL canGoBack);

// 关闭news广告回调
@property (nonatomic,copy) void(^newsAdDidClose)(void);

@end

NS_ASSUME_NONNULL_END
