import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zjsdk_flutter/event/ios_zj_event.dart';
import 'package:zjsdk_flutter/zjsdk_message_channel.dart';

class IosZjNativeExpressView extends StatelessWidget {
  /// 广告位ID
  final String posId;

  /// 加载广告的数量，默认为1
  final int adCount;

  /// 宽
  final double width;

  /// 高
  final double height;

  /// 是否静音
  final bool mutedIfCan;

  /// 回调
  final Function(IosZjEvent ret)? nativeExpressListener;

  const IosZjNativeExpressView(this.posId,
      {required this.width,
      required this.height,
      this.adCount = 1,
      this.mutedIfCan = true,
      this.nativeExpressListener,
      super.key});

  @override
  Widget build(BuildContext context) {
    Widget adView;
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      adView = UiKitView(
        viewType: "ios_zjsdk_flutter_plugin/nativeExpress",
        creationParams: {
          "posId": posId,
          "width": width,
          "height": height,
          "mutedIfCan": mutedIfCan,
          "adCount": adCount,
        },
        creationParamsCodec: JSONMessageCodec(),
        onPlatformViewCreated: _onPlatformViewCreated,
      );
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
    ZjsdkMessageChannel.addNativeExpressListener(id, nativeExpressListener);
  }
}
