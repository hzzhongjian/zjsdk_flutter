import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zjsdk_flutter/widgets/ios_zj_playlet_view.dart';

class PlayletPage extends StatefulWidget {
  const PlayletPage({super.key});

  @override
  State<PlayletPage> createState() => _PlayletPageState();
}

class _PlayletPageState extends State<PlayletPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraint) {
            final maxWidth = constraint.maxWidth;
            final maxHeight = constraint.maxHeight;
            return IosZjPlayletView(
              "J8492571135",
              "SDK_Setting_5434885",
              width: maxWidth,
              height: maxHeight,
              freeEpisodesCount: 2,
              unlockEpisodesCountUsingAD: 2,
              // 加载自己的激励广告，posId为自己的广告位id，adType： 告知是哪种广告类型
              posId: 'KS90010001',
              adType: IOSZJPlayletADType.rewardVideoAd.index,
              onPlayletListener: (ret) {
                print('短剧====${ret.action}');
              },
            );
          },
        ),
      ),
    );
  }
}
