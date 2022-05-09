import 'dart:typed_data';

import 'package:demo_win_wms/app/data/entity/res/empty_res.dart';
import 'package:demo_win_wms/app/data/entity/res/res_bind_location_list.dart';
import 'package:demo_win_wms/app/data/entity/res/res_check_for_cycle_count.dart';
import 'package:demo_win_wms/app/data/entity/res/res_complete_part_status.dart';
import 'package:demo_win_wms/app/data/entity/res/res_get_location_data.dart';
import 'package:dio/dio.dart';

// import 'package:printing/printing.dart';
import 'package:demo_win_wms/app/data/entity/res/res_get_pallet_list_data_by_id.dart';
import 'package:demo_win_wms/app/data/entity/res/res_pick_order_view_line_item.dart';
import 'package:demo_win_wms/app/repository/pallet_repository.dart';
import 'package:demo_win_wms/app/utils/api_response.dart';

import '../data/entity/req/req_get_scan_part_list.dart';
import 'base_notifier.dart';

abstract class PalletProvider extends BaseNotifier {
  Future pickOrderViewLineItem();

  Future getPallets({required bool addPallet});

  Future checkForCycleCounts();

  Future getCompletePartStatus({required bool cycleCount});

  Future getLocationData({required String locationTitle, required bool isTotePart});

  Future getScanPartList(
      {required int pickOrderId,
      required String palletNo,
      required int pickOrderSODetailID,
      required int itemID,
      required String itemName,
      required int requestedQty,
      required int actualPicked,
      required int year,
      required String month,
      required int boxQty,
      required int companyId,
      required String customCode,
      required int locationID,
      required String locationTypeTerm,
      required int numberOfBoxes,
      required String pONumber,
      required int pOPalletID,
      required int sODetailID,
      required int warehouseID});

  Future completePallet({required int pOPalletId, required int warehouseId, required String updateLog});

  Future updatePOPalletBindLocation({required String locationTitle});

  Future resetLastScannedItemData();

  Future bindLocationToPallet({required int pOPalletID});
}

class PalletProviderImpl extends PalletProvider {
  final PalletRepository repo;

  PalletProviderImpl({required this.repo}) {
    _lineItemRes = ApiResponse();
    _palletsRes = ApiResponse();
    _checkForCycleCount = ApiResponse();
    _getCompletePartStatus = ApiResponse();
    _locationData = ApiResponse();
    _scanPartList = ApiResponse();
    _completePalletVar = ApiResponse();
    _updateBindLocation = ApiResponse();
    _resetPallet = ApiResponse();
    _bindLocation = ApiResponse();
  }

  ApiResponse<ResPickOrderViewLineItem>? _lineItemRes;

  ApiResponse<ResPickOrderViewLineItem>? get lineItemRes => _lineItemRes;

  ApiResponse<ResGetPalletListDataById>? _palletsRes;

  ApiResponse<ResGetPalletListDataById>? get palletsRes => _palletsRes;

  ApiResponse<ResCheckForCycleCount>? _checkForCycleCount;

  ApiResponse<ResCheckForCycleCount>? get checkForCycleCountVar => _checkForCycleCount;

  ApiResponse<ResGetCompletePartStatus>? _getCompletePartStatus;

  ApiResponse<ResGetCompletePartStatus>? get getCompletePartStatusVar => _getCompletePartStatus;

  ApiResponse<ResGetLocationData>? _locationData;

  ApiResponse<ResGetLocationData>? get locationData => _locationData;

  ApiResponse<ResGetPalletListDataById>? _scanPartList;

  ApiResponse<ResGetPalletListDataById>? get scanPartList => _scanPartList;

  ApiResponse<EmptyRes>? _completePalletVar;

  ApiResponse<EmptyRes>? get completePalletVar => _completePalletVar;

  ApiResponse<EmptyRes>? _updateBindLocation;

  ApiResponse<EmptyRes>? get updateBindLocation => _updateBindLocation;

  ApiResponse<EmptyRes>? _resetPallet;

