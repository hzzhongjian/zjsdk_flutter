import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zjsdk_flutter/event/ios_zj_event.dart';
import 'package:zjsdk_flutter/zjsdk_message_channel.dart';

enum IOSZJPlayletADType {
  interstitial,
  rewardVideoAd,
}

class IosZjPlayletView extends StatelessWidget {
  /// 短剧的广告位ID
  final String adId;

  /// 展示的宽度
  final double width;

  /// 展示的高度
  final double height;

  /// json的名字
  final String jsonConfigPath;

  /// 免费观看的集数n
  final int freeEpisodesCount;

  /// 观看一次激励视频解锁的集数m
  final int unlockEpisodesCountUsingAD;

  /// 隐藏点赞
  final bool hideLikeIcon;

  /// 隐藏收藏
  final bool hideCollectIcon;

  /// 禁用双击点赞
  final bool disableDoubleClickLike;

  /// 禁用长按倍速
  final bool disableLongPressSpeed;

  /// 短剧中激励视频/插屏的广告位ID
  final String? posId;

  /// 短剧中激励视频/插屏的广告类型
  final int? adType;

  final void Function(IosZjEvent ret)? onPlayletListener;

  IosZjPlayletView(this.adId, this.jsonConfigPath,
      {required this.width,
      required this.height,
      required this.freeEpisodesCount,
      required this.unlockEpisodesCountUsingAD,
      this.hideLikeIcon = false,
      this.hideCollectIcon = false,
      this.disableDoubleClickLike = false,
      this.disableLongPressSpeed = false,
      this.posId,
      this.adType,
      this.onPlayletListener,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget adView;
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      adView = UiKitView(
        viewType: "ios_zjsdk_flutter_plugin/playletAd",
        creationParams: {
          "adId": adId,
          "JSONConfigPath": jsonConfigPath,
          "width": width,
          "height": height,
          "freeEpisodesCount": freeEpisodesCount,
          "unlockEpisodesCountUsingAD": unlockEpisodesCountUsingAD,
          "hideLikeIcon": hideLikeIcon,
          "hideCollectIcon": hideCollectIcon,
          "disableDoubleClickLike": disableDoubleClickLike,
          "disableLongPressSpeed": disableLongPressSpeed,
          "posId": posId ?? "",
          "adType": adType ?? 0
        },
        creationParamsCodec: const JSONMessageCodec(),
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
    ZjsdkMessageChannel.setTubeAdListener(onPlayletListener);
  }
}
