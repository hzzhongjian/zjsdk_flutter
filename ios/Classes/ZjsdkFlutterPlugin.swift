import Flutter
import UIKit
import ZJSDK
import ZJSDKCore


public class ZjsdkFlutterPlugin: NSObject, FlutterPlugin {
    
    static let sharedInstance: ZjsdkFlutterPlugin = ZjsdkFlutterPlugin()
    
    var splashAdWrapper: ZJSplashAdWrapper?
    
    var interstitialAdWrapper: ZJInterstitialAdWrapper?
    
    var rewardVideoAdWrapper: ZJRewardVideoAdWrapper?
    
    var h5AdWrapper: ZJH5AdWrapper?
    
    static var _messsgeChannel: FlutterBasicMessageChannel?
    
    private override init() {
        
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
//        banner
        let bannerAdFactory: ZJBannerAdPlatformViewFactory = ZJBannerAdPlatformViewFactory.init(registrar: registrar)
        registrar.register(bannerAdFactory, withId: "ios_zjsdk_flutter_plugin/banner")
//        信息流
        let nativeExpressPlatformViewFactory: ZJNativeExpressPlatformViewFactory = ZJNativeExpressPlatformViewFactory.init(registrar: registrar)
        registrar.register(nativeExpressPlatformViewFactory, withId: "ios_zjsdk_flutter_plugin/nativeExpress")
//        视频流
        let feedFullVideoPlatformViewFactory: ZJFeedFullVideoPlatformViewFactory = ZJFeedFullVideoPlatformViewFactory.init(registrar: registrar)
        registrar.register(feedFullVideoPlatformViewFactory, withId: "ios_zjsdk_flutter_plugin/feedFullVideo")
//        视频内容
        let contentAdPlatformViewFactory: ZJContentAdPlatformViewFactory = ZJContentAdPlatformViewFactory.init(registrar: registrar)
        registrar.register(contentAdPlatformViewFactory, withId: "ios_zjsdk_flutter_plugin/contentAd")
//        短剧
        let playletAdPlatformFactory: ZJPlayletAdPlatformViewFactory = ZJPlayletAdPlatformViewFactory.init(registrar: registrar)
        registrar.register(playletAdPlatformFactory, withId: "ios_zjsdk_flutter_plugin/playletAd")
        
        let channel = FlutterMethodChannel(name: "ios_zjsdk_flutter_plugin/sdk_method", binaryMessenger: registrar.messenger())
        let instance = ZjsdkFlutterPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
        
        _messsgeChannel = FlutterBasicMessageChannel(name: "ios_zjsdk_flutter_plugin/sdk_message", binaryMessenger: registrar.messenger(), codec: FlutterJSONMessageCodec.sharedInstance())
        
    }
    
