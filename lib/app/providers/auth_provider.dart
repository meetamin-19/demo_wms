import 'package:flutter/cupertino.dart';
import 'package:demo_win_wms/app/data/data_service/web_service.dart';
import 'package:demo_win_wms/app/data/entity/res/res_pick_order_view_line_item.dart';
import 'package:demo_win_wms/app/data/entity/res/res_user_login.dart';
import 'package:demo_win_wms/app/repository/auth_repository.dart';
import 'package:demo_win_wms/app/utils/api_response.dart';
import 'package:demo_win_wms/app/utils/user_prefs.dart';

import 'base_notifier.dart';

class AuthProvider {
  Future getUserFromLocal() async {}

  Future logInUser(
      {required String userName, required String password}) async {}

  Future logOutUser() async {}

  Future fetchUser() async {}

  Future unAuthorizeUser() async {}
}

class AuthProviderImpl extends BaseNotifier implements AuthProvider {
  AuthProviderImpl({required this.repo}) {
    getUserFromLocal();

    _res = ApiResponse();
    _profileRes = ApiResponse();
  }

  final AuthRepository repo;

  ApiResponse<ResUserLogin>? _res;

  ApiResponse<ResUserLogin>? get res => _res;

  ApiResponse<LoginUserData>? _profileRes;

  ApiResponse<LoginUserData>? get profileRes => _profileRes;

  bool? isLogin;

  @override
  Future getUserFromLocal() async {
    // TODO: implement getUserFromLocal

    isLogin = await UserPrefs.shared.isUserLogin;

    print('is User Logged in: $isLogin');

    notifyListeners();

    if (isLogin == true) {
      fetchUser();
    }
  }

  @override
  Future logInUser({required String userName, required String password}) async {
    // TODO: implement logInUser

    try {
      apiResIsLoading(_res!);

      final res = await repo.login(userName: userName, password: password);

      if (res.success == true) {
        apiResIsSuccess<ResUserLogin>(_res!, res);
      } else {
        throw res.message ?? 'Something Went Wrong';
      }

      final data = res.data?.loginUserData;

      await UserPrefs.shared.setLocalData(
          user: LocalUser(
              isLogin: true,
              userID: data?.userId ?? 0,
              userType_Term: data?.userTypeTerm ?? '',
              defaultWarehouseID: data?.defaultWarehouseIdForSession ?? 0,
              defaultCompanyID: data?.defaultCompanyIdForSession ?? 0,
              access_Token: (data?.accessToken ?? '')));

      isLogin = true;

      notifyListeners();

      await fetchUser();
    } catch (e) {
      print(e);
      apiResIsFailed(_res!, e);
      rethrow;
    }
  }

  @override
  Future logOutUser() async {
    // TODO: implement logOutUser
    await UserPrefs.shared.clear();

    isLogin = false;

    notifyListeners();
  }

  @override
  Future unAuthorizeUser() async {
    // TODO: implement unAuthorizeUser
    await UserPrefs.shared.clear();

    isLogin = false;

    notifyListeners();
  }

  @override
  Future fetchUser() async {
    try {
      apiResIsLoading(_profileRes!);

      final res = await repo.profileGet();

      print('res.userName');

      print(res.userName);

      apiResIsSuccess(_profileRes!, res);
    } catch (e) {
      print('EXCEPTION: ${e.toString()}');
      apiResIsFailed(_profileRes!, e);
    }
  }
}
