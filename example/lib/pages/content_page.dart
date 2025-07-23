import 'package:flutter/material.dart';
import 'package:zjsdk_flutter/event/ios_zj_event_action.dart';
import 'package:zjsdk_flutter/widgets/ios_zj_content_ad_view.dart';

class ContentPage extends StatefulWidget {
  const ContentPage({super.key});

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('视频内容')),
      body: Center(
        child: LayoutBuilder(
          builder: (context, constrainer) {
            double maxWidth = constrainer.maxWidth;
            double maxHeight = constrainer.maxHeight;
            return IosZjContentAdView(
              "K90010005",
              width: maxWidth,
              height: maxHeight,
              contentAdListener: (ret) {
                switch (ret.action) {
                  case IosZjEventAction.onAdLoaded:
                    print('视频内容加载了');
                    break;
                  case IosZjEventAction.onAdError:
                    print('视频内容报错');
                    break;
                  case IosZjEventAction.onAdCloseOtherController:
                    print('视频内容详情页关闭');
                    break;
                  case IosZjEventAction.onVideoDidStartPlay:
                    print('视频内容开始播放');
                    break;
                  case IosZjEventAction.onVideoDidPausePlay:
                    print('视频内容暂停播放');
                    break;
                  case IosZjEventAction.onVideoDidResumePlay:
                    print('视频内容恢复播放');
                    break;
                  case IosZjEventAction.onVideoDidEndPlay:
                    print('视频内容停止播放');
                    break;
                  case IosZjEventAction.onVideoDidFailedToPlay:
                    print('视频内容播放失败');
                    break;
                  case IosZjEventAction.onContentDidFullDisplay:
                    print('视频内容内容展示');
                    break;
                  case IosZjEventAction.onContentDidEndDisplay:
                    print('视频内容内容隐藏');
                    break;
                  case IosZjEventAction.onContentDidPause:
                    print('视频内容内容暂停显示');
                    break;
                  case IosZjEventAction.onContentDidResume:
                    print('视频内容内容恢复显示');
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
