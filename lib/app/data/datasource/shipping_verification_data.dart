import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:demo_win_wms/app/data/entity/req/req_shipping_verification_list.dart';
import 'package:demo_win_wms/app/data/entity/res/empty_res.dart';
import 'package:demo_win_wms/app/data/entity/res/res_shipping_verification_checkforopencreditorder.dart';
import 'package:demo_win_wms/app/data/entity/res/res_shipping_verification_list.dart';
import 'package:demo_win_wms/providers_list.dart';

import '../../utils/constants.dart';
import '../../utils/user_prefs.dart';
import '../data_service/web_service.dart';
import '../entity/req/req_pick_order_list_get.dart';
import '../entity/res/path_res.dart';
import '../entity/res/res_shopping_verification_edit_screen.dart';

abstract class ShippingVerificationData {
  Future<ResShippingVerificationList> getShippingVerificationList(
      {required ReqShippingVerificationListGet req});

  Future<ResPath> getASNPath({String? invoiceNo, int? invoiceID, String? pdf});

  Future<ResCheckForOpenCreditOrder> checkForVerification({int? salesOrderId});

  Future<ResShoppingVerificationEditScreen> getEditScreenData(
      {int? pickOrderID, int? salesOrderId, int? i});

  Future<EmptyRes> submitUnverifiedData(
      {int? pickOrderID, int? salesOrderId, String? soNumber, String? bolNumber, List<
          PickOrderPalletList>? list, String? filePath});

  Future<EmptyRes> editVerifiedOrder( {int? pickOrderID, int? salesOrderId, String? bolNumber, String? filePath});
// Future<>

// Future<Res>
}

class ShippingVerificationDataImpl extends ShippingVerificationData {
  @override
  Future<ResShippingVerificationList> getShippingVerificationList(
      {required ReqShippingVerificationListGet req}) async {
    final res = await WebService.shared.postApiDIO(
        url: kBaseURL + 'shippingverification/Get_ShippingVerificationList',
        data: await req.toJson());

    try {
      return ResShippingVerificationList.fromJson(res!);
    } catch (e) {
      print(e.toString());
      throw kErrorWithRes;
    }
  }

  @override
  Future<ResPath> getASNPath(
      {String? invoiceNo, int? invoiceID, String? pdf}) async {
    final user = await UserPrefs.shared.getUser;
    String urlforPDF;

    final urlForASNPDF = "shippingverification/GetPackagingASNData";
    final urlForInvoicePDf = "shippingverification/GetInvoicePDF";
    if (pdf == "ASN") {
      urlforPDF = urlForASNPDF;
    } else if (pdf == "INVOICE") {
      urlforPDF = urlForInvoicePDf;
    } else {
      urlforPDF = "shippingverification/GetCreditMemoPDF";
    }
    final res = await WebService.shared.postApiDIO(
        url: kBaseURL + urlforPDF,
        data: {
          "invoiceNo": invoiceNo,
          "invoiceID": invoiceID,
          "UserID": user.userID
        });
    try {
      return ResPath.fromJson(res!);
    } catch (e) {
      throw kErrorWithRes;
    }
  }

  @override
  Future<ResCheckForOpenCreditOrder> checkForVerification(
      {int? salesOrderId}) async {
    final user = await UserPrefs.shared.getUser;
    final res = await WebService.shared.postApiDIO(
        url: kBaseURL + "shippingverification/CheckForOpenCreditOrder",
        data: {"SalesOrderID": salesOrderId, "UserID": user.userID});
    try {
      return ResCheckForOpenCreditOrder.fromJson(res!);
    } catch (e) {
      throw kErrorWithRes;
    }
  }

  @override
  Future<ResShoppingVerificationEditScreen> getEditScreenData(
      {int? pickOrderID, int? salesOrderId, int? i}) async {
    final user = await UserPrefs.shared.getUser;
    final urlForUnverified = "shippingverification/verifyorder";
    final urlForVerified = "shippingverification/editverifiedorder";
    final finalPath = i == 1 ? urlForVerified : urlForUnverified;
    final res = await WebService.shared.postApiDIO(
        url: kBaseURL + finalPath,
        data: {
          "SalesOrderID": salesOrderId,
          "UserID": user.userID,
          "PickOrderID": pickOrderID
        });
    try{
    return ResShoppingVerificationEditScreen.fromJson(res!);
    } catch (e) {
      throw kErrorWithRes;
    }
  }

  @override
  Future<EmptyRes> submitUnverifiedData(
      {int? pickOrderID, int? salesOrderId, String? soNumber, String? bolNumber, List<
          PickOrderPalletList>? list, String? filePath}) async {
    final user = await UserPrefs.shared.getUser;

    Map<String,dynamic> req = {
      "SalesOrderID" : salesOrderId ?? 0,
      "Attachment" : filePath == "" ?  null : await MultipartFile.fromFile(filePath!) ,
      "PickOrderID" : pickOrderID ?? 0,
      "SONumber" : soNumber ?? 0,
      "UserID" : user.userID,
      "BOLNumber" : bolNumber ?? 0,
    };

    list?.asMap().forEach((index, value) {

      req["ApipickOrderPalletList[$index].PalletNo"] = value.palletNo;
      req["ApipickOrderPalletList[$index].Status_Term"] = "Verified";
      req["ApipickOrderPalletList[$index].ScanDateTimeStr"] = DateFormat('MM-dd-yyyy').format(DateTime.now());

    });

    var formData = FormData.fromMap(req);

    print(req);

    final res = await WebService.shared.postApiDIO(
        url: kBaseURL + 'shippingverification/saveshippingverification', data: formData );
    try{
      return EmptyRes.fromJson(res!);
    } catch (e) {
      throw kErrorWithRes;
    }
  }

  @override
  Future<EmptyRes> editVerifiedOrder({int? pickOrderID, int? salesOrderId, String? bolNumber, String? filePath}) async{
    final user = await UserPrefs.shared.getUser;
    var formData = FormData.fromMap({
      "SalesOrderID" : salesOrderId ?? 0,
      "Attachment" : filePath == "" ?  null : await MultipartFile.fromFile(filePath!) ,
      "PickOrderID" : pickOrderID ?? 0,
      "UserID" : user.userID,
      "BOLNumber" : bolNumber ?? 0,
    });
    final res = await WebService.shared.postApiDIO(
        url: kBaseURL + 'shippingverification/editshippingverification', data: formData );
    try{
      return EmptyRes.fromJson(res!);
    } catch (e) {
      throw kErrorWithRes;
    }
  }

}
