enum IosZjEventAction {
  /// 未知
  unknown("unknown"),

  /// 初始化成功
  initSuccess("onInitSuccess"),

  /// 初始化失败
  initFailed("onInitFailed"),

  /// 启动成功
  startSuccess("onStartSuccess"),

  /// 启动失败
  startFailed("onStartFailed"),

  /// 广告出错
  onAdError("onAdError"),

  /// 展示成功
  onAdLoaded("onAdLoaded"),

  /// 广告展示
  onAdShow("onAdShow"),

  /// 广告点击
  onAdClick("onAdClick"),

  /// 获得奖励
  onAdRewardVerify("onAdReward"),

  /// 广告关闭
  onAdClose("onAdClose"),

  /// 广告播放完成
  onAdPlayFinish("onAdPlayFinish"),

  /// 打开落地页
  onAdOpenOtherController("onAdOpenOtherController"),

  /// 关闭落地页
  onAdCloseOtherController("onAdCloseOtherController"),

  /// 倒计时结束
  onAdCountdownEnd("onAdCountdownEnd"),

  /// 点击跳过
  onAdClickSkip("onAdClickSkip"),

  /// 视频开始播放
  onVideoDidStartPlay("onVideoDidStartPlay"),

  /// 视频暂停播放
  onVideoDidPausePlay("onVideoDidPausePlay"),

  /// 视频恢复播放
  onVideoDidResumePlay("onVideoDidResumePlay"),

  /// 视频停止播放
  onVideoDidEndPlay("onVideoDidEndPlay"),

  /// 视频播放失败
  onVideoDidFailedToPlay("onVideoDidFailedToPlay"),

  /// 视频内容展示
  onContentDidFullDisplay("onContentDidFullDisplay"),

  /// 视频内容隐藏
  onContentDidEndDisplay("onContentDidEndDisplay"),

  /// 视频内容暂停显示
  onContentDidPause("onContentDidPause"),

  /// 视频内容恢复显示
  onContentDidResume("onContentDidResume"),

  /// 任务完成回调
  onContentTaskCompleteAction("onContentTaskComplete");

  const IosZjEventAction(this.action);

  final String action;

  static IosZjEventAction parse(String action) =>
      IosZjEventAction.values.firstWhere((event) => event.action == action,
          orElse: () => IosZjEventAction.unknown);
}
