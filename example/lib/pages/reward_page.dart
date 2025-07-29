import 'package:flutter/material.dart';
import 'package:zjsdk_flutter/event/ios_zj_event_action.dart';
import 'package:zjsdk_flutter/zjsdk_flutter.dart';

class RewardPage extends StatefulWidget {
  const RewardPage({super.key});

  @override
  State<RewardPage> createState() => _RewardPageState();
}

class _RewardPageState extends State<RewardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('激励广告')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                ZjsdkFlutter.loadRewardVideoAd(
                  "KS90010001",
                  "188888888",
                  (ret) {
                    switch (ret.action) {
                      case IosZjEventAction.onAdLoaded:
                        print('激励广告加载了');
                        break;
                      case IosZjEventAction.onAdError:
                        print('激励广告报错');
                        break;
                      case IosZjEventAction.onAdShow:
                        print('激励广告曝光');
                        break;
                      case IosZjEventAction.onAdClick:
                        print('激励广告点击');
                        break;
                      case IosZjEventAction.onAdClose:
                        print('激励广告关闭');
                        break;
                      case IosZjEventAction.onAdRewardVerify:
                        dynamic tradeId = ret.msg;
                        dynamic extra = ret.extra;
                        print('激励发奖--${tradeId}--${extra}');
                        break;
                      case IosZjEventAction.onAdClickSkip:
                        print("点击跳过按钮");
                        break;
                      case IosZjEventAction.onAdOpenOtherController:
                        print("落地页打开");
                        break;
                      case IosZjEventAction.onAdCloseOtherController:
                        print("落地页关闭");
                        break;
                      default:
                    }
                  },
                  rewardAmount: 10,
                  rewardName: "积分",
                  extra: "extra",
                );
              },
              child: Text('原生激励广告'),
            ),
          ],
        ),
      ),
    );
  }
}
