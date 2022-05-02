import 'package:demo_win_wms/app/data/data_service/web_service.dart';
import 'package:demo_win_wms/app/data/entity/res/res_get_pallet_list_data_by_id.dart';
import 'package:demo_win_wms/app/data/entity/res/res_pick_order_view_line_item.dart';
import 'package:demo_win_wms/app/utils/constants.dart';
import 'package:demo_win_wms/app/utils/user_prefs.dart';

import '../entity/res/res_check_for_cycle_count.dart';
import '../entity/res/res_complete_part_status.dart';

abstract class PalletData {
  Future<ResPickOrderViewLineItem> pickOrderViewLineItem({required int PickOrderSODetailID, required int PickOrderID});

  Future<ResGetPalletListDataById> getPalletListDataByID({required int PickOrderSODetailID, required int PickOrderID, required bool addPallet});

  Future<ResCheckForCycleCount> checkCycleCount(
      {required int pickOrderId, required int pickOrderSODetailID, required int itemID});

  Future<ResGetCompletePartStatus> getCompletePartStatus(
      {required int pickOrderId, required int pickOrderSODetailID, required int itemID,  required bool cycleCount});

  // Future<EmptyRes> getLocationData({required String locationTitle, required int pickOrderSODetailID, required bool isTotePart})
}

class PalletDataImpl extends PalletData {
  @override
  Future<ResPickOrderViewLineItem> pickOrderViewLineItem(
      {required int PickOrderSODetailID, required int PickOrderID}) async {
    final user = await UserPrefs.shared.getUser;

    final res = await WebService.shared.postApiDIO(
        url: kBaseURL + 'pickorder/PickOrderViewLineItem',
        data: {"UserID": user.userID, "PickOrderSODetailID": PickOrderSODetailID, "PickOrderID": PickOrderID});

    try {
      return ResPickOrderViewLineItem.fromJson(res!);
    } catch (e) {
      throw kErrorWithRes;
    }
  }

  @override
  Future<ResGetPalletListDataById> getPalletListDataByID(
      {required int PickOrderSODetailID, required int PickOrderID, required bool addPallet}) async {
    final user = await UserPrefs.shared.getUser;

    final res = await WebService.shared.postApiDIO(url: kBaseURL + 'pickorder/GetPalletListData_ByID', data: {
      "UserID": user.userID,
      "PickOrderSODetailID": PickOrderSODetailID,
      "PickOrderID": PickOrderID,
      "AddPalletFlag": addPallet,
    });

    try {
      return ResGetPalletListDataById.fromJson(res!);
    } catch (e) {
      throw kErrorWithRes;
    }
  }

  @override
  Future<ResCheckForCycleCount> checkCycleCount(
      {required int pickOrderId, required int pickOrderSODetailID, required int itemID}) async {
    final user = await UserPrefs.shared.getUser;

    final res = await WebService.shared.postApiDIO(url: kBaseURL + 'pickorder/CheckForCycleCount', data: {
      "PickOrderID": pickOrderId,
      "PickOrderSODetailID": pickOrderSODetailID,
      "ItemID": itemID,
      "UserID": user.userID
    });
    try {
      return ResCheckForCycleCount.fromJson(res!);
    } catch (e) {
      throw kErrorWithRes;
    }
  }

  @override
  Future<ResGetCompletePartStatus> getCompletePartStatus(
      {required int pickOrderId, required int pickOrderSODetailID, required int itemID, required bool cycleCount}) async {
    final user = await UserPrefs.shared.getUser;
    
    final res = await WebService.shared.postApiDIO(url: kBaseURL + 'pickorder/GetCompletePartStatus', data:  {
      "PickOrderID": pickOrderId,
      "PickOrderSODetailID": pickOrderSODetailID,
      "GenerateCycleCountOrNot" : cycleCount.toString(),
      "ItemID": itemID,
      "UserID": user.userID
    });
    try{
      return ResGetCompletePartStatus.fromJson(res!);
    }catch (e) {
      throw kErrorWithRes;
    }
  }
}
