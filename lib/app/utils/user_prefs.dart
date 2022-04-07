
import 'package:shared_preferences/shared_preferences.dart';

class UserPrefs{

  static UserPrefs shared = UserPrefs();

  // Set Local Data here
  Future setLocalData({required LocalUser user}) async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool('IS_USER_LOGIN', user.isLogin);
    prefs.setInt('USER_id', user.userID);
    prefs.setString('USER_token', user.access_Token);
    prefs.setString('USER_type', user.userType_Term);
    prefs.setInt('USER_defaultWarehouseID', user.defaultWarehouseID);
    prefs.setInt('USER_defaultCompanyID', user.defaultCompanyID);
  }

  // Clear Local here
  Future<bool> clear() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.clear();

  }

  // Get User here
  Future<LocalUser> get getUser => _getUser();

  Future<LocalUser> _getUser() async{

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    bool isLogin = prefs.getBool('IS_USER_LOGIN') ?? false;
    int id = prefs.getInt('USER_id') ?? 0;
    String token = prefs.getString('USER_token') ?? "";
    String type = prefs.getString('USER_type') ?? "";
    int warehouseID = prefs.getInt('USER_defaultWarehouseID') ?? 0;
    int companyID = prefs.getInt('USER_defaultCompanyID') ?? 0;

    return LocalUser(userID: id,access_Token: token,defaultCompanyID: companyID,defaultWarehouseID: warehouseID,isLogin: isLogin,userType_Term: type);
  }

  // Get is login here
  Future<bool> get isUserLogin => _isUserLogin();

  Future<bool> _isUserLogin() async{

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    bool isLogin = prefs.getBool('IS_USER_LOGIN') ?? false;

    return isLogin;
  }

}


class LocalUser{

  final bool isLogin;
  final int userID;
  final String access_Token;
  final String userType_Term;
  final int defaultWarehouseID;
  final int defaultCompanyID;

  LocalUser({required this.userID,required this.access_Token,required this.userType_Term,required this.defaultWarehouseID,required this.defaultCompanyID,
      required this.isLogin});

}