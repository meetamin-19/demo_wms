

class ResGetContainerPartList {
  ResGetContainerPartList({
    this.success,
    this.message,
    this.data,
    this.statusCode,
    this.statusValueCode,
  });

  bool? success;
  String? message;
  List<ResGetContainerPartListData>? data;
  int? statusCode;
  int? statusValueCode;

  factory ResGetContainerPartList.fromJson(Map<String, dynamic> json) => ResGetContainerPartList(
    success: json["success"] == null ? null : json["success"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<ResGetContainerPartListData>.from(json["data"].map((x) => ResGetContainerPartListData.fromJson(x))),
    statusCode: json["statusCode"] == null ? null : json["statusCode"],
    statusValueCode: json["statusValueCode"] == null ? null : json["statusValueCode"],
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    "statusCode": statusCode == null ? null : statusCode,
    "statusValueCode": statusValueCode == null ? null : statusValueCode,
  };
}

class ResGetContainerPartListData {
  ResGetContainerPartListData({
    this.containerPartsId,
    this.containerId,
    this.partsId,
    this.inVoiceDate,
    this.shippedQty,
    this.receivedQty,
    this.totaleBoxes,
    this.scannedBy,
    this.differenceInQty,
    this.boxScanned,
    this.statusTerm,
    this.actualLocationId,
    this.preferredLocationCode,
    this.scanningDate,
    this.isVarified,
    this.varifiedBy,
    this.varifiedOn,
    this.isQaPassed,
    this.qaBy,
    this.qaOn,
    this.companyId,
    this.warehouseId,
    this.isActive,
    this.stockLedgerId,
    this.trackingNo,
    this.customerId,
    this.invoiceNo,
    this.courrierId,
    this.shipperId,
    this.eta,
    this.ata,
    this.createdBy,
    this.createdOn,
    this.updatedBy,
    this.updatedOn,
    this.updatelog,
    this.subTrackingNo,
    this.comment,
    this.totalCount,
    this.rowNo,
    this.isEdit,
    this.inVoiceDateString,
    this.partNumber,
    this.customerName,
    this.locationName,
    this.bindLocationName,
    this.boxQty,
    this.scannedReceivedQtyCount,
    this.containerPartComment,
    this.allowToBindLocation,
    this.isAllowToScanNewItem,
    this.isEntryComingFromExcel,
    this.isSelected,
    this.unlinkContainerPartsId,
    this.userName,
    this.boxQtyInt,
    this.weight,
    this.boxSize,
    this.isLocationIsBindOrNotInItemMaster,
    this.suggestedLocation,
    this.loggedInUserId,
    this.scanBy,
    this.poNumber,
    this.airReceivedQty,
    this.airDifferenceInQty,
    this.airBoxScanned,
    this.airReceivingLocationIDs,
    this.companyName,
    this.containerName,
    this.shipperName,
    this.qtyWithNoAirReceivingLocationId,
    this.isPurchaseorderReq,
  });

  int? containerPartsId;
  int? containerId;
  int? partsId;
  DateTime? inVoiceDate;
  int? shippedQty;
  int? receivedQty;
  int? totaleBoxes;
  int? scannedBy;
  double? differenceInQty;
  int? boxScanned;
  String? statusTerm;
  String? actualLocationId;
  dynamic preferredLocationCode;
  DateTime? scanningDate;
  bool? isVarified;
  int? varifiedBy;
  DateTime? varifiedOn;
  bool? isQaPassed;
  int? qaBy;
  DateTime? qaOn;
  int? companyId;
  int? warehouseId;
  bool? isActive;
  int? stockLedgerId;
  String? trackingNo;
  int? customerId;
  String? invoiceNo;
  int? courrierId;
  int? shipperId;
  DateTime? eta;
  DateTime? ata;
  int? createdBy;
  DateTime? createdOn;
  int? updatedBy;
  DateTime? updatedOn;
  DateTime? updatelog;
  dynamic subTrackingNo;
  String? comment;
  int? totalCount;
  int? rowNo;
  bool? isEdit;
  String? inVoiceDateString;
  String? partNumber;
  String? customerName;
  String? locationName;
  String? bindLocationName;
  String? boxQty;
  String? scannedReceivedQtyCount;
  String? containerPartComment;
  bool? allowToBindLocation;
  bool? isAllowToScanNewItem;
  bool? isEntryComingFromExcel;
  bool? isSelected;
  String? unlinkContainerPartsId;
  String? userName;
  int? boxQtyInt;
  double? weight;
  String? boxSize;
  bool? isLocationIsBindOrNotInItemMaster;
  String? suggestedLocation;
  int? loggedInUserId;
  int? scanBy;
  String? poNumber;
  int? airReceivedQty;
  int? airDifferenceInQty;
  int? airBoxScanned;
  dynamic airReceivingLocationIDs;
  String? companyName;
  String? containerName;
  String? shipperName;
  int? qtyWithNoAirReceivingLocationId;
  bool? isPurchaseorderReq;

