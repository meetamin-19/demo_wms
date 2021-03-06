import 'package:demo_win_wms/app/data/entity/req/req_shipping_verification_list.dart';
import 'package:demo_win_wms/app/data/entity/res/empty_res.dart';
import 'package:demo_win_wms/app/data/entity/res/path_res.dart';
import 'package:demo_win_wms/app/data/entity/res/res_primarykey_errormessage.dart';
import 'package:demo_win_wms/app/data/entity/res/res_shipping_verification_list.dart';
import 'package:demo_win_wms/app/data/entity/res/res_shipping_verification_list_filter.dart';
import 'package:demo_win_wms/app/data/entity/res/res_shopping_verification_edit_screen.dart';
import 'package:demo_win_wms/app/repository/shipping_verification_repository.dart';
import 'package:demo_win_wms/app/utils/extension.dart';
import '../utils/api_response.dart';
import 'base_notifier.dart';

class ShippingVerificationProvider extends BaseNotifier {
  final ShippingVerificationRepository repo;

  String? imagePath = "";
  ApiResponse<ResShippingVerificationList>? _shippingVerificationList;

  var imageName;

  ApiResponse<ResShippingVerificationList>? get shippingVerificationList =>
      _shippingVerificationList;

  List<ShippingVerificationListData>? shippingList;

  ApiResponse<ResPath>? _getBolPDF ;
  ApiResponse<ResPath>? get getBolPDF => _getBolPDF;

  ApiResponse<ResPath>? _getASN_PdfPath;
  ApiResponse<ResPath>? get getASN_PdfPath => _getASN_PdfPath;

  ApiResponse<ResWithPrimaryKeyAndErrorMessage>? _checkForVerification;
  ApiResponse<ResWithPrimaryKeyAndErrorMessage>? get checkForVrf =>
      _checkForVerification;

  ApiResponse<ResShoppingVerificationEditScreen>? _editScreen;
  ApiResponse<ResShoppingVerificationEditScreen>? get editScreen => _editScreen;

  ApiResponse<EmptyRes>? _submitUnverifiedData;
  ApiResponse<EmptyRes>? get submitUnverifiedDataGet => _submitUnverifiedData;

  ApiResponse<EmptyRes>? _editVerifiedOrder;
  ApiResponse<EmptyRes>? get editVerifiedOrderGet => _editVerifiedOrder;

  ShippingVerificationProvider({required this.repo}) {
    _shippingVerificationList = ApiResponse();
    _getASN_PdfPath = ApiResponse();
    _checkForVerification = ApiResponse();
    _editScreen = ApiResponse();
    _submitUnverifiedData = ApiResponse();
    _editVerifiedOrder = ApiResponse();
    _getBolPDF = ApiResponse();
    shippingList = [];
    // filteredShippingVerificationData = [];
  }

  List<ShippingVerificationListData>? filteredShippingVerificationData;

  searchFromShippingVerificationList({required String str}){

    filteredShippingVerificationData =[];

    final searchString = str.toLowerCase();

    if(searchString.replaceAll(' ', '').isEmpty){
      filteredShippingVerificationData = _shippingVerificationList?.data?.data;
      notifyListeners();
    }else{
      filteredShippingVerificationData = _shippingVerificationList?.data?.data?.where((element) {
        final doesContains = (element.soNumber ?? '').toLowerCase().contains(searchString)
            || (element.customerName ?? '').toLowerCase().contains(searchString)
            || (element.customerLocation ?? '').toLowerCase().contains(searchString)
            || (element.shipperName ?? 0).toString().toLowerCase().contains(searchString)
            || (element.carrierName ?? 0).toString().toLowerCase().contains(searchString)
            || (element.shipDate ?? 0).toString().toLowerCase().contains(searchString);
        return doesContains;
      }).toList();
      notifyListeners();
    }

  }

  Future getShippingVerificationList(
      {String? listStartAt,
    String? numOfResults,
    CarrierlistElement? customerLocation,
    CarrierlistElement? customer,
    DateTime? startDate,
    DateTime? endDate,
    CarrierlistElement? carrierId,
    CarrierlistElement? shipVia,
    String? statusTerm}) async {
    try {
      apiResIsLoading(_shippingVerificationList!);

      final res = await repo.getShippingVerificationList(
          req: ReqShippingVerificationListGet(
              listStartAt: listStartAt ?? '',
              numOfResults: numOfResults ?? '',
              customerId: customer?.value ?? '0',
              customerLocationId: customerLocation?.value ?? '0',
              carrierId: carrierId?.value ?? '0',
              shipViaId: shipVia?.value ?? '0',
              fromShipDateStr: startDate?.toStrSlashFormat() ?? '',
              toShipDateStr: endDate?.toStrSlashFormat() ?? '',
              statusTermStr: statusTerm ?? ''));
      if (res.success == true) {
        if (res.data != null) {
          shippingList = [];
          shippingList?.addAll(res.data!);
        }
        apiResIsSuccess<ResShippingVerificationList>(
            _shippingVerificationList!, res);
      } else {
        throw res.message ?? "Something Went Wrong";
      }
    } catch (e) {
      print(e);
      apiResIsFailed(_shippingVerificationList!, e);
      rethrow;
    }
  }

