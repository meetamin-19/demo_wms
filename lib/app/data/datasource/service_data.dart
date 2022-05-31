import 'package:demo_win_wms/app/data/data_service/web_service.dart';
import 'package:demo_win_wms/app/data/entity/Res/res_pick_order_list_filter.dart';
import 'package:demo_win_wms/app/data/entity/req/req_pick_order_list_filter.dart';
import 'package:demo_win_wms/app/data/entity/res/res_get_container_list_filter.dart';
import 'package:demo_win_wms/app/data/entity/res/res_shipping_verification_list_filter.dart';
import 'package:demo_win_wms/app/utils/constants.dart';

import '../entity/req/req_shipping_verification_filter.dart';

abstract class ServiceData {
  Future<ResPickOrderListFilter> getPickupFilters();

  Future<ResShippingVerificationFilter> getShippingVerificationFilters();

  Future<ResGetContainerListFilter> getContainerListFilters();
}

class ServiceDataImpl extends ServiceData {
  @override
  Future<ResPickOrderListFilter> getPickupFilters() async {
    final res = await WebService.shared.postApiDIO(
        url: kBaseURL + 'pickorder/Get_PickOrderListFilter',
        data: await ReqPickOrderListFilter.toJson());

    try {
      return ResPickOrderListFilter.fromJson(res!);
    } catch (e) {
      throw kErrorWithRes;
    }
  }

  @override
  Future<ResShippingVerificationFilter> getShippingVerificationFilters() async{
    final res = await WebService.shared.postApiDIO(
        url: kBaseURL +
            'shippingverification/Get_ShippingVerificationFilterListData',
        data: await ReqShippingVerificationFilter.toJson());

    try {
      return ResShippingVerificationFilter.fromJson(res!);
    } catch (e) {
      throw kErrorWithRes;
    }
  }

  @override
  Future<ResGetContainerListFilter> getContainerListFilters() async {
    final res = await WebService.shared.postApiDIO(
        url: kBaseURL +
            'receiving/Get_ContainerListFilter',
        data: await ReqShippingVerificationFilter.toJson());

    try {
    return ResGetContainerListFilter.fromJson(res!);
    } catch (e) {
    throw kErrorWithRes;
    }
  }
}
