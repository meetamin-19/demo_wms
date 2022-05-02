
import 'package:demo_win_wms/app/data/entity/res/res_complete_part_status.dart';

class ResGetPalletListDataById {
  ResGetPalletListDataById({
    this.success,
    this.message,
    this.data,
    this.statusCode,
    this.statusValueCode,
  });

  bool? success;
  String? message;
  Data? data;
  int? statusCode;
  int? statusValueCode;



  factory ResGetPalletListDataById.fromJson(Map<String, dynamic> json) => ResGetPalletListDataById(
    success: json["success"] == null ? null : json["success"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    statusCode: json["statusCode"] == null ? null : json["statusCode"],
    statusValueCode: json["statusValueCode"] == null ? null : json["statusValueCode"],
  );
}

class Data {
  Data({
    this.pickOrderPalletList,
    this.objSaveUpdateResponseModel
    // this.pickOrderdetailList,
  });

  List<PickOrderPalletList>? pickOrderPalletList;

  List<ObjSaveUpdateResponseModel>? objSaveUpdateResponseModel;

  // List<PickOrderdetailList>? pickOrderdetailList;



  factory Data.fromJson(Map<String, dynamic> json) {

    final child = json["pickOrderdetailList"] == null ? null : List<PickOrderdetailList>.from(json["pickOrderdetailList"].map((x) => PickOrderdetailList.fromJson(x)));

    return Data(
        objSaveUpdateResponseModel: json["objSaveUpdateResponseModel"] == null ? null : List<ObjSaveUpdateResponseModel>.from(json["objSaveUpdateResponseModel"].map((x) => ObjSaveUpdateResponseModel.fromJson(x))),
        pickOrderPalletList: json["pickOrderPalletList"] == null ? null : List<PickOrderPalletList>.from(json["pickOrderPalletList"].map((x) => PickOrderPalletList.fromJson(json: x,child: child))),
      // pickOrderdetailList: json["pickOrderdetailList"] == null ? null : List<PickOrderdetailList>.from(json["pickOrderdetailList"].map((x) => PickOrderdetailList.fromJson(x))),
    );
  }
}

class PickOrderPalletList {
  PickOrderPalletList({
    this.poPalletId,
    this.palletNo,
    this.updatelog,
    this.statusTerm,
    this.currentPartStatusTerm,
    this.currentLocationTitle,
    this.currentLocationTypeTerm,
    this.isPartAlreadyScannedForCurrentPallet,
    this.isPalletBindToLocationOrNot,
    this.isPartIsExistsOrNot,
    this.child
  });

  int? poPalletId;
  String? palletNo;
  String? updatelog;
  String? statusTerm;
  String? currentPartStatusTerm;
  String? currentLocationTitle;
  String? currentLocationTypeTerm;
  bool? isPartAlreadyScannedForCurrentPallet;
  bool? isPalletBindToLocationOrNot;
  bool? isPartIsExistsOrNot;
  List<PickOrderdetailList>? child;

  factory PickOrderPalletList.fromJson({required Map<String, dynamic> json,List<PickOrderdetailList>? child}) {

    final pallets = child?.where((element) => element.poPalletId == json["poPalletID"]).toList();
    return PickOrderPalletList(
        poPalletId: json["poPalletID"] == null ? null : json["poPalletID"],
        palletNo: json["palletNo"] == null ? null : json["palletNo"],
        updatelog: json["updatelog"] == null ? null : json["updatelog"],
        statusTerm: json["status_Term"] == null ? null : json["status_Term"],
        currentPartStatusTerm: json["currentPartStatusTerm"] == null ? null : json["currentPartStatusTerm"],
        currentLocationTitle: json["currentLocationTitle"] == null ? null : json["currentLocationTitle"],
        currentLocationTypeTerm: json["currentLocationTypeTerm"] == null ? null : json["currentLocationTypeTerm"],
        isPartAlreadyScannedForCurrentPallet: json["isPartAlreadyScannedForCurrentPallet"] == null ? null : json["isPartAlreadyScannedForCurrentPallet"],
        isPalletBindToLocationOrNot: json["isPalletBindToLocationOrNot"] == null ? null : json["isPalletBindToLocationOrNot"],
        isPartIsExistsOrNot: json["isPartIsExistsOrNot"] == null ? null : json["isPartIsExistsOrNot"],
        child: pallets
    );
  }
}
class ObjSaveUpdateResponseModel {
  ObjSaveUpdateResponseModel({
    this.primaryKey,
    this.errorMessage,
    this.data,
    this.data1,
  });

  String? primaryKey;
  String? errorMessage;
  String? data;
  bool? data1;