  Future getPdfPath({int? invoiceID, String? invoiceNo, String? msg}) async {
    final res = await repo.getPDFPath(
        invoiceNo: invoiceNo, invoiceID: invoiceID, pdf: msg);

    try {
      apiResIsLoading(_getASN_PdfPath!);
      if (res.success == true) {
        apiResIsSuccess<ResPath>(
            _getASN_PdfPath!, res);
      } else {
        throw res.message ?? "Something Went Wrong";
      }
    } catch (e) {
      apiResIsFailed(_getASN_PdfPath!, e);
      rethrow;
    }
  }

  Future checkForVerification({int? salesOrderID}) async {
    final res = await repo.checkForVerification(salesOrderID: salesOrderID);

    try {
      apiResIsLoading(_checkForVerification!);
      if (res.success == true) {
        apiResIsSuccess<ResWithPrimaryKeyAndErrorMessage>(
            _checkForVerification!, res);
      }
      else {
        throw res.message ?? " Something went wrong";
      }
    }
    catch (e) {
      apiResIsFailed(_checkForVerification!, e);
      rethrow;
    }
  }

  Future getEditScreenData(
      {int? pickOrderID, int? salesOrderID, int? i}) async {
    final res = await repo.getEditScreenData(
        pickOrderID: pickOrderID, salesOrderID: salesOrderID, i: i);

    try {
      apiResIsLoading(_editScreen!);
      if (res.success == true) {
        apiResIsSuccess<ResShoppingVerificationEditScreen>(_editScreen!, res);
      }
      else {
        throw res.message ?? " Something went wrong";
      }
    }
    catch (e) {
      apiResIsFailed(_editScreen!, e);
      rethrow;
    }
  }

  Future submitUnVerifiedData(
      {int? pickOrderID, int? salesOrderId, String? soNumber, String? bolNumber, List<
          PickOrderPalletList>? list, String? filePath}) async {
    final res = await repo.submitUnVerifiedData(pickOrderID: pickOrderID,
        salesOrderId: salesOrderId,
        soNumber: soNumber,
        bolNumber: bolNumber,
        list: list,
        filePath: filePath);

    try {
      apiResIsLoading(_submitUnverifiedData!);
      if(res.success == true){
        apiResIsSuccess<EmptyRes>(_submitUnverifiedData!, res );
      }
      else{
        throw res.message ?? " Something went wrong";
      }
    }
    catch (e) {
      apiResIsFailed(_submitUnverifiedData!, e);
      rethrow;
    }

  }

  Future editVerifiedOrder(
      {int? pickOrderID, int? salesOrderId,String? bolNumber, String? filePath}) async {
    final res = await repo.editVerifiedOrder(pickOrderID: pickOrderID,
        salesOrderId: salesOrderId,
        bolNumber: bolNumber,
        filePath: filePath);

    try {
      apiResIsLoading(_editVerifiedOrder!);
      if(res.success == true){
        apiResIsSuccess<EmptyRes>(_editVerifiedOrder!, res );
      }
      else{
        throw res.message ?? " Something went wrong";
      }
    }
    catch (e) {
      apiResIsFailed(_editVerifiedOrder!, e);
      rethrow;
    }

  }
  Future getBolPath({int? salesOrderID}) async {
    final res = await repo.getBolPath(
       salesOrderID: salesOrderID);
    try {
      apiResIsLoading(_getBolPDF!);
      if (res.success == true) {
        apiResIsSuccess<ResPath>(
            _getBolPDF!, res);
      } else {
        throw res.message ?? "Something Went Wrong";
      }
    } catch (e) {
      apiResIsFailed(_getBolPDF!, e);
      rethrow;
    }
  }

  setCameraImagePath(String? path, String? name) {
    imagePath = path;
    imageName = name;
    notifyListeners();
  }

  removeCameraImagePath(){
    imagePath = "";
    notifyListeners();
  }
}


