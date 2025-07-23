class IosZJCustomController {
  /// 是否允许SDK使用定位权限
  final bool canUseLocation;

  /// 是否允许SDK使用WiFi BSSID
  final bool canUseWiFiBSSID;

  /// 是否允许SDK获取IDFA
  final bool canUseIDFA;

  /// 是否允许SDK获取IDFV
  final bool canUseIDFV;

  /// 是否允许获取手机状态信息
  final bool canUsePhoneStatus;

  /// 收否允许获取手机DeviceId
  final bool canUseDeviceId;

  /// 是否允许获取手机系统版本名
  final bool canUseOSVersionName;

  /// 是否允许获取手机系统版本号
  final bool canUseOSVersionCode;

  /// 是否允许获取手机应用包名
  final bool canUsePackageName;

  /// 是否允许获取手机应用版本名
  final bool canUseAppVersionName;

  /// 是否允许获取手机应用版本号
  final bool canUseAppVersionCode;

  /// 是否允许获取手机设备品牌
  final bool canUseBrand;

  /// 是否允许获取手机设备型号
  final bool canUseModel;

  /// 是否允许获取手机屏幕分辨率
  final bool canUseScreen;

  /// 是否允许获取手机屏幕方向
  final bool canUseOrient;

  /// 是否允许获取手机网络类型
  final bool canUseNetworkType;

  /// 是否允许获取手机移动网络代码
  final bool canUseMNC;

  /// 是否允许获取手机移动国家代码
  final bool canUseMCC;

  /// 是否允许获取手机系统语言
  final bool canUseOSLanguage;

  /// 是否允许获取手机时区
  final bool canUseTimeZone;

  /// 是否允许获取手机User Agent
  final bool canUseUserAgent;

  /// 是否允许SDK主动使用互动组件能力（摇一摇、扭一扭等）
  final bool isCanUseMotionManager;

  IosZJCustomController({
    this.canUseLocation = true,
    this.canUseWiFiBSSID = true,
    this.canUseIDFA = true,
    this.canUseIDFV = true,
    this.canUsePhoneStatus = true,
    this.canUseDeviceId = true,
    this.canUseOSVersionName = true,
    this.canUseOSVersionCode = true,
    this.canUsePackageName = true,
    this.canUseAppVersionName = true,
    this.canUseAppVersionCode = true,
    this.canUseBrand = true,
    this.canUseModel = true,
    this.canUseScreen = true,
    this.canUseOrient = true,
    this.canUseNetworkType = true,
    this.canUseMNC = true,
    this.canUseMCC = true,
    this.canUseOSLanguage = true,
    this.canUseTimeZone = true,
    this.canUseUserAgent = true,
    this.isCanUseMotionManager = true,
  });

  toMap() {
    return {
      'canUseLocation' : canUseLocation,
      'canUseWiFiBSSID' : canUseWiFiBSSID,
      'canUseIDFA' : canUseIDFA,
      'canUseIDFV' : canUseIDFV,
      'canUsePhoneStatus' : canUsePhoneStatus,
      'canUseDeviceId' : canUseDeviceId,
      'canUseOSVersionName' : canUseOSVersionName,
      'canUseOSVersionCode' : canUseOSVersionCode,
      'canUsePackageName' : canUsePackageName,
      'canUseAppVersionName' : canUseAppVersionName,
      'canUseAppVersionCode' : canUseAppVersionCode,
      'canUseBrand' : canUseBrand,
      'canUseModel' : canUseModel,
      'canUseScreen' : canUseScreen,
      'canUseOrient' : canUseOrient,
      'canUseNetworkType' : canUseNetworkType,
      'canUseMNC' : canUseMNC,
      'canUseMCC' : canUseMCC,
      'canUseOSLanguage' : canUseOSLanguage,
      'canUseTimeZone' : canUseTimeZone,
      'canUseUserAgent' : canUseUserAgent,
      'isCanUseMotionManager' : isCanUseMotionManager
    };
  }
}