  ApiResponse<EmptyRes>? get resetPallet => _resetPallet;

  ApiResponse<ResBindLocationList>? _bindLocation;

  ApiResponse<ResBindLocationList>? get bindLocation => _bindLocation;

  int selectedPickOrderSODetailID = 0;
  int selectedPickOrderID = 0;
  int selectedItemID = 0;
  String selectedPallet = "";
  String selectedSoNumber = "";
  int warehouseID = 0;
  int selectedPoPalletId = 0;

  @override
  Future pickOrderViewLineItem() async {
    try {
      apiResIsLoading(_lineItemRes!);

      final res = await repo.pickOrderViewLineItem(
          PickOrderSODetailID: selectedPickOrderSODetailID, PickOrderID: selectedPickOrderID);

      if (res.success == true) {
        apiResIsSuccess(_lineItemRes!, res);
      } else {
        throw res.message ?? 'Something Went Wrong';
      }
    } catch (e) {
      apiResIsFailed(_lineItemRes!, e);
    }
  }

  printPdfFromURL() async {
    final response = await Dio().get<Uint8List>(
      'http://www.africau.edu/images/default/sample.pdf',
      options: Options(responseType: ResponseType.bytes),
    );
    var pdfData = response.data;
    // Printing.layoutPdf(onLayout: (format) => pdfData!);
    // Printing.directPrintPdf(printer: Printer(url: 'test'), onLayout: (format) => pdfData!); // Need to pass url here for that printers destination
  }

  @override
  Future getPallets({required bool addPallet}) async {
    try {
      _palletsRes?.data = null;

      apiResIsLoading(_palletsRes!);

      final res = await repo.getPalletListDataByID(
          addPallet: addPallet, PickOrderSODetailID: selectedPickOrderSODetailID, PickOrderID: selectedPickOrderID);

      if (res.success == true) {
        apiResIsSuccess(_palletsRes!, res);
      } else {
        throw res.message ?? 'Something Went Wrong';
      }
    } catch (e) {
      print('EXCEPTION $e');
      apiResIsFailed(_palletsRes!, e);
    }
  }

  @override
  Future checkForCycleCounts() async {
    try {
      apiResIsLoading(_checkForCycleCount!);

      final res = await repo.checkForCycleCount(
          pickOrderSODetailID: selectedPickOrderSODetailID, pickOrderId: selectedPickOrderID, itemId: selectedItemID);

      if (res.success == true) {
        apiResIsSuccess(_checkForCycleCount!, res);
      } else {
        throw res.message ?? 'Something Went Wrong';
      }
    } catch (e) {
      apiResIsFailed(_checkForCycleCount!, e);
    }
  }

  @override
  Future getCompletePartStatus({required bool cycleCount}) async {
    try {
      apiResIsLoading(_getCompletePartStatus!);

      final res = await repo.getCompletePartStatus(
          cycleCount: cycleCount,
          pickOrderSODetailID: selectedPickOrderSODetailID,
          pickOrderId: selectedPickOrderID,
          itemId: selectedItemID);

      if (res.success == true) {
        apiResIsSuccess(_getCompletePartStatus!, res);
      } else {
        throw res.message ?? 'Something went wrong';
      }
    } catch (e) {
      apiResIsFailed(_getCompletePartStatus!, e);
    }
  }

  @override
  Future getLocationData({required String locationTitle, required bool isTotePart}) async {
    try {
      apiResIsLoading(_locationData!);

      final res = await repo.getLocationData(
          pickOrderSODetailID: selectedPickOrderSODetailID, locationTitle: locationTitle, isTotePart: isTotePart);

      if (res.success == true) {
        apiResIsSuccess(_locationData!, res);
        pickOrderViewLineItem();
      } else {
        throw res.message ?? 'Something went wrong';
      }
    } catch (e) {
      apiResIsFailed(_locationData!, e);
    }
  }

