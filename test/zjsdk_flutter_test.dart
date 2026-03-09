import 'package:flutter_test/flutter_test.dart';
import 'package:zjsdk_flutter/zjsdk_flutter.dart';

class MockZjsdkFlutterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  
}
