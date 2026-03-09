// 竞胜失败原因

enum IosZjExposureFailureCode {
  Other(0), // 其他
  MediaBasePriceFilter(1), // 媒体侧底价过滤
  BidFailed(2), // 广告竞价失败
  CacheInvalid(3), // 缓存失效
  PriorityReduce(4), // 曝光优先级降低
  ReturnTimeout(5), // 返回超时
  MediaBlocking(6), // 媒体屏蔽
  ;

  final int value;
  const IosZjExposureFailureCode(this.value);
}

// 竞胜平台类型
enum IosZjExposureAdnType {
  KS(1), //输给快手联盟其他广告
  Other(2), //输给其他ADN
  SelfSale(3); //输给自售广告主

  final int value;
  const IosZjExposureAdnType(this.value);
}

// 竞胜方广告物料类型
enum IosZjExposureAdnMaterialType {
  HorizontalImg(1),
  VerticalImg(2),
  HorizontalVideo(3),
  VerticalVideo(4),
  ThreeImg(5),
  Streamer(6),
  Other(7);

  final int value;

  const IosZjExposureAdnMaterialType(this.value);
}

enum IosZjADNName {
  Chuanshanjia("CSJ"),
  Guangdiantong("GDT"),
  Baidu("BaiDu"),
  KS("KuaiShou"),
  SIGMOB("Sigmob"),
  OCTOPUS("OCTOPUS"),
  QuMeng("QuMeng"),
  BeiZi("BeiZi"),
  Other("Other"),
  ;

  final String adnName;

  const IosZjADNName(this.adnName);
}

enum IosZjBiddingActionType {
  None(0),
  Success(1),
  Unkown(2),
  ;

  final int value;

  const IosZjBiddingActionType(this.value);
}

class IosZjBidInfo {
  //曝光失败原因类型
  IosZjExposureFailureCode? failureCode;

  // 胜出者的ecpm报价
  int? winEcpm;

  // 竞胜平台类型
  IosZjExposureAdnType? adnType;

  // 竞胜平台名称，adnType=KSAdExposureAdnTypeOther时可以设置
  IosZjADNName? adnName;

  // 竞胜方dsp的广告主名称
  String? adUserName;

  // 竞胜方广告物料类型
  IosZjExposureAdnMaterialType? adnMaterialType;

  // 竞胜方广告素材url
  String? adnMaterialUrl;

  // 竞胜方的广告主标题
  String? adTitle;

  // 竞胜方dsp本次请求是否展示
  IosZjBiddingActionType? isShow;

  // 竞胜方dsp本次pv是否被点击
  IosZjBiddingActionType? isClick;

  Map<String, dynamic> toJson() {
    return {
      "failureCode": failureCode ?? IosZjExposureFailureCode.Other.value,
      "winEcpm": winEcpm ?? 0,
      "adnType": adnType ?? IosZjExposureAdnType.Other.value,
      "adnName": adnName ?? IosZjADNName.Other.adnName,
      "adUserName": adUserName ?? "",
      "adnMaterialType":
          adnMaterialType ?? IosZjExposureAdnMaterialType.Other.value,
      "adnMaterialUrl": adnMaterialUrl ?? "",
      "adTitle": adTitle ?? "",
      "isShow": isShow ?? IosZjBiddingActionType.None.value,
      "isClick": isClick ?? IosZjBiddingActionType.None.value,
    };
  }
}
