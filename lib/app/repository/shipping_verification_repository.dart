import 'package:demo_win_wms/app/data/datasource/shipping_verification_data.dart';
import 'package:demo_win_wms/app/data/entity/req/req_shipping_verification_list.dart';
import 'package:demo_win_wms/app/data/entity/res/res_shipping_verification_checkforopencreditorder.dart';
import 'package:demo_win_wms/app/data/entity/res/res_shipping_verification_list.dart';
import 'package:demo_win_wms/app/data/entity/res/res_shopping_verification_edit_screen.dart';

import '../data/entity/res/empty_res.dart';
import '../data/entity/res/path_res.dart';

class ShippingVerificationRepository {

  final ShippingVerificationData dataSource;

  ShippingVerificationRepository({required this.dataSource});


  Future<ResShippingVerificationList> getShippingVerificationList(
      {required ReqShippingVerificationListGet req}) async {
    return await dataSource.getShippingVerificationList(req: req);
  }

  Future<ResPath> getASNPath(
      {String? invoiceNo, int? invoiceID, String? pdf}) async {
    return await dataSource.getASNPath(
        invoiceID: invoiceID, invoiceNo: invoiceNo, pdf: pdf);
  }

  Future<ResCheckForOpenCreditOrder> checkForVerification(
      {int? salesOrderID}) async {
    return await dataSource.checkForVerification(salesOrderId: salesOrderID);
  }

  Future<ResShoppingVerificationEditScreen> getEditScreenData(
      {int? salesOrderID, int? pickOrderID, int? i}) async {
    return await dataSource.getEditScreenData(
        pickOrderID: pickOrderID, salesOrderId: salesOrderID, i: i);
  }

  Future<EmptyRes> submitUnVerifiedData(
      {int? pickOrderID, int? salesOrderId, String? soNumber, String? bolNumber, List<
          PickOrderPalletList>? list, String? filePath}) async {
    return await dataSource.submitUnverifiedData(pickOrderID: pickOrderID,
        salesOrderId: salesOrderId,
        bolNumber: bolNumber,
        soNumber: soNumber,
        list: list,
        filePath: filePath);
  }

  Future<EmptyRes> editVerifiedOrder(
      {int? pickOrderID, int? salesOrderId, String? bolNumber,String? filePath}) async {
    return await dataSource.editVerifiedOrder(pickOrderID: pickOrderID,
        salesOrderId: salesOrderId,
        bolNumber: bolNumber,
        filePath: filePath);
  }
}