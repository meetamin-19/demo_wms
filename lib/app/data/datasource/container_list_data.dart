import 'package:demo_win_wms/app/data/data_service/web_service.dart';
import 'package:demo_win_wms/app/data/entity/req/req_container_list.dart';
import 'package:demo_win_wms/app/data/entity/res/empty_res.dart';
import 'package:demo_win_wms/app/data/entity/res/res_container_link_location.dart';
import 'package:demo_win_wms/app/data/entity/res/res_get_container_list.dart';
import 'package:demo_win_wms/app/data/entity/res/res_shipping_verification_list.dart';
import 'package:demo_win_wms/app/utils/constants.dart';
import 'package:demo_win_wms/app/utils/user_prefs.dart';

abstract class ContainerListData {
  Future<ResGetContainerList> getContainerList({required ReqGetContainerList req});

  Future<ResContainerLinkLocation> getContainerLinkLocationList({required int id});

  Future<EmptyRes> deleteContainer({required int containerID, required String updateLog});


}

class ContainerListDataImpl extends ContainerListData {
  @override
  Future<ResGetContainerList> getContainerList({required ReqGetContainerList req}) async {
    final res = await WebService.shared
        .postApiDIO(url: kBaseURL + 'receiving/Get_ContainerListFilterSelection', data: await req.toJson());

    print(req.toJson());

    try {
      return ResGetContainerList.fromJson(res!);
    } catch (e) {
      print(e.toString());
      throw kErrorWithRes;
    }
  }

  @override
  Future<ResContainerLinkLocation> getContainerLinkLocationList({required int id}) async {

    final user = await UserPrefs.shared.getUser;

    final res = await WebService.shared.postApiDIO(
        url: kBaseURL + 'receiving/GetAddLinkLocationListData', data: {"ContainerID": id, "UserID": user.userID,
    "UserType_Term": user.userType_Term,"DefaultCompanyID":user.defaultCompanyID,"DefaultWarehouseID":user.defaultWarehouseID});
    print(res.toString());
    try {
      return ResContainerLinkLocation.fromJson(res!);
    } catch (e) {
      throw kErrorWithRes;
    }

  }

  @override
  Future<EmptyRes> deleteContainer({required int containerID, required String updateLog}) async {
    final user = await UserPrefs.shared.getUser;

    final res = await WebService.shared.postApiDIO(
        url: kBaseURL + 'receiving/EmptyContainer',
        data: {"ContainerID": containerID, "UpdateLog": updateLog, "UserID": user.userID});

    try {
      return EmptyRes.fromJson(res!);
    } catch (e) {
      throw kErrorWithRes;
    }
  }
}
