import 'package:demo_win_wms/app/data/datasource/home_data.dart';
import 'package:demo_win_wms/app/data/entity/req/req_pick_order_list_get.dart';
import 'package:demo_win_wms/app/data/entity/res/empty_res.dart';
import 'package:demo_win_wms/app/data/entity/res/res_pick_order_list_get.dart';
import 'package:demo_win_wms/app/data/entity/res/res_pickorder_link_user_list.dart';

class HomeRepository {
  final HomeData dataSource;

  HomeRepository({required this.dataSource});

  Future<ResPickOrderListGet> getPickOrderList(
      {required ReqPickOrderListGet req}) async {
    return await dataSource.getPickOrderList(req: req);
  }

  Future<EmptyRes> changePickOrderStatus({required int id}) async {
    return await dataSource.changePickOrderStatus(id: id);
  }

  Future<ResPickorderLinkUserList> pickorderLinkPickOrder(
      {required int id}) async {
    return await dataSource.pickOrderLinkPickOrder(id: id);
  }

  Future<EmptyRes> pickorderInsertUpdateLinkPickOrder({required int pickOrderID, required String pickOrderLinkedTo, required String updatelog}) async {
    return await dataSource.pickOrderInsertUpdateLinkPickOrder(pickOrderID: pickOrderID, pickOrderLinkedTo: pickOrderLinkedTo, updatelog: updatelog);
  }

  Future<EmptyRes> pickorderInsertUpdateUnlinkPickOrder({required int pickOrderID, required String updatelog}) async {
    return await dataSource.pickOrderInsertUpdateUnlinkPickOrder(pickOrderID: pickOrderID, updatelog: updatelog);
  }

}
