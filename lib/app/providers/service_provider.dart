import 'package:demo_win_wms/app/data/data_service/web_service.dart';
import 'package:demo_win_wms/app/data/entity/Res/res_pick_order_list_filter.dart';
import 'package:demo_win_wms/app/data/entity/res/res_shipping_verification_list_filter.dart';
import 'package:demo_win_wms/app/repository/service_repository.dart';
import 'package:demo_win_wms/app/utils/api_response.dart';

import 'base_notifier.dart';

abstract class ServiceProvider {

  Future getPickupFilters();
  Future getShippingVerificationFilters();
}

class ServiceProviderImpl extends BaseNotifier implements ServiceProvider{

  final ServiceRepository repo;

  ServiceProviderImpl({required this.repo}){
    _pickOrderFilters = ApiResponse();
    _shippingverificationfilters = ApiResponse();
  }

  ApiResponse<ResPickOrderListFilter>? _pickOrderFilters;
  ApiResponse<ResPickOrderListFilter>? get pickOrderFilters => _pickOrderFilters;

  ApiResponse<ResShippingVerificationFilter>? _shippingverificationfilters;
  ApiResponse<ResShippingVerificationFilter>? get shippingverificationfilters => _shippingverificationfilters;


  List<Company>? get companyFilter => _pickOrderFilters?.data?.data?.company;
  List<Company>? get customerFilter => _pickOrderFilters?.data?.data?.customer;
  List<Company>? get customerLocationFilter => _pickOrderFilters?.data?.data?.customerLocation;
  // List<Company>? get statusFilter => _pickOrderFilters?.data?.data?.status;
  List<Company>? get shipViaFilter => _pickOrderFilters?.data?.data?.shipVia;


  List<CarrierlistElement>? get customerlistFilter => _shippingverificationfilters?.data?.data?.customerlist;
  List<CarrierlistElement>? get customerlocationlist => _shippingverificationfilters?.data?.data?.customerlocationlist;
  List<CarrierlistElement>? get shipvialist => _shippingverificationfilters?.data?.data?.shipvialist;
  List<CarrierlistElement>? get carrierlist => _shippingverificationfilters?.data?.data?.carrierlist;


  @override
  Future getPickupFilters() async {

    try {
      if (_pickOrderFilters != null){
            apiResIsLoading(_pickOrderFilters!);

            final res = await repo.dataSource.getPickupFilters();

            if (res.success == true){

              apiResIsSuccess(_pickOrderFilters!, res);

            }else{
              throw res.message ?? 'Something went wrong.';
            }

          }else{
            throw 'Declaration Problem';
          }
    }catch (e) {
      apiResIsFailed(_pickOrderFilters!, e);
      rethrow;
    }
  }

  @override
  Future getShippingVerificationFilters() async {

    try {
      if (_shippingverificationfilters != null){
        apiResIsLoading(_shippingverificationfilters!);

        final res = await repo.dataSource.getShippingVerificationFilters();

        if (res.success == true){

          apiResIsSuccess(_shippingverificationfilters!, res);

        }else{
          throw res.message ?? 'Something went wrong.';
        }

      }else{
        throw 'Declaration Problem';
      }
    }catch (e) {
      apiResIsFailed(_shippingverificationfilters!, e);
      rethrow;
    }
  }

}