  factory ResGetContainerPartListData.fromJson(Map<String, dynamic> json) => ResGetContainerPartListData(
    containerPartsId: json["containerPartsID"] == null ? null : json["containerPartsID"],
    containerId: json["containerID"] == null ? null : json["containerID"],
    partsId: json["partsID"] == null ? null : json["partsID"],
    inVoiceDate: json["inVoiceDate"] == null ? null : DateTime.parse(json["inVoiceDate"]),
    shippedQty: json["shippedQty"] == null ? null : json["shippedQty"],
    receivedQty: json["receivedQty"] == null ? null : json["receivedQty"],
    totaleBoxes: json["totaleBoxes"] == null ? null : json["totaleBoxes"],
    scannedBy: json["scannedBy"] == null ? null : json["scannedBy"],
    differenceInQty: json["differenceInQty"] == null ? null : json["differenceInQty"],
    boxScanned: json["boxScanned"] == null ? null : json["boxScanned"],
    statusTerm: json["status_Term"] == null ? null : json["status_Term"],
    actualLocationId: json["actualLocationID"],
    preferredLocationCode: json["preferredLocationCode"],
    scanningDate: json["scanningDate"] == null ? null : DateTime.parse(json["scanningDate"]),
    isVarified: json["isVarified"] == null ? null : json["isVarified"],
    varifiedBy: json["varifiedBy"] == null ? null : json["varifiedBy"],
    varifiedOn: json["varifiedOn"] == null ? null : DateTime.parse(json["varifiedOn"]),
    isQaPassed: json["isQAPassed"] == null ? null : json["isQAPassed"],
    qaBy: json["qaBy"] == null ? null : json["qaBy"],
    qaOn: json["qaOn"] == null ? null : DateTime.parse(json["qaOn"]),
    companyId: json["companyID"] == null ? null : json["companyID"],
    warehouseId: json["warehouseID"] == null ? null : json["warehouseID"],
    isActive: json["isActive"] == null ? null : json["isActive"],
    stockLedgerId: json["stockLedgerID"] == null ? null : json["stockLedgerID"],
    trackingNo: json["trackingNo"] == null ? null : json["trackingNo"],
    customerId: json["customerID"] == null ? null : json["customerID"],
    invoiceNo: json["invoiceNo"] == null ? null : json["invoiceNo"],
    courrierId: json["courrierID"] == null ? null : json["courrierID"],
    shipperId: json["shipperID"] == null ? null : json["shipperID"],
    eta: json["eta"] == null ? null : DateTime.parse(json["eta"]),
    ata: json["ata"] == null ? null : DateTime.parse(json["ata"]),
    createdBy: json["createdBy"] == null ? null : json["createdBy"],
    createdOn: json["createdOn"] == null ? null : DateTime.parse(json["createdOn"]),
    updatedBy: json["updatedBy"] == null ? null : json["updatedBy"],
    updatedOn: json["updatedOn"] == null ? null : DateTime.parse(json["updatedOn"]),
    updatelog: json["updatelog"] == null ? null : DateTime.parse(json["updatelog"]),
    subTrackingNo: json["subTrackingNo"],
    comment: json["comment"],
    totalCount: json["totalCount"] == null ? null : json["totalCount"],
    rowNo: json["rowNo"] == null ? null : json["rowNo"],
    isEdit: json["isEdit"] == null ? null : json["isEdit"],
    inVoiceDateString: json["inVoiceDateString"] == null ? null :json["inVoiceDateString"],
    partNumber: json["partNumber"] == null ? null : json["partNumber"],
    customerName: json["customerName"] == null ? null : json["customerName"],
    locationName: json["locationName"],
    bindLocationName: json["bindLocationName"],
    boxQty: json["boxQty"] == null ? null : json["boxQty"],
    scannedReceivedQtyCount: json["scannedReceivedQtyCount"] == null ? null : json["scannedReceivedQtyCount"],
    containerPartComment: json["containerPartComment"] == null ? null : json["containerPartComment"],
    allowToBindLocation: json["allowToBindLocation"] == null ? null : json["allowToBindLocation"],
    isAllowToScanNewItem: json["isAllowToScanNewItem"] == null ? null : json["isAllowToScanNewItem"],
    isEntryComingFromExcel: json["isEntryComingFromExcel"] == null ? null : json["isEntryComingFromExcel"],
    isSelected: json["isSelected"] == null ? null : json["isSelected"],
    unlinkContainerPartsId: json["unlinkContainerPartsID"],
    userName: json["userName"],
    boxQtyInt: json["boxQtyInt"] == null ? null : json["boxQtyInt"],
    weight: json["weight"] == null ? null : json["weight"].toDouble(),
    boxSize: json["boxSize"] == null ? null : json["boxSize"],
    isLocationIsBindOrNotInItemMaster: json["isLocationIsBindOrNotInItemMaster"] == null ? null : json["isLocationIsBindOrNotInItemMaster"],
    suggestedLocation: json["suggestedLocation"] == null ? null : json["suggestedLocation"],
    loggedInUserId: json["loggedInUserID"] == null ? null : json["loggedInUserID"],
    scanBy: json["scanBy"] == null ? null : json["scanBy"],
    poNumber: json["poNumber"] == null ? null : json["poNumber"],
    airReceivedQty: json["airReceivedQty"] == null ? null : json["airReceivedQty"],
    airDifferenceInQty: json["airDifferenceInQty"] == null ? null : json["airDifferenceInQty"],
    airBoxScanned: json["airBoxScanned"] == null ? null : json["airBoxScanned"],
    airReceivingLocationIDs: json["airReceivingLocationIDs"],
    companyName: json["companyName"],
    containerName: json["containerName"],
    shipperName: json["shipperName"],
    qtyWithNoAirReceivingLocationId: json["qtyWithNoAirReceivingLocationID"] == null ? null : json["qtyWithNoAirReceivingLocationID"],
    isPurchaseorderReq: json["is_purchaseorder_req"] == null ? null : json["is_purchaseorder_req"],
  );

