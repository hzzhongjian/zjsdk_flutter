import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zjsdk_flutter/event/ios_zj_event.dart';
import 'package:zjsdk_flutter/zjsdk_message_channel.dart';

class IosZjNewsView extends StatelessWidget {
  /// 广告位ID
  final String posId;

  /// 用户ID
  final String userId;

  /// 宽
  final double width;

  /// 高
  final double height;

  /// 回调
  final Function(IosZjEvent ret)? newsAdListener;

  const IosZjNewsView(this.posId,
      {required this.width,
      required this.height,
      this.userId = "",
      this.newsAdListener,
      super.key});

  @override
  Widget build(BuildContext context) {
    Widget adView;
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      adView = UiKitView(
          viewType: "ios_zjsdk_flutter_plugin/newsAd",
          creationParams: {
            "posId": posId,
            "width": width,
            "height":height,
            "userId": userId
          },
          creationParamsCodec: JSONMessageCodec(),
          onPlatformViewCreated: _onPlatformViewCreated);
    } else {
      adView = Text("Platform of $defaultTargetPlatform not support.");
    }
    return Container(
      width: width,
      height: height,
      child: adView,
    );
  }

  void _onPlatformViewCreated(int id) {
    ZjsdkMessageChannel.setNewsAdListener(newsAdListener);
  }
}
