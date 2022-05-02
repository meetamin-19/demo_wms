import 'dart:typed_data';

import 'package:demo_win_wms/app/data/entity/res/res_check_for_cycle_count.dart';
import 'package:demo_win_wms/app/data/entity/res/res_complete_part_status.dart';
import 'package:dio/dio.dart';

// import 'package:printing/printing.dart';
import 'package:demo_win_wms/app/data/entity/res/res_get_pallet_list_data_by_id.dart';
import 'package:demo_win_wms/app/data/entity/res/res_pick_order_view_line_item.dart';
import 'package:demo_win_wms/app/repository/pallet_repository.dart';
import 'package:demo_win_wms/app/utils/api_response.dart';

import 'base_notifier.dart';

abstract class PalletProvider extends BaseNotifier {
  Future pickOrderViewLineItem();

  Future getPallets({required bool addPallet});

  Future checkForCycleCounts();

  Future getCompletePartStatus({required bool cycleCount});
}

class PalletProviderImpl extends PalletProvider {
  final PalletRepository repo;

  PalletProviderImpl({required this.repo}) {
    _lineItemRes = ApiResponse();
    _palletsRes = ApiResponse();
    _checkForCycleCount = ApiResponse();
    _getCompletePartStatus = ApiResponse();
  }

  ApiResponse<ResPickOrderViewLineItem>? _lineItemRes;

  ApiResponse<ResPickOrderViewLineItem>? get lineItemRes => _lineItemRes;

  ApiResponse<ResGetPalletListDataById>? _palletsRes;

  ApiResponse<ResGetPalletListDataById>? get palletsRes => _palletsRes;

  ApiResponse<ResCheckForCycleCount>? _checkForCycleCount;

  ApiResponse<ResCheckForCycleCount>? get checkForCycleCountVar => _checkForCycleCount;

  ApiResponse<ResGetCompletePartStatus>? _getCompletePartStatus;

  ApiResponse<ResGetCompletePartStatus>? get getCompletePartStatusVar => _getCompletePartStatus;

  int selectedPickOrderSODetailID = 0;
  int selectedPickOrderID = 0;
  int selectedItemID = 0;

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
        addPallet: addPallet,
          PickOrderSODetailID: selectedPickOrderSODetailID, PickOrderID: selectedPickOrderID);

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
}
