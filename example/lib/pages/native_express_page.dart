import 'package:flutter/material.dart';
import 'package:zjsdk_flutter/event/ios_zj_event_action.dart';
import 'package:zjsdk_flutter/widgets/ios_zj_native_express_view.dart';

class NativeExpressPage extends StatefulWidget {
  const NativeExpressPage({super.key});

  @override
  State<NativeExpressPage> createState() => _NativeExpressPageState();
}

class _NativeExpressPageState extends State<NativeExpressPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text('信息流广告')),
      body: Center(
        child: IosZjNativeExpressView(
          "K4000000007",
          width: size.width,
          height: 200,
          nativeExpressListener: (ret) {
            switch (ret.action) {
              case IosZjEventAction.onAdLoaded:
                print('信息流广告加载了');
                break;
              case IosZjEventAction.onAdError:
                print('信息流广告错误');
                break;
              case IosZjEventAction.onAdShow:
                print('信息流广告曝光');
                break;
              case IosZjEventAction.onAdClick:
                print("信息流广告点击");
                break;
              case IosZjEventAction.onAdClose:
                print("信息流广告关闭");
                break;
              case IosZjEventAction.onAdOpenOtherController:
                print("信息流广告详情页打开");
                break;
              case IosZjEventAction.onAdCloseOtherController:
                print("信息流广告详情页关闭");
                break;
              default:
            }
          },
        ),
      ),
    );
  }
}
