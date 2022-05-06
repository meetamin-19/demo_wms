import 'package:demo_win_wms/app/data/datasource/pallet_data.dart';
import 'package:demo_win_wms/app/data/entity/req/req_get_scan_part_list.dart';
import 'package:demo_win_wms/app/data/entity/res/res_bind_location_list.dart';
import 'package:demo_win_wms/app/data/entity/res/res_check_for_cycle_count.dart';
import 'package:demo_win_wms/app/data/entity/res/res_complete_part_status.dart';
import 'package:demo_win_wms/app/data/entity/res/res_get_location_data.dart';
import 'package:demo_win_wms/app/data/entity/res/res_get_pallet_list_data_by_id.dart';
import 'package:demo_win_wms/app/data/entity/res/res_pick_order_view_line_item.dart';

import '../data/entity/res/empty_res.dart';

class PalletRepository {
  final PalletData dataSource;

  PalletRepository({required this.dataSource});

  Future<ResPickOrderViewLineItem> pickOrderViewLineItem(
      {required int PickOrderSODetailID, required int PickOrderID}) async =>
      await dataSource.pickOrderViewLineItem(PickOrderSODetailID: PickOrderSODetailID, PickOrderID: PickOrderID);

  Future<ResGetPalletListDataById> getPalletListDataByID(
      {required int PickOrderSODetailID, required int PickOrderID, required bool addPallet}) async =>
      await dataSource.getPalletListDataByID(
          PickOrderSODetailID: PickOrderSODetailID, PickOrderID: PickOrderID, addPallet: addPallet);

  Future<ResCheckForCycleCount> checkForCycleCount(
      {required int pickOrderSODetailID, required int pickOrderId, required int itemId}) async =>
      await dataSource.checkCycleCount(
          pickOrderSODetailID: pickOrderSODetailID, pickOrderId: pickOrderId, itemID: itemId);

  Future<ResGetCompletePartStatus> getCompletePartStatus({required int pickOrderSODetailID,
    required int pickOrderId,
    required int itemId,
    required bool cycleCount}) async =>
      await dataSource.getCompletePartStatus(
          cycleCount: cycleCount, pickOrderSODetailID: pickOrderSODetailID, pickOrderId: pickOrderId, itemID: itemId);

  Future<ResGetLocationData> getLocationData(
      {required String locationTitle, required int pickOrderSODetailID, required bool isTotePart}) async =>
      await dataSource.getLocationData(
          locationTitle: locationTitle, pickOrderSODetailID: pickOrderSODetailID, isTotePart: isTotePart);

  Future<ResGetPalletListDataById> getScanPartList({required ReqScanPartList req}) async {
    return await dataSource.getScanPartList(req: req);
  }

  Future<EmptyRes> completePallet({required int pOPalletId,
    required int pickOrderID,
    required int pickOrderSODetailID,
    required int warehouseId,
    required String updateLog}) async {
    return await dataSource.completePallet(
        pOPalletId: pOPalletId,
        pickOrderID: pickOrderID,
        pickOrderSODetailID: pickOrderSODetailID,
        warehouseId: warehouseId,
        updateLog: updateLog);
  }

  Future<EmptyRes> updatePOPalletBindLocation({required int pOPalletId,
    required int pickOrderID,
    required int pickOrderSODetailID,
    required int warehouseId,
    required String locationTitle}) async {
    return await dataSource.updatePOPalletBindLocation(
      pOPalletId: pOPalletId,
      pickOrderID: pickOrderID,
      pickOrderSODetailID: pickOrderSODetailID,
      warehouseId: warehouseId,
      locationTitle: locationTitle,
    );
  }

  Future<EmptyRes> resetLastScannedItemData({required int pOPalletId,
    required int pickOrderID,
    required int pickOrderSODetailID,}) async {
    return await dataSource.resetLastScannedItemData(
      pOPalletId: pOPalletId,
      pickOrderID: pickOrderID,
      pickOrderSODetailID: pickOrderSODetailID,
    );
  }

  Future<ResBindLocationList> bindLocationToPickedPallet({required int pOPalletId, required int pickOrderID}) async {
    return await dataSource.bindLocationToPickedPallet(pOPalletId: pOPalletId, pickOrderID: pickOrderID);
  }
}
