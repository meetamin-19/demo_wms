import 'package:demo_win_wms/app/data/entity/Res/res_pick_order_list_filter.dart';
import 'package:demo_win_wms/app/data/entity/req/req_pick_order_list_get.dart';
import 'package:demo_win_wms/app/data/entity/res/empty_res.dart';
import 'package:demo_win_wms/app/data/entity/res/res_pick_order_add_note.dart';
import 'package:demo_win_wms/app/data/entity/res/res_pick_order_list_get.dart';
import 'package:demo_win_wms/app/data/entity/res/res_pickorder_link_user_list.dart';
import 'package:demo_win_wms/app/providers/service_provider.dart';
import 'package:demo_win_wms/app/repository/home_repo.dart';
import 'package:demo_win_wms/app/utils/api_response.dart';

import 'base_notifier.dart';

class HomeProvider extends BaseNotifier {
  HomeRepository repo;

  ApiResponse<ResPickOrderListGet>? _pickOrderList;

  ApiResponse<ResPickOrderListGet>? get pickOrderList => _pickOrderList;

  ApiResponse<EmptyRes>? _statusChange;

  ApiResponse<EmptyRes>? get statusChange => _statusChange;

  ApiResponse<ResPickorderLinkUserList>? _assignedToUserList;

  ApiResponse<ResPickorderLinkUserList>? get assignedToUserList => _assignedToUserList;

  ApiResponse<EmptyRes>? _linkUser;

  ApiResponse<EmptyRes>? get linkUser => _linkUser;

  ApiResponse<EmptyRes>? _unLinkUser;

  ApiResponse<EmptyRes>? get unLinkUser => _unLinkUser;

  ApiResponse<EmptyRes>? _deletePickOrder;
  ApiResponse<EmptyRes>? get deletePickOrderVar => _deletePickOrder;


  ApiResponse<ResPickOrderAddNote>? _pickOrderNote;
  ApiResponse<ResPickOrderAddNote>? get getPickOrderNote => _pickOrderNote;



  List<ResPickOrderListGetData>? filteredPickOrderList;


  final ServiceProviderImpl service;

  HomeProvider({required this.repo, required this.service}) {
    _pickOrderList = ApiResponse();
    _statusChange = ApiResponse();
    _assignedToUserList = ApiResponse();
    _linkUser = ApiResponse();
    _unLinkUser = ApiResponse();
    _deletePickOrder = ApiResponse();
    _pickOrderNote = ApiResponse();
  }

  getFilters() {
    service.getPickupFilters();
  }

  Future getPickerList(
      {Company? company,
      Company? warehouse,
      Company? customer,
      Company? cusLoc,
      DateTime? startDate,
      DateTime? endDate,
      Company? shipVia,
      String? status}) async {
    try {
      apiResIsLoading(_pickOrderList!);

      final res = await repo.getPickOrderList(
          req: ReqPickOrderListGet(
              warehouseId: warehouse?.value ?? '0',
              companyId: company?.value ?? '0',
              customerId: customer?.value ?? '0',
              customerLocationId: cusLoc?.value ?? '0',
              shipperId: shipVia?.value ?? '0',
              statusTermStr: status ?? '',
              fromShipDateStr: startDate?.toIso8601String() ?? '',
              toShipDateStr: endDate?.toIso8601String() ?? ''));

      if (res.success == true) {
        apiResIsSuccess<ResPickOrderListGet>(_pickOrderList!, res);
      } else {
        throw res.message ?? "Something Went Wrong";
      }
    } catch (e) {
      apiResIsFailed(_pickOrderList!, e);
      rethrow;
    }
  }

