
import 'package:demo_win_wms/app/data/datasource/service_data.dart';
import 'package:demo_win_wms/app/data/entity/Res/res_pick_order_list_filter.dart';
import 'package:demo_win_wms/app/data/entity/res/res_shipping_verification_list_filter.dart';

class ServiceRepository{

  final ServiceData dataSource;

  ServiceRepository({required this.dataSource});

  Future<ResPickOrderListFilter> getPickupFilters() async {
    return await dataSource.getPickupFilters();
  }

  Future<ResShippingVerificationFilter> getShippingVerificationFilters() async {
    return await dataSource.getShippingVerificationFilters();
  }
}