enum IosZjEventType {

  /// 未知
  unknown(-1),

  /// 初始化
  init(0),

  /// 开屏
  splash(1),

  /// 激励
  rewardVideo(2),

  /// 插屏
  interstitial(3),

  /// 横幅
  banner(4),

  /// 信息流
  nativeExpress(5),

  /// 视频流
  drawAd(6),

  /// 视频内容
  contentAd(7),

  /// 新闻资讯
  newsAd(8),

  /// H5插件
  h5Page(9),

  /// 短剧
  tubeAd(10);

  const IosZjEventType(this.val);

  final int val;

  static IosZjEventType parse(int val) =>
      IosZjEventType.values.firstWhere((type) => type.val == val,
          orElse: () => IosZjEventType.unknown);
}
