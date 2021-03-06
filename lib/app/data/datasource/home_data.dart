import 'package:demo_win_wms/app/data/data_service/web_service.dart';
import 'package:demo_win_wms/app/data/entity/req/req_pick_order_list_get.dart';
import 'package:demo_win_wms/app/data/entity/res/empty_res.dart';
import 'package:demo_win_wms/app/data/entity/res/res_pick_order_add_note.dart';
import 'package:demo_win_wms/app/data/entity/res/res_pick_order_list_get.dart';
import 'package:demo_win_wms/app/data/entity/res/res_pickorder_link_user_list.dart';
import 'package:demo_win_wms/app/utils/constants.dart';
import 'package:demo_win_wms/app/utils/user_prefs.dart';

import '../entity/res/res_primarykey_errormessage.dart';

abstract class HomeData {
  Future<ResPickOrderListGet> getPickOrderList({required ReqPickOrderListGet req});

  Future<EmptyRes> changePickOrderStatus({required int id});

  Future<ResPickOrderLinkUserList> getPickOrderLinkUserList({required int id});

  Future<ResWithPrimaryKeyAndErrorMessage> pickOrderInsertUpdateLinkPickOrder(
      {required int pickOrderID, required String pickOrderLinkedTo, required String updatelog});

  Future<EmptyRes> pickOrderInsertUpdateUnlinkPickOrder({required int pickOrderID, required String updatelog});

  Future<EmptyRes> deletePickOrder({required int pickOrderID, required String updateLog});

  Future<ResPickOrderAddNote> getPickOrderNoteText({required int pickOrderID});

  Future<EmptyRes> savePickOrderNote({
    required int pickOrderID,
    required String pickOrderNote,
    required String updateLog,
  });

  Future<ResWithPrimaryKeyAndErrorMessage> linkUserToPickOrder({
    required int pickOrderId,
    required String updateLog,
    required int pickOrderLinkedToUserID
  });
}

class HomeDataImpl implements HomeData {
  @override
  Future<ResPickOrderListGet> getPickOrderList({required ReqPickOrderListGet req}) async {
    final res = await WebService.shared
        .postApiDIO(url: kBaseURL + 'pickorder/Get_PickOrderListFilterSelection', data: await req.toJson());

    try {
      return ResPickOrderListGet.fromJson(res!);
    } catch (e) {
      throw kErrorWithRes;
    }
  }

  @override
  Future<EmptyRes> changePickOrderStatus({required int id}) async {
    final user = await UserPrefs.shared.getUser;

    final res = await WebService.shared.postApiDIO(
        url: kBaseURL + 'pickorder/GetpickOrder_ChangePickOrderStatus',
        data: {"PickOrderID": id, "UserID": user.userID});

    try {
      return EmptyRes.fromJson(res!);
    } catch (e) {
      throw kErrorWithRes;
    }
  }

  @override
  Future<ResPickOrderLinkUserList> getPickOrderLinkUserList({required int id}) async {
    final user = await UserPrefs.shared.getUser;

    final res = await WebService.shared.postApiDIO(
        url: kBaseURL + 'pickorder/GetAcknowledgementUserListData', data: {"PickOrderID": id, "UserID": user.userID});

    try {
      return ResPickOrderLinkUserList.fromJson(res!);
    } catch (e) {
      throw kErrorWithRes;
    }
  }

  @override
  Future<ResWithPrimaryKeyAndErrorMessage> pickOrderInsertUpdateLinkPickOrder(
      {required int pickOrderID, required String pickOrderLinkedTo, required String updatelog}) async {
    final user = await UserPrefs.shared.getUser;

    final res = await WebService.shared.postApiDIO(
        url: kBaseURL + 'pickorder/SaveAcknowledgwmentPickOrder',
        data: {
          "PickOrderID": pickOrderID,
          "PickOrderLinkedTo": pickOrderLinkedTo,
          "Updatelog": updatelog,
          "UserID": user.userID
        });

    try {
      return ResWithPrimaryKeyAndErrorMessage.fromJson(res!);
    } catch (e) {
      throw kErrorWithRes;
    }
  }

  @override
  Future<EmptyRes> pickOrderInsertUpdateUnlinkPickOrder({required int pickOrderID, required String updatelog}) async {
    final user = await UserPrefs.shared.getUser;

    final res = await WebService.shared.postApiDIO(
        url: kBaseURL + 'pickorder/pickorderInsertUpdateUnlinkPickOrder',
        data: {"PickOrderID": pickOrderID, "Updatelog": updatelog, "UserID": user.userID});

    try {
      return EmptyRes.fromJson(res!);
    } catch (e) {
      throw kErrorWithRes;
    }
  }

  @override
  Future<EmptyRes> deletePickOrder({required int pickOrderID, required String updateLog}) async {
    final user = await UserPrefs.shared.getUser;

    final res = await WebService.shared.postApiDIO(
        url: kBaseURL + 'pickorder/DeletePickOrder',
        data: {"PickOrderID": pickOrderID, "UpdateLog": updateLog, "UserID": user.userID});

    try {
      return EmptyRes.fromJson(res!);
    } catch (e) {
      throw kErrorWithRes;
    }
  }

  @override
  Future<ResPickOrderAddNote> getPickOrderNoteText({required int pickOrderID}) async {
    final user = await UserPrefs.shared.getUser;

    final res = await WebService.shared.postApiDIO(
        url: kBaseURL + 'pickorder/AddPickOrderNote', data: {"PickOrderID": pickOrderID, "UserID": user.userID});

    try {
      return ResPickOrderAddNote.fromJson(res!);
    } catch (e) {
      throw kErrorWithRes;
    }
  }

  @override
  Future<EmptyRes> savePickOrderNote(
      {required int pickOrderID, required String pickOrderNote, required String updateLog}) async {
    final user = await UserPrefs.shared.getUser;

    final res = await WebService.shared.postApiDIO(url: kBaseURL + 'pickorder/SavePickOrderNote', data: {
      "PickOrderID": pickOrderID,
      "pickOrderNote": pickOrderNote,
      "Updatelog": updateLog,
      "UserID": user.userID
    });

    try {
      return EmptyRes.fromJson(res!);
    } catch (e) {
      throw kErrorWithRes;
    }
  }


  @override
  Future<ResWithPrimaryKeyAndErrorMessage> linkUserToPickOrder({
    required int pickOrderId,
    required String updateLog,
    required int pickOrderLinkedToUserID
  }) async {

    final user = await UserPrefs.shared.getUser;

    final res = await WebService.shared.postApiDIO(url: kBaseURL + 'pickorder/SaveAcknowledgwmentPickOrder', data: {
      "PickOrderID": pickOrderId,
      "PickOrderLinkedTo": pickOrderLinkedToUserID,
      "Updatelog": updateLog,
      "UserID": user.userID
    });

    try {
      return ResWithPrimaryKeyAndErrorMessage.fromJson(res!);
    } catch (e) {
      throw kErrorWithRes;
    }
  }

// Future
}
