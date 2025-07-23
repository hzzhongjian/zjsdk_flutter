import 'package:flutter/material.dart';
import 'package:zjsdk_flutter/event/ios_zj_event_action.dart';
import 'package:zjsdk_flutter/zjsdk_flutter.dart';
import 'package:zjsdk_flutter/widgets/ios_zj_news_view.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text('新闻资讯')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                ZjsdkFlutter.loadNewsAd("J1321306298", (ret) {
                  switch (ret.action) {
                    case IosZjEventAction.onAdLoaded:
                      print('新闻资讯广告加载了');
                      break;
                    case IosZjEventAction.onAdError:
                      print('新闻资讯广告报错');
                      break;
                    case IosZjEventAction.onAdShow:
                      print('新闻资讯广告曝光');
                      break;
                    case IosZjEventAction.onAdClick:
                      print('新闻资讯广告点击');
                      break;
                    case IosZjEventAction.onAdClose:
                      print('新闻资讯广告关闭');
                      break;
                    case IosZjEventAction.onAdRewardVerify:
                      print('新闻资讯发奖');
                      break;
                    default:
                  }
                }, userId: "18888888888");
              },
              child: Text('原生新闻资讯'),
            ),
            Center(child: Text("以下展示为flutter的Widget展示")),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final maxHeight = constraints.maxHeight;
                  return IosZjNewsView(
                    "J1321306298",
                    width: size.width,
                    height: maxHeight,
                    userId: "1888888888",
                    newsAdListener: (ret) {
                      switch (ret.action) {
                          case IosZjEventAction.onAdLoaded:
                            print('新闻资讯广告加载了');
                            break;
                          case IosZjEventAction.onAdError:
                            print('新闻资讯广告报错');
                            break;
                          case IosZjEventAction.onAdShow:
                            print('新闻资讯广告曝光');
                            break;
                          case IosZjEventAction.onAdClick:
                            print('新闻资讯广告点击');
                            break;
                          case IosZjEventAction.onAdClose:
                            print('新闻资讯广告关闭');
                            break;
                          case IosZjEventAction.onAdRewardVerify:
                            print('新闻资讯发奖');
                            break;
                          default:
                        }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
