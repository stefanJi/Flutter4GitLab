import 'package:F4Lab/util/exception_capture.dart';
import 'package:flutter/widgets.dart';
import 'package:package_info/package_info.dart';

class PackageInfoProvider extends ChangeNotifier {
  PackageInfo _packageInfo =
      PackageInfo(appName: "", packageName: "", version: "", buildNumber: "");

  PackageInfo get packageInfo {
    if (_packageInfo.appName.isEmpty) {
      sentry.captureException(Exception("PackageInfo get null appName"));
      _packageInfo = PackageInfo(
          appName: "",
          packageName: _packageInfo.packageName,
          version: _packageInfo.version,
          buildNumber: _packageInfo.buildNumber);
    }
    return _packageInfo;
  }

  PackageInfoProvider() {
    _loadPackageInfo();
  }

  _loadPackageInfo() async {
    _packageInfo = await PackageInfo.fromPlatform();
    notifyListeners();
  }
}
