import 'package:F4Lab/model/user.dart';

class UserHelper {
  static User _user;

  static void setUser(User u) {
    _user = u;
  }

  static User getUser() {
    return _user;
  }
}