  factory ObjSaveUpdateResponseModel.fromJson(Map<String, dynamic> json) => ObjSaveUpdateResponseModel(
    primaryKey: json["primaryKey"] == null ? null : json["primaryKey"],
    errorMessage: json["errorMessage"] == null ? null : json["errorMessage"],

    data: json["data"] == null ? null : json["data"],
    data1: json["data1"] == null ? null : json["data1"],
  );

}


class PickOrderdetailList {
  PickOrderdetailList({
    this.pickOrderDetailId,
    this.poPalletId,
    this.palletNo,
    this.itemId,
    this.requestedQty,
    this.boxQty,
    this.numberOfBoxes,
    this.locationId,
    this.locationTypeTerm,
    this.totalQty,
    this.pickedBy,
    this.pickedOn,
    this.moveToLocationId,
    this.orderNo,
    this.isActive,
    this.updatelog,
    this.totalCount,
    this.availableQty,
    this.actualPicked,
    this.rate,
    this.updatedRate,
    this.removeQty,
    this.itemName,
    this.poNumber,
    this.statusTerm,
    this.locationTitle,
    this.invoiceDetailId,
    this.soDetailId,
    this.month,
    this.monthName,
    this.year,
    this.pickOrderSoDetailId,
  });

  int? pickOrderDetailId;
  int? poPalletId;
  String? palletNo;
  int? itemId;
  int? requestedQty;
  int? boxQty;
  int? numberOfBoxes;
  int? locationId;
  String? locationTypeTerm;
  double? totalQty;
  int? pickedBy;
  DateTime? pickedOn;
  int? moveToLocationId;
  int? orderNo;
  bool? isActive;
  DateTime? updatelog;
  int? totalCount;
  double? availableQty;
  double? actualPicked;
  double? rate;
  double? updatedRate;
  double? removeQty;
  String? itemName;
  String? poNumber;
  String? statusTerm;
  String? locationTitle;
  int? invoiceDetailId;
  int? soDetailId;
  int? month;
  String? monthName;
  String? year;
  int? pickOrderSoDetailId;

  factory PickOrderdetailList.fromJson(Map<String, dynamic> json) => PickOrderdetailList(
    pickOrderDetailId: json["pickOrderDetailID"] == null ? null : json["pickOrderDetailID"],
    poPalletId: json["poPalletID"] == null ? null : json["poPalletID"],
    palletNo: json["palletNo"] == null ? null : json["palletNo"],
    itemId: json["item_ID"] == null ? null : json["item_ID"],
    requestedQty: json["requestedQty"] == null ? null : json["requestedQty"],
    boxQty: json["boxQty"] == null ? null : json["boxQty"],
    numberOfBoxes: json["numberOfBoxes"] == null ? null : json["numberOfBoxes"],
    locationId: json["locationID"] == null ? null : json["locationID"],
    locationTypeTerm: json["locationType_Term"],
    totalQty: json["totalQty"] == null ? null : json["totalQty"],
    pickedBy: json["pickedBy"] == null ? null : json["pickedBy"],
    pickedOn: json["pickedOn"] == null ? null : DateTime.parse(json["pickedOn"]),
    moveToLocationId: json["moveToLocationID"] == null ? null : json["moveToLocationID"],
    orderNo: json["orderNo"] == null ? null : json["orderNo"],
    isActive: json["isActive"] == null ? null : json["isActive"],
    updatelog: json["updatelog"] == null ? null : DateTime.parse(json["updatelog"]),
    totalCount: json["totalCount"] == null ? null : json["totalCount"],
    availableQty: json["availableQty"] == null ? null : json["availableQty"],
    actualPicked: json["actualPicked"] == null ? null : json["actualPicked"],
    rate: json["rate"] == null ? null : json["rate"],
    updatedRate: json["updatedRate"] == null ? null : json["updatedRate"],
    removeQty: json["removeQty"] == null ? null : json["removeQty"],
    itemName: json["itemName"] == null ? null : json["itemName"],
    poNumber: json["poNumber"] == null ? null : json["poNumber"],
    statusTerm: json["status_Term"] == null ? null : json["status_Term"],
    locationTitle: json["locationTitle"] == null ? null : json["locationTitle"],
    invoiceDetailId: json["invoiceDetailID"] == null ? null : json["invoiceDetailID"],
    soDetailId: json["soDetailID"] == null ? null : json["soDetailID"],
    month: json["month"] == null ? null : json["month"],
    monthName: json["monthName"] == null ? null : json["monthName"],
    year: json["year"] == null ? null : json["year"],
    pickOrderSoDetailId: json["pickOrderSODetailID"] == null ? null : json["pickOrderSODetailID"],
  );
}
