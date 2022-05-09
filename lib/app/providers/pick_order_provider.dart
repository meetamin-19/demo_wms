import 'package:demo_win_wms/app/data/entity/res/empty_res.dart';
import 'package:demo_win_wms/app/data/entity/res/res_get_pick_order_data_for_view.dart';
import 'package:demo_win_wms/app/data/entity/res/res_pick_order_sales_order_list.dart';
import 'package:demo_win_wms/app/data/entity/res/res_primarykey_errormessage.dart';
import 'package:demo_win_wms/app/providers/base_notifier.dart';
import 'package:demo_win_wms/app/providers/home_provider.dart';
import 'package:demo_win_wms/app/repository/pick_order_repository.dart';
import 'package:demo_win_wms/app/utils/api_response.dart';

import '../data/entity/res/res_pick_order_list_get.dart';

abstract class PickOrderProvider extends BaseNotifier {}

class PickOrderProviderImpl extends PickOrderProvider {
  final PickOrderRepository repo;

  PickOrderProviderImpl({required this.repo}) {
    _getPickOrder = ApiResponse();
    _deletePickOrder = ApiResponse();
    _getSalesOrderList = ApiResponse();
    _completePickOrder = ApiResponse();
  }

  int pickOrderID = 0;
  int salesOrderID = 0;
  bool isInEditingMode = false;

  ApiResponse<ResGetPickOrderDataForView>? _getPickOrder;

  ApiResponse<ResGetPickOrderDataForView>? get getPickOrder => _getPickOrder;

  ApiResponse<ResSalesOrderListGet>? _getSalesOrderList;

  ApiResponse<ResSalesOrderListGet>? get salesOrderList => _getSalesOrderList;

  ApiResponse<ResWithPrimaryKeyAndErrorMessage>? _completePickOrder;

  ApiResponse<ResWithPrimaryKeyAndErrorMessage>? get completePickOrderVar => _completePickOrder;

  ApiResponse<EmptyRes>? _deletePickOrder;

  ApiResponse<EmptyRes>? get deletePickOrderVar => _deletePickOrder;

  List<SalesOrderList>? filteredSalesOrderDetailList;

  searchFromSalesOderList({required String str}) {
    filteredSalesOrderDetailList = [];
    final searchString = str.toLowerCase();
    if (searchString.replaceAll(' ', '').isEmpty) {
      filteredSalesOrderDetailList = salesOrderList?.data?.data;
      notifyListeners();
    } else {
      filteredSalesOrderDetailList = salesOrderList?.data?.data?.where((element) {
        final doesContains = (element.itemName ?? '').toLowerCase().contains(searchString) ||
            (element.poNumber ?? '').toLowerCase().contains(searchString) ||
            (element.palletNo ?? '').toLowerCase().contains(searchString) ||
            (element.availableQty ?? 0).toString().toLowerCase().contains(searchString) ||
            (element.qty ?? 0).toString().toLowerCase().contains(searchString) ||
            (element.actualPicked ?? 0).toString().toLowerCase().contains(searchString) ||
            (element.uom ?? '').toLowerCase().contains(searchString) ||
            (element.oldestStockSuggestedLocation ?? '').toLowerCase().contains(searchString) ||
            (element.currentPartStatusTerm ?? '').toLowerCase().contains(searchString);
        return doesContains;
      }).toList();
      notifyListeners();
    }
  }

  Future getPickOrderData() async {
    try {
      apiResIsLoading(_getPickOrder!);

      final res = await repo.getPickOrderDataForView(pickOrderID: pickOrderID, salesOrderID: salesOrderID);

      if (res.success == true) {
        apiResIsSuccess<ResGetPickOrderDataForView>(_getPickOrder!, res);
      } else {
        throw '${res.message}';
      }
    } catch (e) {
      apiResIsFailed(_getPickOrder!, e);
      rethrow;
    }
  }

  Future getSalesOrderList({required int numOfData, required int startPoint}) async {
    apiResIsLoading(_getSalesOrderList!);
    try {
      final res = await repo.getSalesOrderList(
          numOfData: numOfData, startPoint: startPoint, pickOrderID: pickOrderID, salesOrderID: salesOrderID);

      if (res.success == true) {
        apiResIsSuccess<ResSalesOrderListGet>(_getSalesOrderList!, res);
        searchFromSalesOderList(str: '');
      } else {
        throw '${res.message}';
      }
    } catch (e) {
      apiResIsFailed(_getSalesOrderList!, e);
      rethrow;
    }
  }

  Future completePickOrder() async {
    apiResIsLoading(_completePickOrder!);

    try {
      final res = await repo.completePickOrder(pickOrderID: pickOrderID);

      if (res.success == true) {
        apiResIsSuccess<ResWithPrimaryKeyAndErrorMessage>(_completePickOrder!, res);
      } else {
        throw '${res.message}';
      }
    } catch (e) {
      apiResIsFailed(_completePickOrder!, e);
      rethrow;
    }
  }
}
