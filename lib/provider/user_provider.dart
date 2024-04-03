import 'package:flutter/foundation.dart';

import '../model/user_model.dart';
import '../resources/auth_resources.dart';


class UserProvider with ChangeNotifier{
  UsersModel? _userModel ;
  UsersModel get getUser => _userModel!;

  Future<void> refreshUser()
  async{
    UsersModel user = await AuthMethods().getUserDetails();
    _userModel = user;
    notifyListeners();
  }

}