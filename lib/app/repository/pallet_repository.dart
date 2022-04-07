import 'package:demo_win_wms/app/data/datasource/pallet_data.dart';
import 'package:demo_win_wms/app/data/entity/res/res_get_pallet_list_data_by_id.dart';
import 'package:demo_win_wms/app/data/entity/res/res_pick_order_view_line_item.dart';

class PalletRepository{
  final PalletData dataSource;

  PalletRepository({required this.dataSource});

  Future<ResPickOrderViewLineItem> pickOrderViewLineItem({required int PickOrderSODetailID, required int PickOrderID}) async => await dataSource.pickOrderViewLineItem(PickOrderSODetailID: PickOrderSODetailID, PickOrderID: PickOrderID);
  Future<ResGetPalletListDataById> getPalletListDataByID({required int PickOrderSODetailID, required int PickOrderID}) async => await dataSource.getPalletListDataByID(PickOrderSODetailID: PickOrderSODetailID, PickOrderID: PickOrderID);
}