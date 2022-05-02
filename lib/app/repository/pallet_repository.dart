import 'package:demo_win_wms/app/data/datasource/pallet_data.dart';
import 'package:demo_win_wms/app/data/entity/res/res_check_for_cycle_count.dart';
import 'package:demo_win_wms/app/data/entity/res/res_complete_part_status.dart';
import 'package:demo_win_wms/app/data/entity/res/res_get_pallet_list_data_by_id.dart';
import 'package:demo_win_wms/app/data/entity/res/res_pick_order_view_line_item.dart';

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

  Future<ResGetCompletePartStatus> getCompletePartStatus(
          {required int pickOrderSODetailID,
          required int pickOrderId,
          required int itemId,
          required bool cycleCount}) async =>
      await dataSource.getCompletePartStatus(
          cycleCount: cycleCount, pickOrderSODetailID: pickOrderSODetailID, pickOrderId: pickOrderId, itemID: itemId);
}