    @objc public static func sendMessage(type: UInt, action: String, viewId: Int, code: UInt, msg: String, extra: String) {
        var params = Dictionary<String, Any>()
        params.updateValue(type, forKey: ZJSDKFlutterPluginTypeKey)
        params.updateValue(viewId, forKey: ZJSDKFlutterPluginViewIdKey)
        params.updateValue(action, forKey: ZJSDKFlutterPluginActionKey)
        params.updateValue(code, forKey: ZJSDKFlutterPluginCodeKey)
        params.updateValue(msg, forKey: ZJSDKFlutterPluginMsgKey)
        params.updateValue(extra, forKey: ZJSDKFlutterPluginExtraKey)
        ZjsdkFlutterPlugin._messsgeChannel?.sendMessage(params)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getSdkVersion":
            result(ZJAdSDK.sdkVersion())
        case "setPersonalRecommend":
            setPersonalRecommend(call: call)
            result(nil)
        case "setProgrammaticRecommend":
            setProgrammaticRecommend(call: call)
            result(nil)
        case "registerAppId":
            registerSDK(call: call)
            result(nil)
        case "splash":
            loadSplashAd(call: call)
            result(nil)
        case "interstitial":
            loadInterstitialAd(call: call)
            result(nil)
        case "Reward":
            loadRewardAd(call: call)
            result(nil)
        case "h5Page":
            loadH5Ad(call: call)
            result(nil)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
//    MARK:配置个性化推荐开关
    func setPersonalRecommend(call: FlutterMethodCall) {
        let arguments = call.arguments as? Dictionary<String, Any> ?? [:]
        var state: ZJSDKPersionalizedState = .ON
        if !arguments.isEmpty && arguments["state"] as! Int != 1 {
            state = .OFF
        } else {
            state = .ON
        }
        ZJAdSDK.persionalizedState(state)
    }
    
//    MARK:配置程序化推荐开关
    func setProgrammaticRecommend(call: FlutterMethodCall) {
        let arguments = call.arguments as? Dictionary<String, Any> ?? [:]
        var state: ZJSDKProgrammaticRecommend = .ON
        if !arguments.isEmpty && arguments["state"] as! Int != 1 {
            state = .OFF
        } else {
            state = .ON
        }
        ZJAdSDK.programmaticRecommend(state)
    }
    
//    MARK:注册SDK
    func registerSDK(call: FlutterMethodCall) {
        let arguments = call.arguments as? Dictionary<String,Any> ?? [:]
        let appId: String = arguments["appId"] as? String ?? ""
        let privacyAuthorityModel = ZJSDKPrivacyAuthorityModel()
        let customController: Dictionary<String, Any> = arguments["customController"] as? Dictionary<String, Any> ?? [:]
        if !customController.isEmpty {
            let getBool: (String) -> Bool = { key in
                return (customController[key] as? Bool) ?? true
            }
            privacyAuthorityModel.canUseLocation = getBool("canUseLocation")
            privacyAuthorityModel.canUseWiFiBSSID = getBool("canUseWiFiBSSID")
            privacyAuthorityModel.canUseIDFA = getBool("canUseIDFA")
            privacyAuthorityModel.canUseIDFV = getBool("canUseIDFV")
            privacyAuthorityModel.canUsePhoneStatus = getBool("canUsePhoneStatus")
            privacyAuthorityModel.canUseDeviceId = getBool("canUseDeviceId")
            privacyAuthorityModel.canUseOSVersionName = getBool("canUseOSVersionName")
            privacyAuthorityModel.canUseOSVersionCode = getBool("canUseOSVersionCode")
            privacyAuthorityModel.canUsePackageName = getBool("canUsePackageName")
            privacyAuthorityModel.canUseAppVersionName = getBool("canUseAppVersionName")
            privacyAuthorityModel.canUseAppVersionCode = getBool("canUseAppVersionCode")
            privacyAuthorityModel.canUseBrand = getBool("canUseBrand")
            privacyAuthorityModel.canUseModel = getBool("canUseModel")
            privacyAuthorityModel.canUseScreen = getBool("canUseScreen")
            privacyAuthorityModel.canUseOrient = getBool("canUseOrient")
            privacyAuthorityModel.canUseNetworkType = getBool("canUseNetworkType")
            privacyAuthorityModel.canUseMNC = getBool("canUseMNC")
            privacyAuthorityModel.canUseMCC = getBool("canUseMCC")
            privacyAuthorityModel.canUseOSLanguage = getBool("canUseOSLanguage")
            privacyAuthorityModel.canUseTimeZone = getBool("canUseTimeZone")
            privacyAuthorityModel.canUseUserAgent = getBool("canUseUserAgent")
            privacyAuthorityModel.isCanUseMotionManager = getBool("isCanUseMotionManager")
            ZJSDKInitConfig.sharedInstance().privacyAuthorityModel = privacyAuthorityModel
        }
        if !appId.isEmpty {
            ZJAdSDK.registerAppId(appId) { completed, info in
                ZjsdkFlutterPlugin.sendMessage(type: ZJSDKFlutterPluginAdType.INIT.rawValue, action: completed ? ZJSDKFlutterPluginInitSuccessAction : ZJSDKFlutterPluginOnInitFailedAction, viewId: -1, code: (completed ? ZJSDKFlutterPluginCode.SUCCESS : ZJSDKFlutterPluginCode.FAILURE).rawValue, msg: ZJPlatformTool.map(toString: info), extra: "")
            }
        }
    }
    
//    MARK:SplashAd
    func loadSplashAd(call: FlutterMethodCall) {
        let arguments: Dictionary<String, Any> = call.arguments as? Dictionary<String, Any> ?? [:]
        let onBid: String = (arguments["OnBid"] as? String) ?? ""
        if !arguments.isEmpty && onBid == "success" {
            // 竞价成功
            if self.splashAdWrapper != nil {
                let bidEcpm: Int = (arguments["bidEcpm"] as? Int) ?? 0
                let hightestLossEcpm: Int = (arguments["hightestLossEcpm"] as? Int) ?? 0
                self.splashAdWrapper?.setBidEcpm(bidEcpm, highestLossEcpm: hightestLossEcpm)
            }
            return
        }
        
        if !arguments.isEmpty && onBid == "failed" {
            // 竞价失败
            let BidInfo = (arguments["BidInfo"] as? Dictionary<String, Any>) ?? [:]
            let failureCode = (BidInfo["failureCode"] as? Int) ?? 0
            self.splashAdWrapper?.reportAdExposureFailed(Int32(failureCode), reportParam: ZJPlatformTool.reportParam(BidInfo))
            return
        }
        
        let posId = arguments["posId"] as? String ?? ""
        self.splashAdWrapper = ZJSplashAdWrapper()
        //开屏加载成功回调
        self.splashAdWrapper?.splashAdDidLoad = { params in
            ZjsdkFlutterPlugin.sendMessage(type: ZJSDKFlutterPluginAdType.SPLASH.rawValue, action: ZJSDKFlutterPluginOnAdLoadedAction, viewId: -1, code: ZJSDKFlutterPluginCode.SUCCESS.rawValue, msg: "", extra: ZJPlatformTool.map(toString: params))
        }
        //开屏广告成功展示回调
        self.splashAdWrapper?.splashAdSuccessPresentScreen = {
            ZjsdkFlutterPlugin.sendMessage(type: ZJSDKFlutterPluginAdType.SPLASH.rawValue, action: ZJSDKFlutterPluginOnAdShowAction, viewId: -1, code: ZJSDKFlutterPluginCode.SUCCESS.rawValue, msg: "", extra: "")
        }
        //开屏广告点击回调
        self.splashAdWrapper?.splashAdClicked = {
            ZjsdkFlutterPlugin.sendMessage(type: ZJSDKFlutterPluginAdType.SPLASH.rawValue, action: ZJSDKFlutterPluginOnAdClickAction, viewId: -1, code: ZJSDKFlutterPluginCode.SUCCESS.rawValue, msg: "", extra: "")
        }
        //开屏广告将要关闭回调
        self.splashAdWrapper?.splashAdWillClosed = {
            
        }
        //开屏广告关闭回调
        self.splashAdWrapper?.splashAdClosed = {
            ZjsdkFlutterPlugin.sendMessage(type: ZJSDKFlutterPluginAdType.SPLASH.rawValue, action: ZJSDKFlutterPluginOnAdCloseAction, viewId: -1, code: ZJSDKFlutterPluginCode.SUCCESS.rawValue, msg: "", extra: "")
        }
        //应用进入后台时回调 详解: 当点击下载应用时会调用系统程序打开，应用切换到后台
        self.splashAdWrapper?.splashAdApplicationWillEnterBackground = {
            
        }
        //开屏广告倒记时结束回调
        self.splashAdWrapper?.splashAdCountdownEnd = {
            ZjsdkFlutterPlugin.sendMessage(type: ZJSDKFlutterPluginAdType.SPLASH.rawValue, action: ZJSDKFlutterPluginOnAdCountdownEndAction, viewId: -1, code: ZJSDKFlutterPluginCode.SUCCESS.rawValue, msg: "", extra: "")
        }
        //开屏广告错误回调
        self.splashAdWrapper?.splashAdError = { (error: Error) in
            let nsError = error as NSError
            ZjsdkFlutterPlugin.sendMessage(type: ZJSDKFlutterPluginAdType.SPLASH.rawValue, action: ZJSDKFlutterPluginOnAdErrorAction, viewId: -1, code: UInt(nsError.code), msg: nsError.convertJSONString(), extra: "")
        }
        //开屏广告播放错误
        self.splashAdWrapper?.splashAdDisplayError = { error in
            ZjsdkFlutterPlugin.sendMessage(type: ZJSDKFlutterPluginAdType.SPLASH.rawValue, action: ZJSDKFlutterPluginOnAdErrorAction, viewId: -1, code: ZJSDKFlutterPluginCode.SUCCESS.rawValue, msg: "", extra: "")
        }
        // 落地页打开
        self.splashAdWrapper?.splashAdDetailViewShow = {
            ZjsdkFlutterPlugin.sendMessage(type: ZJSDKFlutterPluginAdType.SPLASH.rawValue, action: ZJSDKFlutterPluginOnAdOpenOtherControllerAction, viewId: -1, code: ZJSDKFlutterPluginCode.SUCCESS.rawValue, msg: "", extra: "")
        }
        // 落地页关闭
        self.splashAdWrapper?.splashAdDetailViewClose = {
            ZjsdkFlutterPlugin.sendMessage(type: ZJSDKFlutterPluginAdType.SPLASH.rawValue, action: ZJSDKFlutterPluginOnAdCloseOtherControllerAction, viewId: -1, code: ZJSDKFlutterPluginCode.SUCCESS.rawValue, msg: "", extra: "")
        }
        
        self.splashAdWrapper?.loadSplashAd(withAdId: posId, fetchDelay: 5.0)
    }
    
//    MARK:InterstitialAd
    func loadInterstitialAd(call: FlutterMethodCall) {
        let arguments: Dictionary<String, Any> = call.arguments as? Dictionary<String, Any> ?? [:]
        let onBid: String = (arguments["OnBid"] as? String) ?? ""
        if !arguments.isEmpty && onBid == "success" {
            // 竞价成功
            if self.interstitialAdWrapper != nil {
                let bidEcpm: Int = (arguments["bidEcpm"] as? Int) ?? 0
                let hightestLossEcpm: Int = (arguments["hightestLossEcpm"] as? Int) ?? 0
                self.interstitialAdWrapper?.setBidEcpm(bidEcpm, highestLossEcpm: hightestLossEcpm)
            }
            return
        }
        
        if !arguments.isEmpty && onBid == "failed" {
            // 竞价失败
            let BidInfo = (arguments["BidInfo"] as? Dictionary<String, Any>) ?? [:]
            let failureCode = (BidInfo["failureCode"] as? Int) ?? 0
            self.interstitialAdWrapper?.reportAdExposureFailed(Int32(failureCode), reportParam: ZJPlatformTool.reportParam(BidInfo))
            return
        }
        
        let posId = arguments["posId"] as? String ?? ""
        let mutedIfCan = arguments["mutedIfCan"] as? Bool ?? true
        let adWidth = arguments["adWidth"] as? CGFloat ?? 0.0
        let adHeight = arguments["adHeight"] as? CGFloat ?? 0.0
        let adSize = CGSize.init(width: adWidth, height: adHeight)
        self.interstitialAdWrapper = ZJInterstitialAdWrapper()
        //插屏广告加载成功回调
        self.interstitialAdWrapper?.interstitialAdDidLoad = { param in
            ZjsdkFlutterPlugin.sendMessage(type: ZJSDKFlutterPluginAdType.INTERSTITIAL.rawValue, action: ZJSDKFlutterPluginOnAdLoadedAction, viewId: -1, code: ZJSDKFlutterPluginCode.SUCCESS.rawValue, msg: "", extra: ZJPlatformTool.map(toString: param))
        }
        
        //插屏广告错误
        self.interstitialAdWrapper?.interstitialAdError = { (error: Error) in
            let nsError = error as NSError
            ZjsdkFlutterPlugin.sendMessage(type: ZJSDKFlutterPluginAdType.INTERSTITIAL.rawValue, action: ZJSDKFlutterPluginOnAdErrorAction, viewId: -1, code: UInt(nsError.code), msg: nsError.convertJSONString(), extra: "")
        }
        
        //插屏广告点击
        self.interstitialAdWrapper?.interstitialAdDidClick = {
            ZjsdkFlutterPlugin.sendMessage(type: ZJSDKFlutterPluginAdType.INTERSTITIAL.rawValue, action: ZJSDKFlutterPluginOnAdClickAction, viewId: -1, code: ZJSDKFlutterPluginCode.SUCCESS.rawValue, msg: "", extra: "")
        }
        
        //插屏广告关闭
        self.interstitialAdWrapper?.interstitialAdDidClose = {
            ZjsdkFlutterPlugin.sendMessage(type: ZJSDKFlutterPluginAdType.INTERSTITIAL.rawValue, action: ZJSDKFlutterPluginOnAdCloseAction, viewId: -1, code: ZJSDKFlutterPluginCode.SUCCESS.rawValue, msg: "", extra: "")
        }
        
        //插屏广告展示
        self.interstitialAdWrapper?.interstitialAdDidPresentScreen = {
            ZjsdkFlutterPlugin.sendMessage(type: ZJSDKFlutterPluginAdType.INTERSTITIAL.rawValue, action: ZJSDKFlutterPluginOnAdShowAction, viewId: -1, code: ZJSDKFlutterPluginCode.SUCCESS.rawValue, msg: "", extra: "")
        }
        
        //插屏广告关闭详情页
        self.interstitialAdWrapper?.interstitialAdDetailDidClose = {
            ZjsdkFlutterPlugin.sendMessage(type: ZJSDKFlutterPluginAdType.INTERSTITIAL.rawValue, action: ZJSDKFlutterPluginOnAdCloseOtherControllerAction, viewId: -1, code: ZJSDKFlutterPluginCode.SUCCESS.rawValue, msg: "", extra: "")
        }
        
        //插屏广告打开详情页
        self.interstitialAdWrapper?.interstitialAdDetailDidPresentFullScreen = {
            ZjsdkFlutterPlugin.sendMessage(type: ZJSDKFlutterPluginAdType.INTERSTITIAL.rawValue, action: ZJSDKFlutterPluginOnAdOpenOtherControllerAction, viewId: -1, code: ZJSDKFlutterPluginCode.SUCCESS.rawValue, msg: "", extra: "")
        }
        self.interstitialAdWrapper?.loadInterstitialAd(withAdId: posId, mutedIfCan: mutedIfCan, adSize: adSize)
    }
    
//    MARK:RewardVideoAd
    func loadRewardAd(call: FlutterMethodCall) {
        let arguments: Dictionary<String, Any> = call.arguments as? Dictionary<String, Any> ?? [:]
        let onBid: String = (arguments["OnBid"] as? String) ?? ""
        if !arguments.isEmpty && onBid == "success" {
            // 竞价成功
            if self.rewardVideoAdWrapper != nil {
                let bidEcpm: Int = (arguments["bidEcpm"] as? Int) ?? 0
                let hightestLossEcpm: Int = (arguments["hightestLossEcpm"] as? Int) ?? 0
                self.rewardVideoAdWrapper?.setBidEcpm(bidEcpm, highestLossEcpm: hightestLossEcpm)
            }
            return
        }
        
        if !arguments.isEmpty && onBid == "failed" {
            // 竞价失败
            let BidInfo = (arguments["BidInfo"] as? Dictionary<String, Any>) ?? [:]
            let failureCode = (BidInfo["failureCode"] as? Int) ?? 0
            self.rewardVideoAdWrapper?.reportAdExposureFailed(Int32(failureCode), reportParam: ZJPlatformTool.reportParam(BidInfo))
            return
        }
        
        let posId = arguments["posId"] as? String ?? ""
        let userId = arguments["userId"] as? String ?? ""
        let reward_name = arguments["reward_name"] as? String ?? ""
        let reward_amount = arguments["reward_amount"] as? Int ?? 0
        let extra = arguments["extra"] as? String ?? ""
        self.rewardVideoAdWrapper = ZJRewardVideoAdWrapper()
        self.rewardVideoAdWrapper?.rewardVideoLoadSuccess = { param in
            ZjsdkFlutterPlugin.sendMessage(type: ZJSDKFlutterPluginAdType.REWARD_VIDEO.rawValue, action: ZJSDKFlutterPluginOnAdLoadedAction, viewId: -1, code: ZJSDKFlutterPluginCode.SUCCESS.rawValue, msg: "", extra: ZJPlatformTool.map(toString: param))
        }
        self.rewardVideoAdWrapper?.rewardVideoAdDidShow = {
            ZjsdkFlutterPlugin.sendMessage(type: ZJSDKFlutterPluginAdType.REWARD_VIDEO.rawValue, action: ZJSDKFlutterPluginOnAdShowAction, viewId: -1, code: ZJSDKFlutterPluginCode.SUCCESS.rawValue, msg: "", extra: "")
        }
        self.rewardVideoAdWrapper?.rewardVideoAdDidClose = {
            ZjsdkFlutterPlugin.sendMessage(type: ZJSDKFlutterPluginAdType.REWARD_VIDEO.rawValue, action: ZJSDKFlutterPluginOnAdCloseAction, viewId: -1, code: ZJSDKFlutterPluginCode.SUCCESS.rawValue, msg: "", extra: "")
        }
        self.rewardVideoAdWrapper?.rewardVideoAdDidClicked = {
            ZjsdkFlutterPlugin.sendMessage(type: ZJSDKFlutterPluginAdType.REWARD_VIDEO.rawValue, action: ZJSDKFlutterPluginOnAdClickAction, viewId: -1, code: ZJSDKFlutterPluginCode.SUCCESS.rawValue, msg: "", extra: "")
        }
        self.rewardVideoAdWrapper?.rewardVideoAdDidPlayFinish = {
            ZjsdkFlutterPlugin.sendMessage(type: ZJSDKFlutterPluginAdType.REWARD_VIDEO.rawValue, action: ZJSDKFlutterPluginOnAdDidPlayFinishAction, viewId: -1, code: ZJSDKFlutterPluginCode.SUCCESS.rawValue, msg: "", extra: "")
        }
        self.rewardVideoAdWrapper?.rewardVideoAdError = { error in
            let nsError = error as NSError
            ZjsdkFlutterPlugin.sendMessage(type: ZJSDKFlutterPluginAdType.REWARD_VIDEO.rawValue, action: ZJSDKFlutterPluginOnAdErrorAction, viewId: -1, code: UInt(nsError.code), msg: nsError.convertJSONString(), extra: "")
        }
        self.rewardVideoAdWrapper?.rewardVideoDidRewardEffective = { (transId, validationDictionary) in
            ZjsdkFlutterPlugin.sendMessage(type: ZJSDKFlutterPluginAdType.REWARD_VIDEO.rawValue, action: ZJSDKFlutterPluginOnAdRewardAction, viewId: -1, code: ZJSDKFlutterPluginCode.SUCCESS.rawValue, msg: transId, extra: ZJPlatformTool.map(toString: validationDictionary))
        }
        self.rewardVideoAdWrapper?.rewardVideoAdDidClickSkip = {
            ZjsdkFlutterPlugin.sendMessage(type: ZJSDKFlutterPluginAdType.REWARD_VIDEO.rawValue, action: ZJSDKFlutterPluginOnAdClickSkipAction, viewId: -1, code: ZJSDKFlutterPluginCode.SUCCESS.rawValue, msg: "", extra: "")
        }
        self.rewardVideoAdWrapper?.rewardVideoAdDidPresentFullScreen = {
            ZjsdkFlutterPlugin.sendMessage(type: ZJSDKFlutterPluginAdType.REWARD_VIDEO.rawValue, action: ZJSDKFlutterPluginOnAdOpenOtherControllerAction, viewId: -1, code: ZJSDKFlutterPluginCode.SUCCESS.rawValue, msg: "", extra: "")
        }
        self.rewardVideoAdWrapper?.rewardVideoAdDidCloseOtherController = {
            ZjsdkFlutterPlugin.sendMessage(type: ZJSDKFlutterPluginAdType.REWARD_VIDEO.rawValue, action: ZJSDKFlutterPluginOnAdCloseOtherControllerAction, viewId: -1, code: ZJSDKFlutterPluginCode.SUCCESS.rawValue, msg: "", extra: "")
        }
        self.rewardVideoAdWrapper?.loadRewardVideoAd(withAdId: posId, userId: userId, reward_name: reward_name, reward_amount: Int32(reward_amount), extra: extra)
    }
    
//    MARK:H5Ad
    func loadH5Ad(call: FlutterMethodCall) {
        let arguments: Dictionary<String, Any> = call.arguments as? Dictionary<String, Any> ?? [:]
        let posId = arguments["posId"] as? String ?? ""
        let userId = arguments["userId"] as? String ?? ""
        let userName = arguments["userName"] as? String ?? ""
        let userAvatar = arguments["userAvatar"] as? String ?? ""
        let userIntegral = arguments["userIntegral"] as? Int ?? 0
        let extra = arguments["extra"] as? String ?? ""
        
        self.h5AdWrapper = ZJH5AdWrapper()
        let user = ZJUser()
        user.userID = userId;
        user.userName = userName;
        user.userAvatar = userAvatar;
        user.userIntegral = userIntegral;
        user.posId = posId;
        user.ext = extra;
        //广告加载成功回调
        self.h5AdWrapper?.onAdDidLoad = { param in
            ZjsdkFlutterPlugin.sendMessage(type: ZJSDKFlutterPluginAdType.H5_PAGE.rawValue, action: ZJSDKFlutterPluginOnAdLoadedAction, viewId: -1, code: ZJSDKFlutterPluginCode.SUCCESS.rawValue, msg: "", extra: ZJPlatformTool.map(toString: param))
        }
        //广告错误
        self.h5AdWrapper?.onAdError = { error in
            let nsError = error as NSError
            ZjsdkFlutterPlugin.sendMessage(type: ZJSDKFlutterPluginAdType.H5_PAGE.rawValue, action: ZJSDKFlutterPluginOnAdErrorAction, viewId: -1, code: UInt(nsError.code), msg: nsError.convertJSONString(), extra: "")
        }
        //广告激励视频加载成功
        self.h5AdWrapper?.onRewardAdDidLoad = {
            ZjsdkFlutterPlugin.sendMessage(type: ZJSDKFlutterPluginAdType.H5_PAGE.rawValue, action: ZJSDKFlutterPluginOnAdLoadedAction, viewId: -1, code: ZJSDKFlutterPluginCode.SUCCESS.rawValue, msg: "", extra: "")
        }
        //激励视频获得奖励
        self.h5AdWrapper?.onRewardAdRewardEffective = { transId in
            ZjsdkFlutterPlugin.sendMessage(type: ZJSDKFlutterPluginAdType.H5_PAGE.rawValue, action: ZJSDKFlutterPluginOnAdRewardAction, viewId: -1, code: ZJSDKFlutterPluginCode.SUCCESS.rawValue, msg: "", extra: "")
        }
        //激励视频点击
        self.h5AdWrapper?.onRewardAdDidClick = {
            ZjsdkFlutterPlugin.sendMessage(type: ZJSDKFlutterPluginAdType.H5_PAGE.rawValue, action: ZJSDKFlutterPluginOnAdClickAction, viewId: -1, code: ZJSDKFlutterPluginCode.SUCCESS.rawValue, msg: "", extra: "")
        }
        //激励视频错误
        self.h5AdWrapper?.onRewardAdDidError = { error in
            let nsError = error as NSError
            ZjsdkFlutterPlugin.sendMessage(type: ZJSDKFlutterPluginAdType.H5_PAGE.rawValue, action: ZJSDKFlutterPluginOnAdErrorAction, viewId: -1, code: UInt(nsError.code), msg: nsError.convertJSONString(), extra: "")
        }
        self.h5AdWrapper?.loadAd(withAdId: posId, user: user)
    }
    
}
