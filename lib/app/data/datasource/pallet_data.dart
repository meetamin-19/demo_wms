import 'package:demo_win_wms/app/data/data_service/web_service.dart';
import 'package:demo_win_wms/app/data/entity/res/res_get_pallet_list_data_by_id.dart';
import 'package:demo_win_wms/app/data/entity/res/res_pick_order_view_line_item.dart';
import 'package:demo_win_wms/app/utils/constants.dart';
import 'package:demo_win_wms/app/utils/user_prefs.dart';

abstract class PalletData{
 Future<ResPickOrderViewLineItem> pickOrderViewLineItem({required int PickOrderSODetailID,required int PickOrderID});
 Future<ResGetPalletListDataById> getPalletListDataByID({required int PickOrderSODetailID,required int PickOrderID});
}

class PalletDataImpl extends PalletData{
  @override
  Future<ResPickOrderViewLineItem> pickOrderViewLineItem({required int PickOrderSODetailID, required int PickOrderID}) async{

    final user = await UserPrefs.shared.getUser;

    final res = await WebService.shared.postApiDIO(url: kBaseURL + 'pickorder/PickOrderViewLineItem',data:
      {
        "UserID": user.userID,
        "PickOrderSODetailID": PickOrderSODetailID,
        "PickOrderID": PickOrderID
      }
    );

    try {
      return ResPickOrderViewLineItem.fromJson(res!);
    } catch (e) {
      throw kErrorWithRes;
    }
  }

  @override
  Future<ResGetPalletListDataById> getPalletListDataByID({required int PickOrderSODetailID, required int PickOrderID}) async {
    final user = await UserPrefs.shared.getUser;

    final res = await WebService.shared.postApiDIO(url: kBaseURL + 'pickorder/GetPalletListData_ByID',data:
    {

      "UserID": user.userID,
      "PickOrderSODetailID": PickOrderSODetailID,
      "PickOrderID": PickOrderID,
      "AddPalletFlag": false,
    }
    );

    try {

      return ResGetPalletListDataById.fromJson(res!);

    } catch (e) {
      throw kErrorWithRes;
    }
  }

}