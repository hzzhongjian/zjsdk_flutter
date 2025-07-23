#import <Flutter/Flutter.h>

@interface ZjsdkFlutterPlugin : NSObject<FlutterPlugin>

+ (instancetype)sharedInstance;

- (void)sendMessageWithType:(int)type
                      action:(NSString *)action
                      viewId:(int)viewId
                        code:(int)code
                         msg:(NSString *)msg
                      extra:(NSString *)extra;

@end
