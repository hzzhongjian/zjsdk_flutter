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
  onContentTaskCompleteAction("onContentTaskComplete"),

  /// 内容加载成功
  onContentLoadSuccess("onContentLoadSuccess"),

  /// 内容加载失败
  onContentLoadFailure("onContentLoadFailure"),
  
  /// 短剧开始解锁
  onUnlockFlowStart("onUnlockFlowStart"),
  
  /// 短剧解锁取消
  onUnlockFlowCancel("onUnlockFlowCancel"),

  /// 短剧解锁结束
  onUnlockFlowEnd("onUnlockFlowEnd"),

  /// 点击混排中进入跳转播放页的按钮 
  onPlayletClickEnterView("onPlayletClickEnterView"),

  /// 本剧集观看完毕，切到下一部短剧回调
  onPlayletNextPlayletWillPlay("onPlayletNextPlayletWillPlay"),

  /// 视频切换时的回调
  onCurrentVideoChanged("onCurrentVideoChanged"),

  /// 加载失败按钮点击重试回调
  onDidClickedErrorButtonRetry("onDidClickedErrorButtonRetry"),

  /// 默认关闭按钮被点击的回调
  onPlayletCloseButtonClicked("onPlayletCloseButtonClicked"),

  /// 数据刷新完成回调
  onDataRefreshCompletion("onDataRefreshCompletion"),

  /// tab栏切换控制器的回调
  onViewControllerSwitchToIndex("onViewControllerSwitchToIndex"),

  ;

  const IosZjEventAction(this.action);

  final String action;

  static IosZjEventAction parse(String action) =>
      IosZjEventAction.values.firstWhere((event) => event.action == action,
          orElse: () => IosZjEventAction.unknown);
}
