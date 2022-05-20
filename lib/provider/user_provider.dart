import 'package:first_app/model/user_model.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter_login_regis_provider/domain/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
      email: '', name: '', renewalToken: '', type: '', token: '', userId: 1);

  User get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}
