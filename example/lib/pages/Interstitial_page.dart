import 'package:flutter/material.dart';
import 'package:zjsdk_flutter/event/ios_zj_event_action.dart';
import 'package:zjsdk_flutter/zjsdk_flutter.dart';

class InterstitialPage extends StatefulWidget {
  const InterstitialPage({super.key});

  @override
  State<InterstitialPage> createState() => _InterstitialPageState();
}

class _InterstitialPageState extends State<InterstitialPage> {
  @override
  Widget build(BuildContext context) {
    final adSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text('插屏广告')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                ZjsdkFlutter.loadInterstitialAd(
                  "J7311893871",
                  (ret) {
                    switch (ret.action) {
                      case IosZjEventAction.onAdLoaded:
                        print('插屏广告加载了');
                        break;
                      case IosZjEventAction.onAdError:
                        print('插屏广告报错');
                        break;
                      case IosZjEventAction.onAdShow:
                        print('插屏广告曝光');
                        break;
                      case IosZjEventAction.onAdClick:
                        print('插屏广告点击');
                        break;
                      case IosZjEventAction.onAdClose:
                        print('插屏广告关闭');
                        break;
                      case IosZjEventAction.onAdCloseOtherController:
                        print('插屏详情页关闭');
                        break;
                      case IosZjEventAction.onAdOpenOtherController:
                        print("落地页打开");
                        break;
                      default:
                    }
                  },
                  mutedIfCan: true,
                  adSize: adSize,
                );
              },
              child: Text('原生插屏广告'),
            ),
          ],
        ),
      ),
    );
  }
}
