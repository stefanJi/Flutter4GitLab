import 'package:flutter/widgets.dart';
import 'package:package_info/package_info.dart';

class PackageInfoProvider extends ChangeNotifier {
  PackageInfo _packageInfo =
      PackageInfo(appName: "", packageName: "", version: "", buildNumber: "");

  PackageInfo get packageInfo => _packageInfo;

  PackageInfoProvider() {
    _loadPackageInfo();
  }

  _loadPackageInfo() async {
    _packageInfo = await PackageInfo.fromPlatform();
    notifyListeners();
  }
}
