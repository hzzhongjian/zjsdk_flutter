import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zjsdk_flutter/event/ios_zj_event.dart';
import 'package:zjsdk_flutter/zjsdk_message_channel.dart';

class IosZjFeedFullVideoView extends StatelessWidget {
  /// 广告位ID
  final String posId;

  /// 请求广告个数
  final int adCount;

  /// 宽
  final double width;

  /// 高
  final double height;

  /// 回调
  final Function(IosZjEvent ret)? drawAdListener;

  const IosZjFeedFullVideoView(this.posId,
      {required this.width,
      required this.height,
      this.adCount = 1,
      this.drawAdListener,
      super.key});

  @override
  Widget build(BuildContext context) {
    Widget adView;
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      adView = UiKitView(
        viewType: "ios_zjsdk_flutter_plugin/feedFullVideo",
        creationParams: {
          "posId": posId,
          "width": width,
          "height": height,
          "adCount": adCount
        },
        creationParamsCodec: JSONMessageCodec(),
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    } else {
      adView = Text("Platform of $defaultTargetPlatform not support.");
    }
    return Container(
      height: height,
      child: adView,
    );
  }

  void _onPlatformViewCreated(int id) {
    ZjsdkMessageChannel.addDrawAdListener(id, drawAdListener);
  }
}