  @override
  Future getScanPartList(
      {required int pickOrderId,
      required String palletNo,
      required int pickOrderSODetailID,
      required int itemID,
      required String itemName,
      required int requestedQty,
      required int actualPicked,
      required int year,
      required String month,
      required int boxQty,
      required int companyId,
      required String customCode,
      required int locationID,
      required String locationTypeTerm,
      required int numberOfBoxes,
      required String pONumber,
      required int pOPalletID,
      required int sODetailID,
      required int warehouseID}) async {
    try {
      apiResIsLoading(_scanPartList!);
      final res = await repo.getScanPartList(
          req: ReqScanPartList(
              pickOrderId: pickOrderId,
              palletNo: palletNo,
              pickOrderSODetailID: pickOrderSODetailID,
              itemID: itemID,
              itemName: itemName,
              requestedQty: requestedQty,
              actualPicked: actualPicked,
              year: year,
              month: month,
              boxQty: boxQty,
              companyId: companyId,
              customCode: customCode,
              locationID: locationID,
              locationTypeTerm: locationTypeTerm,
              numberOfBoxes: numberOfBoxes,
              pONumber: pONumber,
              pOPalletID: pOPalletID,
              sODetailID: sODetailID,
              warehouseID: warehouseID));
      if (res.success == true) {
        apiResIsSuccess(_scanPartList!, res);
        pickOrderViewLineItem();
        getPallets(addPallet: false);
      } else {
        throw res.message ?? "Something";
      }
    } catch (e) {
      apiResIsFailed(_scanPartList!, e);
    }
  }

  @override
  Future completePallet({required int pOPalletId, required int warehouseId, required String updateLog}) async {
    try {
      apiResIsLoading(_completePalletVar!);

      final res = await repo.completePallet(
          pOPalletId: pOPalletId,
          pickOrderID: selectedPickOrderID,
          pickOrderSODetailID: selectedPickOrderSODetailID,
          warehouseId: warehouseId,
          updateLog: updateLog);
      if (res.success == true) {
        apiResIsSuccess(_completePalletVar!, res);
        getPallets(addPallet: false);
      } else {
        throw res.message ?? 'Something went wrong';
      }
    } catch (e) {
      apiResIsFailed(_completePalletVar!, e);
    }
  }

  @override
  Future updatePOPalletBindLocation({required String locationTitle}) async {
    try {
      apiResIsLoading(_updateBindLocation!);

      final res = await repo.updatePOPalletBindLocation(
          pOPalletId: selectedPoPalletId,
          pickOrderID: selectedPickOrderID,
          pickOrderSODetailID: selectedPickOrderSODetailID,
          warehouseId: warehouseID,
          locationTitle: locationTitle);
      if (res.success == true) {
        apiResIsSuccess(_updateBindLocation!, res);
        getPallets(addPallet: false);
      } else {
        throw res.message ?? 'Something went wrong';
      }
    } catch (e) {
      apiResIsFailed(_updateBindLocation!, e);
    }
  }

  @override
  Future resetLastScannedItemData() async {
    try {
      apiResIsLoading(_resetPallet!);

      final res = await repo.resetLastScannedItemData(
          pOPalletId: selectedPoPalletId,
          pickOrderID: selectedPickOrderID,
          pickOrderSODetailID: selectedPickOrderSODetailID);
      if (res.success == true) {
        apiResIsSuccess(_resetPallet!, res);
        getPallets(addPallet: false);
      } else {
        throw res.message ?? 'Something went wrong';
      }
    } catch (e) {
      apiResIsFailed(_resetPallet!, e);
    }
  }

  @override
  Future bindLocationToPallet({required int pOPalletID}) async {
    try {
      apiResIsLoading(_bindLocation!);

      final res = await repo.bindLocationToPickedPallet(pOPalletId: pOPalletID, pickOrderID: selectedPickOrderID);
      if (res.success == true) {
        apiResIsSuccess(_bindLocation!, res);
      } else {
        throw res.message ?? 'Something went wrong';
      }
    } catch (e) {
      apiResIsFailed(_bindLocation!, e);
    }
  }
}
