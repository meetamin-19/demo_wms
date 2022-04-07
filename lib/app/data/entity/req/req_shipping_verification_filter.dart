
import 'package:demo_win_wms/app/utils/user_prefs.dart';

class ReqShippingVerificationFilter {

  static Future<Map<String, dynamic>> toJson() async {

    final user = await UserPrefs.shared.getUser;

    return {
      "UserID": user.userID,
      "UserType_Term": user.userType_Term,
      "DefaultCompanyID": user.defaultCompanyID,
      "DefaultWarehouseID": user.defaultWarehouseID,
    };
  }
}