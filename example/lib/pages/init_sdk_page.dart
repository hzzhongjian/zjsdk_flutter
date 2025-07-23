import 'package:flutter/material.dart';
import 'package:zjsdk_flutter/event/ios_zj_event_action.dart';
import 'package:zjsdk_flutter/ios_custom_controller.dart';
import 'package:zjsdk_flutter/zjsdk_flutter.dart';

class InitSDKPage extends StatefulWidget {
  const InitSDKPage({super.key});

  @override
  State<InitSDKPage> createState() => _InitSDKPageState();
}

class _InitSDKPageState extends State<InitSDKPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('初始化SDK')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                // 在调用初始化方法之前设置有效
                ZjsdkFlutter.setPersonalRecommend(true);
              },
              child: Text('配置个性化推荐开关, 默认打开'),
            ),
            ElevatedButton(
              onPressed: () {
                // 在调用初始化方法之前设置有效
                ZjsdkFlutter.setProgrammaticRecommend(true);
              },
              child: Text('配置程序化推荐开关, 默认打开'),
            ),
            ElevatedButton(
              onPressed: () {
                IosZJCustomController customController = IosZJCustomController(
                  canUseIDFA: false,
                );
                ZjsdkFlutter.registerAppId("zj_20201014iOSDEMO", (ret) {
                  switch (ret.action) {
                    case IosZjEventAction.initSuccess:
                      print('初始化成功');
                      break;
                    case IosZjEventAction.initFailed:
                      print('初始化失败');
                      break;
                    default:
                  }
                }, customController: customController);
              },
              child: const Text("初始化"),
            ),
          ],
        ),
      ),
    );
  }
}
