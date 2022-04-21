import 'package:demo_win_wms/app/data/data_service/web_service.dart';
import 'package:demo_win_wms/app/data/entity/home_entity.dart';
import 'package:demo_win_wms/app/data/entity/req/req_pick_order_list_get.dart';
import 'package:demo_win_wms/app/data/entity/res/empty_res.dart';
import 'package:demo_win_wms/app/data/entity/res/res_pick_order_list_get.dart';
import 'package:demo_win_wms/app/data/entity/res/res_pickorder_link_user_list.dart';
import 'package:demo_win_wms/app/utils/constants.dart';
import 'package:demo_win_wms/app/utils/user_prefs.dart';

abstract class HomeData{

  Future<ResPickOrderListGet> getPickOrderList({required ReqPickOrderListGet req});
  Future<EmptyRes> changePickOrderStatus({required int id});
  Future<ResPickorderLinkUserList> pickOrderLinkPickOrder({required int id});
  Future<EmptyRes> pickOrderInsertUpdateLinkPickOrder({required int pickOrderID, required String pickOrderLinkedTo, required String updatelog});
  Future<EmptyRes> pickOrderInsertUpdateUnlinkPickOrder({required int pickOrderID, required String updatelog});

}


class HomeDataImpl implements HomeData{

  @override
  Future<ResPickOrderListGet> getPickOrderList({required ReqPickOrderListGet req}) async{

    final res = await WebService.shared.postApiDIO(url: kBaseURL + 'pickorder/Get_PickOrderListFilterSelection',data: await req.toJson());

    try {
      return ResPickOrderListGet.fromJson(res!);
    }catch (e) {
      throw kErrorWithRes;
    }
  }


  @override
  Future<EmptyRes> changePickOrderStatus({required int id}) async{

    final user = await UserPrefs.shared.getUser;

    final res = await WebService.shared.postApiDIO(url: kBaseURL + 'pickorder/GetpickOrder_ChangePickOrderStatus',data: {
      "PickOrderID": id,
      "UserID": user.userID
    });

    try {
    return EmptyRes.fromJson(res!);
    }catch (e) {
      throw kErrorWithRes;
    }
  }

  @override
  Future<ResPickorderLinkUserList> pickOrderLinkPickOrder({required int id}) async {
    final user = await UserPrefs.shared.getUser;

    final res = await WebService.shared.postApiDIO(url: kBaseURL + 'pickorder/pickorderLinkPickOrder',data: {
      "PickOrderID": id,
      "UserID": user.userID
    });

    try {
      return ResPickorderLinkUserList.fromJson(res!);
    }catch (e) {
      throw kErrorWithRes;
    }
  }

  @override
  Future<EmptyRes> pickOrderInsertUpdateLinkPickOrder({required int pickOrderID, required String pickOrderLinkedTo, required String updatelog}) async {
    final user = await UserPrefs.shared.getUser;

    final res = await WebService.shared.postApiDIO(url: kBaseURL + 'pickorder/pickorderInsertUpdateLinkPickOrder',data: {
      "PickOrderID": pickOrderID,
      "PickOrderLinkedTo": pickOrderLinkedTo,
      "Updatelog": updatelog,
      "UserID": user.userID
    });

    try {
      return EmptyRes.fromJson(res!);
    }catch (e) {
      throw kErrorWithRes;
    }
  }

  @override
  Future<EmptyRes> pickOrderInsertUpdateUnlinkPickOrder({required int pickOrderID, required String updatelog}) async {
    final user = await UserPrefs.shared.getUser;

    final res = await WebService.shared.postApiDIO(url: kBaseURL + 'pickorder/pickorderInsertUpdateUnlinkPickOrder',data: {
      "PickOrderID": pickOrderID,
      "Updatelog": updatelog,
      "UserID": user.userID
    });

    try {
      return EmptyRes.fromJson(res!);
    }catch (e) {
      throw kErrorWithRes;
    }

  }
}
