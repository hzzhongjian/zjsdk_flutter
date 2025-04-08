#import <Flutter/Flutter.h>

@interface ZjsdkFlutterPlugin : NSObject <FlutterPlugin,FlutterStreamHandler>

@property (nonatomic, strong) NSObject <FlutterBinaryMessenger> *messenger;

@property (nonatomic, strong)  FlutterMethodChannel  *methodChannel;

+ (ZjsdkFlutterPlugin *)shareInstance;

@end
