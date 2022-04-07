import 'package:demo_win_wms/app/data/entity/res/res_get_pick_order_data_for_view.dart';
import 'package:demo_win_wms/app/providers/base_notifier.dart';
import 'package:demo_win_wms/app/repository/pick_order_repository.dart';
import 'package:demo_win_wms/app/utils/api_response.dart';

abstract class PickOrderProvider extends BaseNotifier {

}

class PickOrderProviderImpl extends PickOrderProvider {

  final PickOrderRepository repo;

  PickOrderProviderImpl({required this.repo}){
    _getPickOrder = ApiResponse();
  }

  int pickOrderID = 0;
  int salesOrderID = 0;
  bool isInEditingMode = true;

  ApiResponse<ResGetPickOrderDataForView>? _getPickOrder;
  ApiResponse<ResGetPickOrderDataForView>? get getPickOrder => _getPickOrder;

  List<SalesOrderDetailList>? filteredSalesOrderDetailList;

  searchFromSalesOderList({required String str}){

    final searchString = str.toLowerCase();

    if(searchString.replaceAll(' ', '').isEmpty){
      filteredSalesOrderDetailList = getPickOrder?.data?.data?.salesOrderDetailList;
      notifyListeners();
    }else{
      filteredSalesOrderDetailList = getPickOrder?.data?.data?.salesOrderDetailList?.where((element) {
        final doesContains = (element.itemName ?? '').toLowerCase().contains(searchString)
            || (element.poNumber ?? '').toLowerCase().contains(searchString)
            || (element.palletNo ?? '').toLowerCase().contains(searchString)
            || (element.availableQty ?? 0).toString().toLowerCase().contains(searchString)
            || (element.qty ?? 0).toString().toLowerCase().contains(searchString)
            || (element.actualPicked ?? 0).toString().toLowerCase().contains(searchString)
            || (element.uom ?? '').toLowerCase().contains(searchString)
            || (element.currentPartStatusTerm ?? '').toLowerCase().contains(searchString);
        return doesContains;
      }).toList();
      notifyListeners();
    }

  }

  Future getPickOrderData() async {

    try {
      apiResIsLoading(_getPickOrder!);

      final res = await  repo.getPickOrderDataForView(pickOrderID: pickOrderID, salesOrderID: salesOrderID);

      if(res.success == true) {
        apiResIsSuccess<ResGetPickOrderDataForView>(_getPickOrder!, res);
        searchFromSalesOderList(str: '');
      } else {
        throw '${res.message}';
      }
    } catch (e) {
      apiResIsFailed(_getPickOrder!, e);
      rethrow;
    }

  }

}