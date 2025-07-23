import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:zjsdk_flutter/event/ios_zj_event.dart';
import 'package:zjsdk_flutter/event/ios_zj_event_action.dart';
import 'package:zjsdk_flutter/event/ios_zj_event_type.dart';

class ZjsdkMessageChannel {
  static final ZjsdkMessageChannel _instance = ZjsdkMessageChannel();

  static const _sdkMessageChannel = BasicMessageChannel(
      'ios_zjsdk_flutter_plugin/sdk_message', JSONMessageCodec());

  /// 初始化回调
  Function(IosZjEvent ret)? _initListener;

  /// 开屏回调
  Function(IosZjEvent ret)? _splashListener;

  /// 激励视频回调
  Function(IosZjEvent ret)? _rewardVideoListener;

  /// 插全屏广告回调
  Function(IosZjEvent ret)? _interstitialListener;

  /// 横幅广告回调
  static final HashMap<int, Function(IosZjEvent ret)?> _bannerListenerMap =
      HashMap();

  /// 信息流广告回调
  static final HashMap<int, Function(IosZjEvent ret)?>
      _nativeExpressListenerMap = HashMap();

  /// 视频流广告回调
  static final HashMap<int, Function(IosZjEvent ret)?> _drawAdListenerMap =
      HashMap();

  /// 视频内容回调
  Function(IosZjEvent ret)? _contentAdListener;

  /// 新闻资讯回调
  Function(IosZjEvent ret)? _newsAdListener;

  /// H5回调
  Function(IosZjEvent ret)? _h5PageListener;

  /// 短剧回调
  Function(IosZjEvent ret)? _tubeAdListener;

  ZjsdkMessageChannel() {
    _sdkMessageChannel.setMessageHandler((dynamic message) => Future(() {
          // debugPrint('flutter端收到原生发送的消息了================$message');
          IosZjEvent event = IosZjEvent.parse(message);
          switch (event.type) {
            case IosZjEventType.init:
              onInit(event);
              break;
            case IosZjEventType.splash:
              onSplash(event);
              break;
            case IosZjEventType.rewardVideo:
              onRewardVideo(event);
              break;
            case IosZjEventType.interstitial:
              onInterstitial(event);
              break;
            case IosZjEventType.banner:
              onBanner(event);
              break;
            case IosZjEventType.nativeExpress:
              onNativeExpress(event);
              break;
            case IosZjEventType.drawAd:
              onDrawAd(event);
              break;
            case IosZjEventType.contentAd:
              onContentAd(event);
              break;
            case IosZjEventType.newsAd:
              onNewsAd(event);
              break;
            case IosZjEventType.h5Page:
              onH5Page(event);
              break;
            case IosZjEventType.tubeAd:
              onTubeAd(event);
              break;
            case IosZjEventType.unknown:
              if (kDebugMode) {
                print("onUnknownEvent:$event");
              }
              break;
          }
          return "";
        }));
  }

  /// 配置初始化回调
  /// [onInitSuccess] 初始化成功的回调
  /// [onInitFailed] 初始化失败的回调
  static void init(Function(IosZjEvent ret)? initListener) {
    _instance._initListener = initListener;
    // _sdkMessageChannel.send({'id': 'hello,world'});
  }

  /// 初始化回调
  void onInit(IosZjEvent event) {
    _initListener?.call(event);
    _initListener = null;
  }

  /// 配置开屏回调
  static void setSplashListener(Function(IosZjEvent ret)? splashListener) {
    _instance._splashListener = splashListener;
  }

  /// 开屏事件回调
  void onSplash(IosZjEvent event) {
    _splashListener?.call(event);
    tryDestroyListener(event, _splashListener);
  }

  /// 配置激励视频回调
  static void setRewardVideoListener(
      Function(IosZjEvent ret)? rewardVideoListener) {
    _instance._rewardVideoListener = rewardVideoListener;
  }

  /// 激励视频回调
  void onRewardVideo(IosZjEvent event) {
    _rewardVideoListener?.call(event);
    tryDestroyListener(event, _rewardVideoListener);
  }

  /// 配置插全屏回调
  static void setInterstitialListener(
      Function(IosZjEvent ret)? interstitialListener) {
    _instance._interstitialListener = interstitialListener;
  }

