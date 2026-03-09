//
//  ZJPlatformTool.m
//  zjsdk_flutter
//
//  Created by Mountain King on 2022/10/9.
//

#import "ZJPlatformTool.h"

@implementation ZJPlatformTool
//获得当前活动窗口的根视图
+ (UIViewController *)findCurrentShowingViewController{
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentShowingVC = [self findCurrentShowingViewControllerFrom:vc];
    return currentShowingVC;
}

+ (UIViewController *)findCurrentShowingViewControllerFrom:(UIViewController *)vc
{
    // 递归方法 Recursive method
    UIViewController *currentShowingVC;
    if ([vc presentedViewController]) {
        // 当前视图是被presented出来的
        UIViewController *nextRootVC = [vc presentedViewController];
        currentShowingVC = [self findCurrentShowingViewControllerFrom:nextRootVC];

    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        UIViewController *nextRootVC = [(UITabBarController *)vc selectedViewController];
        currentShowingVC = [self findCurrentShowingViewControllerFrom:nextRootVC];

    } else if ([vc isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        UIViewController *nextRootVC = [(UINavigationController *)vc visibleViewController];
        currentShowingVC = [self findCurrentShowingViewControllerFrom:nextRootVC];

    } else {
        // 根视图为非导航类
        currentShowingVC = vc;
    }

    return currentShowingVC;
}

// 判断字符串是否为空（YES：空）
+(BOOL)isEmptyString:(NSString *)string {
    if (string) {
    } else {
        return YES;
    }
    
    if ([string isEqual:[NSNull null]]) {
        return YES;
    }
    NSString *compStr = [NSString stringWithFormat:@"%@", string];
    
    if ( compStr == nil || [compStr isEqualToString:@""] || [compStr isEqualToString:@"(null)"] || [compStr isEqualToString:@"<null>"]) {
        return YES;
    }
    
    if([compStr length] == 0) {
        return YES;
    } else if([[compStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""] == YES) {
        return YES;
    }
    
    return NO;
}

// 字典转字符串，去除字符串中的特殊字符
+ (NSString *)mapToString:(NSDictionary *)dict
{
    if (!dict && dict.allKeys.count == 0) {
        return @"";
    }
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
                                                       options:0
                                                         error:&error];
    if (!jsonData || error) {
        return @"";
    }
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    if (jsonString) {
        return [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    return @"";
}

+ (ZJAdExposureReportParam *)reportParam:(NSDictionary *)dict
{
    ZJAdExposureReportParam *param = [[ZJAdExposureReportParam alloc] init];
    param.winEcpm = [[dict objectForKey:@"winEcpm"] integerValue];
    param.adnType = ZJAdExposureAdnTypeOther;
    NSInteger adAdnType = [[dict objectForKey:@"adnType"] integerValue];
    if (adAdnType == 1) {
        param.adnType = ZJAdExposureAdnTypeKuaishou;
    } else if (adAdnType == 2) {
        param.adnType = ZJAdExposureAdnTypeOther;
    } else if (adAdnType == 3) {
        param.adnType = ZJAdExposureAdnTypeSelfSale;
    }
    param.adnName = ZJAdADNNameOther;
    NSString *adADNName = [dict objectForKey:@"adnName"];
    if ([adADNName isEqualToString:ZJAdADNNameChuanshanjia]) {
        param.adnName = ZJAdADNNameChuanshanjia;
    } else if ([adADNName isEqualToString:ZJAdADNNameGuangdiantong]) {
        param.adnName = ZJAdADNNameGuangdiantong;
    } else if ([adADNName isEqualToString:ZJAdADNNameBaidu]) {
        param.adnName = ZJAdADNNameBaidu;
    } else if ([adADNName isEqualToString:ZJAdADNNameKS]) {
        param.adnName = ZJAdADNNameKS;
    } else if ([adADNName isEqualToString:ZJAdADNNameSIGMOB]) {
        param.adnName = ZJAdADNNameSIGMOB;
    } else if ([adADNName isEqualToString:ZJAdADNNameOCTOPUS]) {
        param.adnName = ZJAdADNNameOCTOPUS;
    } else if ([adADNName isEqualToString:ZJAdADNNameQuMeng]) {
        param.adnName = ZJAdADNNameQuMeng;
    } else if ([adADNName isEqualToString:ZJAdADNNameBeiZi]) {
        param.adnName = ZJAdADNNameBeiZi;
    } else if ([adADNName isEqualToString:ZJAdADNNameOther]) {
        param.adnName = ZJAdADNNameOther;
    }
    param.adUserName = [dict objectForKey:@"adUserName"];
    param.adnMaterialType = ZJAdExposureAdnMaterialTypeOther;
    NSInteger adnMaterialType = [[dict objectForKey:@"adnMaterialType"] integerValue];
    if (adnMaterialType == 1) {
        param.adnMaterialType = ZJAdExposureAdnMaterialTypeHorizontalImg;
    } else if (adnMaterialType == 2) {
        param.adnMaterialType = ZJAdExposureAdnMaterialTypeVerticalImg;
    } else if (adnMaterialType == 3) {
        param.adnMaterialType = ZJAdExposureAdnMaterialTypeHorizontalVideo;
    } else if (adnMaterialType == 4) {
        param.adnMaterialType = ZJAdExposureAdnMaterialTypeVerticalVideo;
    } else if (adnMaterialType == 5) {
        param.adnMaterialType = ZJAdExposureAdnMaterialTypeThreeImg;
    } else if (adnMaterialType == 6) {
        param.adnMaterialType = ZJAdExposureAdnMaterialTypeStreamer;
    } else if (adnMaterialType == 7) {
        param.adnMaterialType = ZJAdExposureAdnMaterialTypeOther;
    }
    param.adnMaterialUrl = [dict objectForKey:@"adnMaterialUrl"];
    param.adTitle = [dict objectForKey:@"adTitle"];
    param.isShow = ZJAdBiddingActionTypeNone;
    NSInteger isShow = [[dict objectForKey:@"isShow"] integerValue];
    if (isShow == 0) {
        param.isShow = ZJAdBiddingActionTypeNone;
    } else if (isShow == 1) {
        param.isShow = ZJAdBiddingActionTypeSuccess;
    } else if (isShow == 2) {
        param.isShow = ZJAdBiddingActionTypeUnkown;
    }
    NSInteger isClick = [[dict objectForKey:@"isClick"] integerValue];
    if (isClick == 0) {
        param.isClick = ZJAdBiddingActionTypeNone;
    } else if (isClick == 1) {
        param.isClick = ZJAdBiddingActionTypeSuccess;
    } else if (isClick == 2) {
        param.isClick = ZJAdBiddingActionTypeUnkown;
    }
    return param;
}


@end
