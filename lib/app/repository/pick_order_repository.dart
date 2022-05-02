import 'package:demo_win_wms/app/data/datasource/pick_order_data.dart';
import 'package:demo_win_wms/app/data/entity/res/empty_res.dart';
import 'package:demo_win_wms/app/data/entity/res/res_get_pick_order_data_for_view.dart';
import 'package:demo_win_wms/app/data/entity/res/res_primarykey_errormessage.dart';

import '../data/entity/res/res_pick_order_sales_order_list.dart';

class PickOrderRepository{
  final PickOrderData dataSource;

  PickOrderRepository({required this.dataSource});

  Future<ResGetPickOrderDataForView> getPickOrderDataForView({required int pickOrderID, required int salesOrderID}) async {
    return dataSource.getPickOrderDataForView(pickOrderID: pickOrderID, salesOrderID: salesOrderID);
  }

  Future<ResSalesOrderListGet> getSalesOrderList({required int pickOrderID, required int salesOrderID}) async {
    return dataSource.getSalesOrderList(pickOrderID: pickOrderID, salesOrderID: salesOrderID);
  }

  Future<ResWithPrimaryKeyAndErrorMessage> completePickOrder({required int pickOrderID}) async {
    return dataSource.completePickOrder(pickOrderID: pickOrderID);
  }

}