  /// 插全屏回调
  void onInterstitial(IosZjEvent event) {
    _interstitialListener?.call(event);
    tryDestroyListener(event, _interstitialListener);
  }

  /// 添加横幅广告回调
  static void addBannerListener(
      int id, Function(IosZjEvent ret)? bannerListener) {
    _bannerListenerMap[id] = bannerListener;
  }

  /// 横幅广告事件回调
  void onBanner(IosZjEvent event) {
    int id = event.viewId;
    if (_bannerListenerMap.containsKey(id)) {
      Function(IosZjEvent)? listener = _bannerListenerMap[id];
      listener?.call(event);
      if (event.action == IosZjEventAction.onAdError ||
          event.action == IosZjEventAction.onAdClose) {
        _bannerListenerMap.remove(id);
      }
    }
  }

  /// 添加信息流广告回调
  static void addNativeExpressListener(
      int id, Function(IosZjEvent ret)? nativeExpressListener) {
    _nativeExpressListenerMap[id] = nativeExpressListener;
  }

  /// 信息流事件回调
  void onNativeExpress(IosZjEvent event) {
    int id = event.viewId;
    if (_nativeExpressListenerMap.containsKey(id)) {
      Function(IosZjEvent)? listener = _nativeExpressListenerMap[id];
      listener?.call(event);
      if (event.action == IosZjEventAction.onAdError ||
          event.action == IosZjEventAction.onAdClose) {
        _nativeExpressListenerMap.remove(id);
      }
    }
  }

  /// 添加视频流广告回调
  static void addDrawAdListener(
      int id, Function(IosZjEvent ret)? drawAdListener) {
    _drawAdListenerMap[id] = drawAdListener;
  }

  /// 视频流事件回调
  void onDrawAd(IosZjEvent event) {
    int id = event.viewId;
    if (_drawAdListenerMap.containsKey(id)) {
      Function(IosZjEvent)? listener = _drawAdListenerMap[id];
      if (event.action != IosZjEventAction.onAdClose) {
        // 视频流没有主动关闭事件，View回收时被动调用关闭，移除回调
        listener?.call(event);
      }
      if (event.action == IosZjEventAction.onAdError ||
          event.action == IosZjEventAction.onAdClose) {
        _drawAdListenerMap.remove(id);
      }
    }
  }

  /// 配置视频内容回调
  static void setContentAdListener(
      Function(IosZjEvent ret)? contentAdListener) {
    _instance._contentAdListener = contentAdListener;
  }

  /// 视频内容回调
  void onContentAd(IosZjEvent event) {
    _contentAdListener?.call(event);
    tryDestroyListener(event, _contentAdListener);
  }

  /// 配置新闻资讯回调
  static void setNewsAdListener(Function(IosZjEvent ret)? newsAdListener) {
    _instance._newsAdListener = newsAdListener;
  }

  /// 新闻资讯回调
  void onNewsAd(IosZjEvent event) {
    _newsAdListener?.call(event);
    tryDestroyListener(event, _newsAdListener);
  }

  /// 配置H5页面回调
  static void setH5PageListener(Function(IosZjEvent ret)? h5PageListener) {
    _instance._h5PageListener = h5PageListener;
  }

  /// H5页面回调
  void onH5Page(IosZjEvent event) {
    _h5PageListener?.call(event);
    tryDestroyListener(event, _h5PageListener);
  }

  /// 配置短剧回调
  static void setTubeAdListener(Function(IosZjEvent ret)? tubeAdListener) {
    _instance._tubeAdListener = tubeAdListener;
  }

  /// 短剧页面回调
  void onTubeAd(IosZjEvent event) {
    if (_tubeAdListener == null) {
      _sdkMessageChannel.send(true);
    } else {
      _tubeAdListener!.call(event);
    }
    tryDestroyListener(event, _tubeAdListener);
  }

  /// 销毁回调对象
  void tryDestroyListener(IosZjEvent event, dynamic listener) {
    /// 当前加载已结束
    if (event.action == IosZjEventAction.onAdError ||
        event.action == IosZjEventAction.onAdClose) {
      listener = null;
    }
  }
}
