import 'package:zjsdk_flutter/event/ios_zj_event_action.dart';
import 'package:zjsdk_flutter/event/ios_zj_event_type.dart';

class IosZjEvent {
  /// 广告类型
  final IosZjEventType type;

  /// PlatformView的id，用于定位View
  final int viewId;

  /// 事件
  final IosZjEventAction action;

  /// 错误码
  final int code;

  /// 错误消息
  final String? msg;

  /// 额外信息
  final String? extra;

  IosZjEvent(this.type, this.action, {required this.code, this.msg, this.extra, required this.viewId});

  /// 解析事件
  static IosZjEvent parse(dynamic message) {
    IosZjEventType type = IosZjEventType.unknown;
    IosZjEventAction action = IosZjEventAction.unknown;
    int code = 0;
    String? msg;
    String? extra;
    int id = 0;

    Map<String, dynamic>? ret = (message as Map<String, dynamic>?);
    if (ret != null) {
      // type = (ret["type"] as int).toEventType;
      type = IosZjEventType.parse(ret["type"] as int);
      id = ret["viewId"] ?? 0;
      // action = (ret["action"] as String).toEventAction;
      action = IosZjEventAction.parse((ret["action"] as String));
      code = ret["code"] ?? 0;
      msg = ret["msg"];
      extra = ret["extra"];
    }
    return IosZjEvent(type, action,
        code: code, msg: msg, extra: extra, viewId: id);
  }
}