  Map<String, dynamic> toJson() => {
    "containerPartsID": containerPartsId == null ? null : containerPartsId,
    "containerID": containerId == null ? null : containerId,
    "partsID": partsId == null ? null : partsId,
    "inVoiceDate": inVoiceDate == null ? null : inVoiceDate!.toIso8601String(),
    "shippedQty": shippedQty == null ? null : shippedQty,
    "receivedQty": receivedQty == null ? null : receivedQty,
    "totaleBoxes": totaleBoxes == null ? null : totaleBoxes,
    "scannedBy": scannedBy == null ? null : scannedBy,
    "differenceInQty": differenceInQty == null ? null : differenceInQty,
    "boxScanned": boxScanned == null ? null : boxScanned,
    "status_Term": statusTerm == null ? null : statusTerm,
    "actualLocationID": actualLocationId?.trim(),
    "preferredLocationCode": preferredLocationCode,
    "scanningDate": scanningDate == null ? null : scanningDate?.toIso8601String(),
    "isVarified": isVarified == null ? null : isVarified,
    "varifiedBy": varifiedBy == null ? null : varifiedBy,
    "varifiedOn": varifiedOn == null ? null : varifiedOn?.toIso8601String(),
    "isQAPassed": isQaPassed == null ? null : isQaPassed,
    "qaBy": qaBy == null ? null : qaBy,
    "qaOn": qaOn == null ? null : qaOn?.toIso8601String(),
    "companyID": companyId == null ? null : companyId,
    "warehouseID": warehouseId == null ? null : warehouseId,
    "isActive": isActive == null ? null : isActive,
    "stockLedgerID": stockLedgerId == null ? null : stockLedgerId,
    "trackingNo": trackingNo == null ? null : trackingNo,
    "customerID": customerId == null ? null : customerId,
    "invoiceNo": invoiceNo == null ? null : invoiceNo,
    "courrierID": courrierId == null ? null : courrierId,
    "shipperID": shipperId == null ? null : shipperId,
    "eta": eta == null ? null : eta?.toIso8601String(),
    "ata": ata == null ? null : ata?.toIso8601String(),
    "createdBy": createdBy == null ? null : createdBy,
    "createdOn": createdOn == null ? null : createdOn?.toIso8601String(),
    "updatedBy": updatedBy == null ? null : updatedBy,
    "updatedOn": updatedOn == null ? null : updatedOn?.toIso8601String(),
    "updatelog": updatelog == null ? null : updatelog?.toIso8601String(),
    "subTrackingNo": subTrackingNo,
    "comment": comment,
    "totalCount": totalCount == null ? null : totalCount,
    "rowNo": rowNo == null ? null : rowNo,
    "isEdit": isEdit == null ? null : isEdit,
    "inVoiceDateString": inVoiceDateString == null ? null : inVoiceDateString,
    "partNumber": partNumber == null ? null : partNumber,
    "customerName": customerName == null ? null : customerName,
    "locationName": locationName,
    "bindLocationName": bindLocationName,
    "boxQty": boxQty == null ? null : boxQty,
    "scannedReceivedQtyCount": scannedReceivedQtyCount == null ? null : scannedReceivedQtyCount,
    "containerPartComment": containerPartComment == null ? null : containerPartComment,
    "allowToBindLocation": allowToBindLocation == null ? null : allowToBindLocation,
    "isAllowToScanNewItem": isAllowToScanNewItem == null ? null : isAllowToScanNewItem,
    "isEntryComingFromExcel": isEntryComingFromExcel == null ? null : isEntryComingFromExcel,
    "isSelected": isSelected == null ? null : isSelected,
    "unlinkContainerPartsID": unlinkContainerPartsId,
    "userName": userName,
    "boxQtyInt": boxQtyInt == null ? null : boxQtyInt,
    "weight": weight == null ? null : weight,
    "boxSize": boxSize == null ? null : boxSize,
    "isLocationIsBindOrNotInItemMaster": isLocationIsBindOrNotInItemMaster == null ? null : isLocationIsBindOrNotInItemMaster,
    "suggestedLocation": suggestedLocation == null ? null : suggestedLocation,
    "loggedInUserID": loggedInUserId == null ? null : loggedInUserId,
    "scanBy": scanBy == null ? null : scanBy,
    "poNumber": poNumber == null ? null : poNumber,
    "airReceivedQty": airReceivedQty == null ? null : airReceivedQty,
    "airDifferenceInQty": airDifferenceInQty == null ? null : airDifferenceInQty,
    "airBoxScanned": airBoxScanned == null ? null : airBoxScanned,
    "airReceivingLocationIDs": airReceivingLocationIDs,
    "companyName": companyName,
    "containerName": containerName,
    "shipperName": shipperName,
    "qtyWithNoAirReceivingLocationID": qtyWithNoAirReceivingLocationId == null ? null : qtyWithNoAirReceivingLocationId,
    "is_purchaseorder_req": isPurchaseorderReq == null ? null : isPurchaseorderReq,
  };
}
//
// enum CustomerName { JOHN_DEERE, CATERPILLAR }
//
// final customerNameValues = EnumValues({
//   "Caterpillar": CustomerName.CATERPILLAR,
//   "John Deere": CustomerName.JOHN_DEERE
// });
//
// enum InVoiceDateString { THE_04302022, THE_04272022, THE_04292022, THE_04262022 }
//
// final inVoiceDateStringValues = EnumValues({
//   "04/26/2022": InVoiceDateString.THE_04262022,
//   "04/27/2022": InVoiceDateString.THE_04272022,
//   "04/29/2022": InVoiceDateString.THE_04292022,
//   "04/30/2022": InVoiceDateString.THE_04302022
// });

// enum StatusTerm { NOT_SCANNED }
//
// final statusTermValues = EnumValues({
//   "Not Scanned": StatusTerm.NOT_SCANNED
// });
//
// enum TrackingNo { HLXU6456941 }
//
// final trackingNoValues = EnumValues({
//   "HLXU6456941": TrackingNo.HLXU6456941
// });
//
// class EnumValues<T> {
//   Map<String, T> map;
//   Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     if (reverseMap == null) {
//       reverseMap = map.map((k, v) => new MapEntry(v, k));
//     }
//     return reverseMap;
//   }
// }
