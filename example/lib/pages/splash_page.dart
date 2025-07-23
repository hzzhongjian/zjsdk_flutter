import 'package:flutter/material.dart';
import 'package:zjsdk_flutter/event/ios_zj_event_action.dart';
import 'package:zjsdk_flutter/zjsdk_flutter.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('开屏广告')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                ZjsdkFlutter.loadSplashAd("J6428742394", (ret) {
                  switch (ret.action) {
                    case IosZjEventAction.onAdLoaded:
                      print('开屏广告加载了');
                      break;
                    case IosZjEventAction.onAdError:
                      print('开屏广告错误');
                      break;
                    case IosZjEventAction.onAdShow:
                      print('开屏广告曝光');
                      break;
                    case IosZjEventAction.onAdClick:
                      print("开屏广告点击");
                      break;
                    case IosZjEventAction.onAdClose:
                      print("开屏广告关闭");
                      break;
                    default:
                  }
                });
              },
              child: Text('原生开屏广告'),
            ),
          ],
        ),
      ),
    );
  }
}