  searchFromPickOrderList({required String str}) {
    final searchString = str.toLowerCase();

    if (searchString.replaceAll(' ', '').isEmpty) {
      filteredPickOrderList = _pickOrderList?.data?.data;
      notifyListeners();
    } else {
      filteredPickOrderList = _pickOrderList?.data?.data?.where((element) {
        final doesContains = (element.salesOrderId ?? 0).toString().toLowerCase().contains(searchString) ||
            (element.companyName ?? '').toLowerCase().contains(searchString) ||
            (element.customerLocation ?? '').toLowerCase().contains(searchString) ||
            (element.customerName ?? 0).toString().toLowerCase().contains(searchString) ||
            (element.warehouseName ?? 0).toString().toLowerCase().contains(searchString) ||
            (element.carrierName ?? 0).toString().toLowerCase().contains(searchString) ||
            (element.shipperName ?? '').toLowerCase().contains(searchString) ||
            (element.statusTerm ?? '').toLowerCase().contains(searchString) ||
            (element.createdDate ?? '').toLowerCase().contains(searchString) ||
            (element.shippingDate ?? '').toLowerCase().contains(searchString);
        return doesContains;
      }).toList();
      notifyListeners();
    }
  }

  Future changePickOrderStatus({required int id}) async {
    try {
      apiResIsLoading(_statusChange!);

      final res = await repo.changePickOrderStatus(id: id);

      if (res.success == true) {
        apiResIsSuccess<EmptyRes>(_statusChange!, res);
      } else {
        throw res.message ?? "Something Went Wrong";
      }
    } catch (e) {
      print(e);
      apiResIsFailed(_statusChange!, e);
      rethrow;
    }
  }

  Future pickorderLinkPickOrder({required int id}) async {
    try {
      apiResIsLoading(_assignedToUserList!);

      final res = await repo.pickorderLinkPickOrder(id: id);

      if (res.success == true) {
        apiResIsSuccess<ResPickorderLinkUserList>(_assignedToUserList!, res);
      } else {
        throw res.message ?? "Something Went Wrong";
      }
    } catch (e) {
      print(e);
      apiResIsFailed(_assignedToUserList!, e);
      rethrow;
    }
  }

  Future deletePickOrder({ResPickOrderListGetData? data}) async {

    try {
      apiResIsLoading(_deletePickOrder!);

      final res = await  repo.deletePickOrder(pickOrderID: data?.pickOrderId ?? 0, updateLog: data?.updatelog ?? '');

      if(res.success == true) {
        apiResIsSuccess<EmptyRes>(_deletePickOrder!, res);
      } else {
        throw '${res.message}';
      }
    } catch (e) {
      apiResIsFailed(_deletePickOrder!, e);
      rethrow;
    }

  }  Future getPickOrderNoteText({int? pickOrderId}) async {

    try {
      apiResIsLoading(_pickOrderNote!);

      final res = await  repo.getPickOrderNoteText(pickOrderID: pickOrderId ?? 0);

      if(res.success == true) {
        apiResIsSuccess<ResPickOrderAddNote>(_pickOrderNote!, res);
      } else {
        throw '${res.message}';
      }
    } catch (e) {
      apiResIsFailed(_pickOrderNote!, e);
      rethrow;
    }

  }

  Future pickorderInsertUpdateLinkPickOrder({ResPickOrderListGetData? data, required String assignToId}) async {
    try {
      apiResIsLoading(_linkUser!);

      final res = await repo.pickorderInsertUpdateLinkPickOrder(
          pickOrderID: data?.pickOrderId ?? 0, pickOrderLinkedTo: assignToId, updatelog: data?.updatelog ?? '');

      if (res.success == true) {
        apiResIsSuccess<EmptyRes>(_linkUser!, res);
        getPickerList();
      } else {
        throw res.message ?? "Something Went Wrong";
      }
    } catch (e) {
      print(e);
      apiResIsFailed(_linkUser!, e);
      getPickerList();
      rethrow;
    }
  }

  Future pickorderInsertUpdateUnlinkPickOrder({ResPickOrderListGetData? data}) async {
    try {
      apiResIsLoading(_unLinkUser!);

      final res = await repo.pickorderInsertUpdateUnlinkPickOrder(
          pickOrderID: data?.pickOrderId ?? 0, updatelog: data?.updatelog ?? "");

      if (res.success == true) {
        apiResIsSuccess<EmptyRes>(_unLinkUser!, res);
        getPickerList();
      } else {
        throw res.message ?? "Something Went Wrong";
      }
    } catch (e) {
      print(e);
      apiResIsFailed(_unLinkUser!, e);
      getPickerList();
      rethrow;
    }
  }
}
