
import 'package:dio/dio.dart';
import 'package:demo_win_wms/app/utils/user_prefs.dart';

import '../res/res_get_pallet_list_data_by_id.dart';

class ReqSubmitUnverifiedShippingVerification {
  ReqSubmitUnverifiedShippingVerification(
      {this.ApipickOrderPalletList,
      this.Attachment,
      this.BOLNumber,
      this.PickOrderID,
      this.SalesOrderID,
      this.SONumber,
      this.UserID});

  int? SalesOrderID;
  MultipartFile? Attachment;
  String? PickOrderID;
  String? SONumber;
  int? UserID;
  String? BOLNumber;
  List<PickOrderPalletList>? ApipickOrderPalletList;

  Future<Map<String, dynamic>> toJson() async{
    final user = await UserPrefs.shared.getUser;
    return {
      "SalesOrderID" : SalesOrderID,
      "Attachment" : Attachment,
      "PickOrderID" : PickOrderID,
      "SONumber" :SONumber,
      "UserID" : user.userID,
      "BOLNumber" : BOLNumber,
      "ApipickOrderPalletList" : ApipickOrderPalletList
    };
  }
}
