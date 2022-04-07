import 'package:demo_win_wms/app/data/data_service/web_service.dart';
import 'package:demo_win_wms/app/data/entity/res/res_get_pick_order_data_for_view.dart';
import 'package:demo_win_wms/app/utils/constants.dart';
import 'package:demo_win_wms/app/utils/user_prefs.dart';

abstract class PickOrderData{
  Future<ResGetPickOrderDataForView> getPickOrderDataForView({required int pickOrderID, required int salesOrderID});
}

class PickOrderDataImpl extends PickOrderData{
  @override
  Future<ResGetPickOrderDataForView> getPickOrderDataForView({required int pickOrderID, required int salesOrderID}) async {
    final user = await UserPrefs.shared.getUser;

    final res = await WebService.shared.postApiDIO(url: kBaseURL + 'pickorder/GetPickOrderDataForView_ByID',data: {
      "UserID": user.userID,
      "PickOrderID": pickOrderID,
      "SalesOrderID": salesOrderID
    });

    try {
      return ResGetPickOrderDataForView.fromJson(res!);
    }catch (e) {
      throw kErrorWithRes;
    }
  }

}