import 'package:flutter/material.dart';
import 'package:zjsdk_flutter/event/ios_zj_event_action.dart';
import 'package:zjsdk_flutter/zjsdk_flutter.dart';

class H5Page extends StatefulWidget {
  const H5Page({super.key});

  @override
  State<H5Page> createState() => _H5PageState();
}

class _H5PageState extends State<H5Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('H5广告'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                ZjsdkFlutter.loadH5Ad("J2455189495", (ret) {
                  switch (ret.action) {
                      case IosZjEventAction.onAdLoaded:
                        print('h5广告加载了');
                        break;
                      case IosZjEventAction.onAdError:
                        print('h5广告报错');
                        break;
                      case IosZjEventAction.onAdShow:
                        print('h5广告曝光');
                        break;
                      case IosZjEventAction.onAdClick:
                        print('h5广告点击');
                        break;
                      case IosZjEventAction.onAdRewardVerify:
                        print('h5发奖');
                        break;
                      default:
                    }
                }, userId: "88888", userName: "test", userAvatar: "http://", userIntegral: 10);
              },
              child: Text('原生H5广告'),
            ),
          ],
        ),
      ),
    );
  }
}