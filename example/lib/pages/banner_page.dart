import 'package:flutter/material.dart';
import 'package:zjsdk_flutter/event/ios_zj_event_action.dart';
import 'package:zjsdk_flutter/widgets/ios_zj_banner_view.dart';

class BannerPage extends StatefulWidget {
  const BannerPage({super.key});

  @override
  State<BannerPage> createState() => _BannerPageState();
}

class _BannerPageState extends State<BannerPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text('Banner广告')),
      body: Center(
        child: IosZjBannerView(
          "J7722563364",
          width: size.width,
          height: 200,
          refreshInterval: 0,
          bannerListener: (ret) {
            switch (ret.action) {
                  case IosZjEventAction.onAdLoaded:
                    print('banner广告加载了');
                    break;
                  case IosZjEventAction.onAdError:
                    print('banner广告错误');
                    break;
                  case IosZjEventAction.onAdShow:
                    print('banner广告曝光');
                    break;
                  case IosZjEventAction.onAdClick:
                    print("banner广告点击");
                    break;
                  case IosZjEventAction.onAdClose:
                    print("banner广告关闭");
                    break;
                  case IosZjEventAction.onAdCloseOtherController:
                    print("banner广告详情页关闭");
                    break;
                  default:
                }
          },
        ),
      ),
    );
  }
}
