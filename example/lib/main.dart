import 'package:flutter/material.dart';
import 'package:zjsdk_flutter/zjsdk_flutter.dart';
import 'package:zjsdk_flutter_example/pages/Interstitial_page.dart';
import 'package:zjsdk_flutter_example/pages/banner_page.dart';
import 'package:zjsdk_flutter_example/pages/content_page.dart';
import 'package:zjsdk_flutter_example/pages/feed_full_video.dart';
import 'package:zjsdk_flutter_example/pages/h5_page.dart';
import 'package:zjsdk_flutter_example/pages/init_sdk_page.dart';
import 'package:zjsdk_flutter_example/pages/native_express_page.dart';
import 'package:zjsdk_flutter_example/pages/news_page.dart';
import 'package:zjsdk_flutter_example/pages/reward_page.dart';
import 'package:zjsdk_flutter_example/pages/splash_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class ListData {
  final String title;
  final Widget routeWidget;

  ListData(this.title, this.routeWidget);
}

class _MyAppState extends State<MyApp> {
  String? sdkVersion;

  List<ListData> datasource = [
    ListData('初始化SDK,请先执行初始化', InitSDKPage()),
    ListData('开屏广告', SplashPage()),
    ListData('插屏广告', InterstitialPage()),
    ListData('激励广告', RewardPage()),
    ListData('Banner广告', BannerPage()),
    ListData('信息流广告', NativeExpressPage()),
    ListData('视频流广告', FeedFullVideoPage()),
    ListData('视频内容', ContentPage()),
    ListData('新闻资讯', NewsPage()),
    ListData('H5页面', H5Page()),
  ];

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    sdkVersion = await ZjsdkFlutter.sdkVersion;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('ZJSDK-Flutter：$sdkVersion')),
        body: Center(
          child: ListView.builder(
            itemCount: datasource.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ListTile(
                    title: Text(
                      datasource[index].title,
                      style: TextStyle(fontSize: 18),
                    ),
                    onTap: () {
                      Widget pageWidget = datasource[index].routeWidget;
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return pageWidget;
                          },
                        ),
                      );
                    },
                  ),
                  Container(color: Colors.grey, height: 0.5),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
