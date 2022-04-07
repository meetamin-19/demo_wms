import 'package:demo_win_wms/app/data/data_service/web_service.dart';
// import 'package:demo_win_wms/app/data/entity/Res/res_login.dart';
import 'package:demo_win_wms/app/data/entity/res/res_user_login.dart';
import 'package:demo_win_wms/app/utils/constants.dart';
import 'package:demo_win_wms/app/utils/user_prefs.dart';

abstract class AuthData{

  Future<ResUserLogin> login({required String userName,required String password});
  Future<LoginUserData> profileGet();

}

class AuthDataImpl extends AuthData{
  @override
  Future<ResUserLogin> login({required String userName,required String password}) async {

    final res = await WebService.shared.postApiDIO(url: kBaseURL + 'Account/Login',data: {
      "UserName": userName,
      "Password": password
    });

    try {
      return ResUserLogin.fromJson(res!);
    }catch (e) {
      throw kErrorWithRes;
    }

  }

  @override
  Future<LoginUserData> profileGet() async{

    final user = await UserPrefs.shared.getUser;

    try {
      final res = await WebService.shared.postApiDIO(url: kBaseURL + 'Account/GetLoginUserProfileData',data: {
        "UserID": user.userID
      });

      if(res?['success'] == false){
        throw res?['message'] ?? 'Something Went Wrong.';
      }

      final data = res?['data']['userProfileData'][0];

      return LoginUserData.fromJson(data!);
    }catch (e) {
      throw kErrorWithRes;
    }
  }

}