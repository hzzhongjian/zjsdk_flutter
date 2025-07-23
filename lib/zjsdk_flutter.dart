import 'package:flutter/services.dart';
import 'package:zjsdk_flutter/event/ios_zj_event.dart';
import 'package:zjsdk_flutter/ios_custom_controller.dart';
import 'package:zjsdk_flutter/zjsdk_message_channel.dart';

class ZjsdkFlutter {
  static const MethodChannel _sdkMethodChannel =
      MethodChannel('ios_zjsdk_flutter_plugin/sdk_method');

  /// 获取ZJSDK版本号
  static Future<String?> get sdkVersion async {
    final String? version =
        await _sdkMethodChannel.invokeMethod('getSdkVersion');
    return version;
  }

  /// 配置个性化推荐开关
  /// [state] 是否开启推荐
  static void setPersonalRecommend(bool state) {
    _sdkMethodChannel.invokeMethod("setPersonalRecommend", {"state": state});
  }

  /// 配置程序化推荐开关
  /// [state] 是否开启推荐
  static void setProgrammaticRecommend(bool state) {
    _sdkMethodChannel
        .invokeMethod("setProgrammaticRecommend", {"state": state});
  }

  /// 初始化SDK
  static void registerAppId(
      String appId, Function(IosZjEvent ret)? initListener,
      {IosZJCustomController? customController}) {
    ZjsdkMessageChannel.init(initListener);
    if (customController != null) {
      _sdkMethodChannel.invokeMethod("registerAppId",
          {"appId": appId, "customController": customController.toMap()});
    } else {
      _sdkMethodChannel.invokeMethod("registerAppId", {"appId": appId});
    }
  }

  /// 开屏广告
  static void loadSplashAd(
      String posId, Function(IosZjEvent ret)? splashListener) {
    ZjsdkMessageChannel.setSplashListener(splashListener);
    _sdkMethodChannel.invokeMethod("splash", {"posId": posId});
  }

  /// 插屏广告
  static void loadInterstitialAd(
      String posId, Function(IosZjEvent ret)? interstitialListener,
      {bool mutedIfCan = true, Size? adSize}) {
    ZjsdkMessageChannel.setInterstitialListener(interstitialListener);
    _sdkMethodChannel.invokeMethod("interstitial", {
      "posId": posId,
      "mutedIfCan": mutedIfCan,
      "adWidth": adSize?.width,
      "adHeight": adSize?.height
    });
  }

  /// 激励广告
  static void loadRewardVideoAd(String posId, String userId,
      Function(IosZjEvent ret)? rewardVideoListener,
      {String? rewardName, int? rewardAmount, String? extra}) {
    ZjsdkMessageChannel.setRewardVideoListener(rewardVideoListener);
    _sdkMethodChannel.invokeMethod("Reward", {
      "posId": posId,
      "userId": userId,
      "reward_name": rewardName ?? "",
      "reward_amount": rewardAmount ?? 0,
      "extra": extra ?? ""
    });
  }

  /// H5广告
  static void loadH5Ad(String posId, Function(IosZjEvent ret)? h5PageListener,
      {String? userId,
      String? userName,
      String? userAvatar,
      int? userIntegral,
      String? extra}) {
    ZjsdkMessageChannel.setH5PageListener(h5PageListener);
    _sdkMethodChannel.invokeMethod("h5Page", {
      "posId" : posId,
      "userId" : userId ?? "",
      "userName" : userName ?? "",
      "userAvatar" : userAvatar ?? "",
      "userIntegral" : userIntegral ?? 0,
      "extra" : extra ?? ""
    });
  }

  /// 新闻资讯
  static void loadNewsAd(String posId, Function(IosZjEvent ret)? newsAdListener, {String? userId}) {
    ZjsdkMessageChannel.setNewsAdListener(newsAdListener);
    _sdkMethodChannel.invokeMethod("newsAd", {
      "posId" : posId,
      "userId" : userId ?? ""
    });
  }
}
