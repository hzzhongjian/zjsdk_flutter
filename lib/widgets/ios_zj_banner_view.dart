import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zjsdk_flutter/event/ios_zj_event.dart';
import 'package:zjsdk_flutter/zjsdk_message_channel.dart';


class IosZjBannerView extends StatelessWidget {
  /// 广告位ID
  final String posId;

  /// 自刷新频率，单位s，仅部分生效，0时不刷新
  final int refreshInterval;

  /// 宽
  final double width;

  /// 高
  final double height;

  /// 回调
  final Function(IosZjEvent ret)? bannerListener;

  const IosZjBannerView(this.posId,
      {required this.width,
      required this.height,
      this.refreshInterval = 0,
      this.bannerListener,
      super.key});

  @override
  Widget build(BuildContext context) {
    Widget adView;
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      adView = UiKitView(
        viewType: "ios_zjsdk_flutter_plugin/banner",
        creationParams: {
          "posId": posId,
          "width": width,
          "height": height,
          "interval": refreshInterval
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
    ZjsdkMessageChannel.addBannerListener(id, bannerListener);
  }
}
