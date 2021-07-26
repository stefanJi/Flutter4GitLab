import 'package:F4Lab/api.dart';
import 'package:F4Lab/const.dart';
import 'package:F4Lab/gitlab_client.dart';
import 'package:F4Lab/model/user.dart';
import 'package:F4Lab/user_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  User? _user = UserHelper.getUser();
  bool _loading = false;
  String? _error;

  User? get user => _user;

  bool get loading => _loading;

  String? get error => _error;

  UserProvider() {
    _initUser();
  }

  void setUser(User u) {
    _user = u;
    _error = null;
    UserHelper.setUser(u);
  }

  void _initUser() async {
    _loading = true;
    notifyListeners();

    String? err = await UserHelper.initUser();
    _loading = false;
    _error = err;
    _user = UserHelper.getUser();
    notifyListeners();
  }

//region config token
  String? _testErr;
  bool _testSuccess = false;
  bool _testing = false;

  String? get testErr => _testErr;

  bool get testSuccess => _testSuccess;

  bool get testing => _testing;

  void testConfig(String host, String token, String? version) async {
    _testing = true;
    _testSuccess = false;
    _testErr = null;
    notifyListeners();

    GitlabClient.setUpTokenAndHost(token, host, version ?? DEFAULT_API_VERSION);
    final resp = await ApiService.getAuthUser();
    if (resp.success && resp.data != null) {
      _testSuccess = true;
      _testErr = null;
      final SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setString(KEY_ACCESS_TOKEN, token);
      sp.setString(KEY_HOST, host);
      sp.setString(KEY_API_VERSION, version ?? DEFAULT_API_VERSION);
      setUser(resp.data!);
    } else {
      _testSuccess = false;
      _testErr = resp.err ?? "Error";
    }
    _testing = false;
    notifyListeners();
  }

  void resetTestState() {
    _testSuccess = false;
    _testing = false;
    _testErr = null;
  }

//  endregion

  void logOut() async {
    final sp = await SharedPreferences.getInstance();
    sp.remove(KEY_HOST);
    sp.remove(KEY_ACCESS_TOKEN);
    sp.remove(KEY_API_VERSION);
    _user = null;
    notifyListeners();
  }

  @override
  String toString() {
    return 'UserProvider{user: $_user, loading: $_loading, error: $_error, configError: $_testErr, testSuccess: $_testSuccess, testing: $_testing}';
  }
}
