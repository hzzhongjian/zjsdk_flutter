//
//  ZJPlatformTool.h
//  zjsdk_flutter
//
//  Created by Mountain King on 2022/10/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJPlatformTool : NSObject

//获得当前活动窗口的根视图
+ (UIViewController *)findCurrentShowingViewController;

+ (UIViewController *)findCurrentShowingViewControllerFrom:(UIViewController *)vc;

+ (BOOL)isEmptyString:(NSString *)string;

// 字典转字符串，去除字符串中的特殊字符
+ (NSString *)mapToString:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
