import 'dart:typed_data';

import 'package:dio/dio.dart';
// import 'package:printing/printing.dart';
import 'package:demo_win_wms/app/data/entity/res/res_get_pallet_list_data_by_id.dart';
import 'package:demo_win_wms/app/data/entity/res/res_pick_order_view_line_item.dart';
import 'package:demo_win_wms/app/repository/pallet_repository.dart';
import 'package:demo_win_wms/app/utils/api_response.dart';

import 'base_notifier.dart';

abstract class PalletProvider extends BaseNotifier {

  Future pickOrderViewLineItem();
  Future getPallets();

}

class PalletProviderImpl extends PalletProvider {

  final PalletRepository repo;


  PalletProviderImpl({required this.repo}){
    _lineItemRes = ApiResponse();
    _palletsRes = ApiResponse();
  }

  ApiResponse<ResPickOrderViewLineItem>? _lineItemRes;
  ApiResponse<ResPickOrderViewLineItem>? get lineItemRes => _lineItemRes;

  ApiResponse<ResGetPalletListDataById>? _palletsRes;
  ApiResponse<ResGetPalletListDataById>? get palletsRes => _palletsRes;


  int selectedPickOrderSODetailID = 0;
  int selectedPickOrderID = 0;

  @override
  Future pickOrderViewLineItem() async {
    try {
      apiResIsLoading(_lineItemRes!);

      final res = await repo.pickOrderViewLineItem(
          PickOrderSODetailID: selectedPickOrderSODetailID,
          PickOrderID: selectedPickOrderID);

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

    final response = await Dio().get<Uint8List>('http://www.africau.edu/images/default/sample.pdf',options: Options(responseType: ResponseType.bytes),);
    var pdfData = response.data;
    // Printing.layoutPdf(onLayout: (format) => pdfData!);
    // Printing.directPrintPdf(printer: Printer(url: 'test'), onLayout: (format) => pdfData!); // Need to pass url here for that printers destination
  }

  @override
  Future getPallets() async{
    try {
      _palletsRes?.data = null;

      apiResIsLoading(_palletsRes!);

      final res = await repo.getPalletListDataByID(
          PickOrderSODetailID: selectedPickOrderSODetailID,
          PickOrderID: selectedPickOrderID);

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
  
}