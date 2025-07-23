import 'package:flutter/material.dart';
import 'package:zjsdk_flutter/event/ios_zj_event_action.dart';
import 'package:zjsdk_flutter/widgets/ios_zj_feed_full_video_view.dart';

class FeedFullVideoPage extends StatefulWidget {
  const FeedFullVideoPage({super.key});

  @override
  State<FeedFullVideoPage> createState() => _FeedFullVideoPageState();
}

class _FeedFullVideoPageState extends State<FeedFullVideoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('视频流广告')),
      body: Center(
        child: LayoutBuilder(
          builder: (context, constrainer) {
            double maxWidth = constrainer.maxWidth;
            double maxHeight = constrainer.maxHeight;
            return IosZjFeedFullVideoView(
              "J2395763699",
              width: maxWidth,
              height: maxHeight,
              drawAdListener: (ret) {
                switch (ret.action) {
                  case IosZjEventAction.onAdLoaded:
                    print('视频流广告加载了');
                    break;
                  case IosZjEventAction.onAdError:
                    print('视频流广告错误');
                    break;
                  case IosZjEventAction.onAdShow:
                    print('视频流广告曝光');
                    break;
                  case IosZjEventAction.onAdClick:
                    print("视频流广告点击");
                    break;
                  case IosZjEventAction.onAdPlayFinish:
                    print("视频流广告播放完毕");
                    break;
                  case IosZjEventAction.onAdOpenOtherController:
                    print("视频流广告详情页打开");
                    break;
                  case IosZjEventAction.onAdCloseOtherController:
                    print("视频流广告详情页关闭");
                    break;
                  default:
                }
              },
            );
          },
        ),
      ),
    );
  }
}
