import 'package:demo_win_wms/app/data/datasource/home_data.dart';
import 'package:demo_win_wms/app/data/entity/req/req_pick_order_list_get.dart';
import 'package:demo_win_wms/app/data/entity/res/empty_res.dart';
import 'package:demo_win_wms/app/data/entity/res/res_pick_order_list_get.dart';
import 'package:demo_win_wms/app/data/entity/res/res_pickorder_link_user_list.dart';
import 'package:demo_win_wms/app/data/entity/res/res_primarykey_errormessage.dart';

import '../data/entity/res/res_pick_order_add_note.dart';

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

  Future<ResPickOrderLinkUserList> getPickOrderLinkUserList(
      {required int id}) async {
    return await dataSource.getPickOrderLinkUserList(id: id);
  }

  Future<ResWithPrimaryKeyAndErrorMessage> pickorderInsertUpdateLinkPickOrder({required int pickOrderID, required String pickOrderLinkedTo, required String updatelog}) async {
    return await dataSource.pickOrderInsertUpdateLinkPickOrder(pickOrderID: pickOrderID, pickOrderLinkedTo: pickOrderLinkedTo, updatelog: updatelog);
  }

  Future<EmptyRes> pickorderInsertUpdateUnlinkPickOrder({required int pickOrderID, required String updatelog}) async {
    return await dataSource.pickOrderInsertUpdateUnlinkPickOrder(pickOrderID: pickOrderID, updatelog: updatelog);
  }

  Future<EmptyRes> deletePickOrder({required int pickOrderID, required String updateLog}) async {
    return dataSource.deletePickOrder(pickOrderID: pickOrderID, updateLog: updateLog);
  }

  Future<ResPickOrderAddNote> getPickOrderNoteText({required int pickOrderID}) async {
    return dataSource.getPickOrderNoteText(pickOrderID: pickOrderID);
  }

  Future<EmptyRes> savePickOrderNote({required int pickOrderID, required String pickOrderNote, required String updateLog}) async {
    return dataSource.savePickOrderNote(pickOrderID: pickOrderID, pickOrderNote: pickOrderNote, updateLog:  updateLog);
  }
  Future<ResWithPrimaryKeyAndErrorMessage> linkUserToPickOrder({required int pickOrderID, required int id, required String updateLog}) async {
    return dataSource.linkUserToPickOrder(updateLog:  updateLog,pickOrderId: pickOrderID,pickOrderLinkedToUserID: id);
  }

}
