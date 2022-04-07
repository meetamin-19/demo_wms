import 'package:demo_win_wms/app/data/datasource/auth_data.dart';
import 'package:demo_win_wms/app/data/entity/res/res_user_login.dart';

class AuthRepository{

  final AuthData dataSource;

  AuthRepository({required this.dataSource});

  Future<ResUserLogin> login({required String userName,required String password}) async => dataSource.login(userName: userName, password: password);
  Future<LoginUserData> profileGet() async => dataSource.profileGet();
}