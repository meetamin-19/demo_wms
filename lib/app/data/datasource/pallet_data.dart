import 'package:demo_win_wms/app/data/data_service/web_service.dart';
import 'package:demo_win_wms/app/data/entity/res/res_get_pallet_list_data_by_id.dart';
import 'package:demo_win_wms/app/data/entity/res/res_pick_order_view_line_item.dart';
import 'package:demo_win_wms/app/utils/constants.dart';
import 'package:demo_win_wms/app/utils/user_prefs.dart';

import '../entity/req/req_get_scan_part_list.dart';
import '../entity/res/empty_res.dart';
import '../entity/res/res_check_for_cycle_count.dart';
import '../entity/res/res_complete_part_status.dart';

abstract class PalletData {
  Future<ResPickOrderViewLineItem> pickOrderViewLineItem({required int PickOrderSODetailID, required int PickOrderID});

  Future<ResGetPalletListDataById> getPalletListDataByID(
      {required int PickOrderSODetailID, required int PickOrderID, required bool addPallet});

  Future<ResCheckForCycleCount> checkCycleCount(
      {required int pickOrderId, required int pickOrderSODetailID, required int itemID});

  Future<ResGetCompletePartStatus> getCompletePartStatus(
      {required int pickOrderId, required int pickOrderSODetailID, required int itemID, required bool cycleCount});

  Future<EmptyRes> getLocationData(
      {required String locationTitle, required int pickOrderSODetailID, required bool isTotePart});

  Future<EmptyRes> getScanPartList({required ReqScanPartList req});

  Future<EmptyRes> completePallet(
      {required int pOPalletId,
      required int pickOrderID,
      required int pickOrderSODetailID,
      required int warehouseId,
      required String updateLog});

  Future<EmptyRes> bindLocationToPickedPallet({required int pOPalletId, required int pickOrderID});

  Future<EmptyRes> resetLastScannedItemData(
      {required int pOPalletId, required int pickOrderID, required int pickOrderSODetailID});

  Future<EmptyRes> updatePOPalletBindLocation(
      {required int pOPalletId,
      required int pickOrderID,
      required int pickOrderSODetailID,
      required int warehouseId,
      required String locationTitle});
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
      {required int pickOrderId,
      required int pickOrderSODetailID,
      required int itemID,
      required bool cycleCount}) async {
    final user = await UserPrefs.shared.getUser;

    final res = await WebService.shared.postApiDIO(url: kBaseURL + 'pickorder/GetCompletePartStatus', data: {
      "PickOrderID": pickOrderId,
      "PickOrderSODetailID": pickOrderSODetailID,
      "GenerateCycleCountOrNot": cycleCount.toString(),
      "ItemID": itemID,
      "UserID": user.userID
    });
    try {
      return ResGetCompletePartStatus.fromJson(res!);
    } catch (e) {
      throw kErrorWithRes;
    }
  }

  @override
  Future<EmptyRes> getLocationData(
      {required String locationTitle, required int pickOrderSODetailID, required bool isTotePart}) async {
    final user = await UserPrefs.shared.getUser;

    final res = await WebService.shared.postApiDIO(url: kBaseURL + 'pickorder/GetLocationData', data: {
      "PickOrderSODetailID": pickOrderSODetailID,
      "LocationTitle": locationTitle,
      "UserID": user.userID,
      "IsTotePart": isTotePart
    });
    try {
      return EmptyRes.fromJson(res!);
    } catch (e) {
      throw kErrorWithRes;
    }
  }

  @override
  Future<EmptyRes> getScanPartList({required ReqScanPartList req}) async {
    final res = await WebService.shared.postApiDIO(url: kBaseURL + 'pickorder/GetScanPartList', data: req.toJson());

    try {
      return EmptyRes.fromJson(res!);
    } catch (e) {
      throw kErrorWithRes;
    }
  }

  @override
  Future<EmptyRes> completePallet(
      {required int pOPalletId,
      required int pickOrderID,
      required int pickOrderSODetailID,
      required int warehouseId,
      required String updateLog}) async {
    final user = await UserPrefs.shared.getUser;

    final res = await WebService.shared.postApiDIO(url: kBaseURL + 'pickorder/CompletePallet', data: {
      "POPalletID": pOPalletId,
      "PickOrderID": pickOrderID,
      "UserID": user.userID,
      "PickOrderSODetailID": pickOrderSODetailID,
      "WarehouseID": warehouseId,
      "UpdateLog": updateLog
    });
    try {
      return EmptyRes.fromJson(res!);
    } catch (e) {
      throw kErrorWithRes;
    }
  }

  @override
  Future<EmptyRes> bindLocationToPickedPallet({
    required int pOPalletId,
    required int pickOrderID,
  }) async {
    final res = await WebService.shared.postApiDIO(url: kBaseURL + 'pickorder/BindLocationToPickedPallet', data: {
      "POPalletID": pOPalletId,
      "PickOrderID": pickOrderID,
    });
    try {
      return EmptyRes.fromJson(res!);
    } catch (e) {
      throw kErrorWithRes;
    }
  }

  @override
  Future<EmptyRes> resetLastScannedItemData(
      {required int pOPalletId, required int pickOrderID, required int pickOrderSODetailID}) async {
    final user = await UserPrefs.shared.getUser;
    final res = await WebService.shared.postApiDIO(url: kBaseURL + 'pickorder/ResetLastScannedItemData', data: {
      "POPalletID": pOPalletId,
      "PickOrderID": pickOrderID,
      "PickOrderSODetailID": pickOrderSODetailID,
      "UserID": user.userID
    });
    try {
      return EmptyRes.fromJson(res!);
    } catch (e) {
      throw kErrorWithRes;
    }
  }

  @override
  Future<EmptyRes> updatePOPalletBindLocation(
      {required int pOPalletId,
      required int pickOrderID,
      required int pickOrderSODetailID,
      required int warehouseId,
      required String locationTitle}) async {
    final user = await UserPrefs.shared.getUser;

    final res = await WebService.shared.postApiDIO(url: kBaseURL + 'pickorder/UpdatePOPalletBindLocation', data: {
      "POPalletID": pOPalletId,
      "PickOrderID": pickOrderID,
      "PickOrderSODetailID": pickOrderSODetailID,
      "WarehouseID": warehouseId,
      "UserID": user.userID,
      "LocationTitle": locationTitle
    });
    try {
      return EmptyRes.fromJson(res!);
    } catch (e) {
      throw kErrorWithRes;
    }
  }
}
