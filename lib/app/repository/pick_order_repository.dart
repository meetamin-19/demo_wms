import 'package:demo_win_wms/app/data/datasource/pick_order_data.dart';
import 'package:demo_win_wms/app/data/entity/res/empty_res.dart';
import 'package:demo_win_wms/app/data/entity/res/res_get_pick_order_data_for_view.dart';

class PickOrderRepository{
  final PickOrderData dataSource;

  PickOrderRepository({required this.dataSource});

  Future<ResGetPickOrderDataForView> getPickOrderDataForView({required int pickOrderID, required int salesOrderID}) async {
    return dataSource.getPickOrderDataForView(pickOrderID: pickOrderID, salesOrderID: salesOrderID);
  }



}