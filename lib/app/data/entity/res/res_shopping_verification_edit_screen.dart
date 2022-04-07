
class ResShoppingVerificationEditScreen {
  ResShoppingVerificationEditScreen({
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

  factory ResShoppingVerificationEditScreen.fromJson(Map<String, dynamic> json) => ResShoppingVerificationEditScreen(
    success: json["success"] == null ? null : json["success"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    statusCode: json["statusCode"] == null ? null : json["statusCode"],
    statusValueCode: json["statusValueCode"] == null ? null : json["statusValueCode"],
  );
}

class Data {
  Data({
    this.salesOrder,
    this.pickOrderPalletList,
  });

  SalesOrder? salesOrder;
  List<PickOrderPalletList>? pickOrderPalletList;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    salesOrder: json["salesOrder"] == null ? null : SalesOrder.fromJson(json["salesOrder"]),
    pickOrderPalletList: json["pickOrderPalletList"] == null ? null : List<PickOrderPalletList>.from(json["pickOrderPalletList"].map((x) => PickOrderPalletList.fromJson(x))),
  );
}

class PickOrderPalletList {
  PickOrderPalletList({

    this.timeOfVerification,
    this.isPalletVerified = false,
    this.poPalletId,
    this.pickOrderId,
    this.companyId,
    this.warehouseId,
    this.numberOfBoxes,
    this.createdBy,
    this.createdOn,
    this.borPerPallet,
    this.orderNo,
    this.palletNo,
    this.isActive,
    this.updatelog,
    this.statusTerm,
    this.totaltems,
    this.pdfLocation,
    this.updatedBy,
    this.updatedOn,
    this.currentPartStatusTerm,
    this.currentItemId,
    this.scanDateTimeStr,
    this.palletLocation,
    this.palletLocationStr,
    this.moveToLocationId,
    this.palletCount,
    this.warehouseName,
    this.sectionName,
    this.companyName,
    this.currentLocationId,
    this.currentLocationTitle,
    this.currentLocationTypeTerm,
    this.isPartAlreadyScannedForCurrentPallet,
    this.isPalletBindToLocationOrNot,
    this.isPartIsExistsOrNot,
  });

  String? timeOfVerification;
  bool? isPalletVerified;
  int? poPalletId;
  int? pickOrderId;
  int? companyId;
  int? warehouseId;
  int? numberOfBoxes;
  int? createdBy;
  DateTime? createdOn;
  int? borPerPallet;
  int? orderNo;
  String? palletNo;
  bool? isActive;
  DateTime? updatelog;
  String? statusTerm;
  int? totaltems;
  String? pdfLocation;
  // dynamic totalWeight;
  int? updatedBy;
  DateTime? updatedOn;
  dynamic currentPartStatusTerm;
  int? currentItemId;
  String? scanDateTimeStr;
  String? palletLocation;
  String? palletLocationStr;
  // dynamic palletLocationArr;
  int? moveToLocationId;
  int? palletCount;
  String? warehouseName;
  String? sectionName;
  String? companyName;
  int? currentLocationId;
  dynamic currentLocationTitle;
  dynamic currentLocationTypeTerm;
  bool? isPartAlreadyScannedForCurrentPallet;
  bool? isPalletBindToLocationOrNot;
  bool? isPartIsExistsOrNot;

  factory PickOrderPalletList.fromJson(Map<String, dynamic> json) => PickOrderPalletList(
    poPalletId: json["poPalletID"] == null ? null : json["poPalletID"],
    pickOrderId: json["pickOrderID"] == null ? null : json["pickOrderID"],
    companyId: json["companyID"] == null ? null : json["companyID"],
    warehouseId: json["warehouseID"] == null ? null : json["warehouseID"],
    numberOfBoxes: json["numberOfBoxes"] == null ? null : json["numberOfBoxes"],
    createdBy: json["createdBy"] == null ? null : json["createdBy"],
    createdOn: json["createdOn"] == null ? null : DateTime.parse(json["createdOn"]),
    borPerPallet: json["borPerPallet"] == null ? null : json["borPerPallet"],
    orderNo: json["orderNo"] == null ? null : json["orderNo"],
    palletNo: json["palletNo"] == null ? null : json["palletNo"],
    isActive: json["isActive"] == null ? null : json["isActive"],
    updatelog: json["updatelog"] == null ? null : DateTime.parse(json["updatelog"]),
    statusTerm: json["status_Term"] == null ? null : json["status_Term"],
    totaltems: json["totaltems"] == null ? null : json["totaltems"],
    pdfLocation: json["pdfLocation"] == null ? null : json["pdfLocation"],
    // totalWeight: json["totalWeight"] == null ? null : json["totalWeight"].toDouble(),
    updatedBy: json["updatedBy"] == null ? null : json["updatedBy"],
    updatedOn: json["updatedOn"] == null ? null : DateTime.parse(json["updatedOn"]),
    currentPartStatusTerm: json["currentPartStatusTerm"],
    currentItemId: json["currentItemID"] == null ? null : json["currentItemID"],
    scanDateTimeStr: json["scanDateTimeStr"] == null ? null : json["scanDateTimeStr"],
    palletLocation: json["palletLocation"] == null ? null : json["palletLocation"],
    palletLocationStr: json["palletLocationStr"] == null ? null : json["palletLocationStr"],
    // palletLocationArr: json["palletLocationArr"],
    moveToLocationId: json["moveToLocationID"] == null ? null : json["moveToLocationID"],
    palletCount: json["palletCount"] == null ? null : json["palletCount"],
    warehouseName: json["warehouseName"] == null ? null : json["warehouseName"],
    sectionName: json["sectionName"] == null ? null : json["sectionName"],
    companyName: json["companyName"] == null ? null : json["companyName"],
    currentLocationId: json["currentLocationID"] == null ? null : json["currentLocationID"],
    currentLocationTitle: json["currentLocationTitle"],
    currentLocationTypeTerm: json["currentLocationTypeTerm"],
    isPartAlreadyScannedForCurrentPallet: json["isPartAlreadyScannedForCurrentPallet"] == null ? null : json["isPartAlreadyScannedForCurrentPallet"],
    isPalletBindToLocationOrNot: json["isPalletBindToLocationOrNot"] == null ? null : json["isPalletBindToLocationOrNot"],
    isPartIsExistsOrNot: json["isPartIsExistsOrNot"] == null ? null : json["isPartIsExistsOrNot"],
  );
}

class SalesOrder {
  SalesOrder({
    this.salesOrderId,
    this.companyId,
    this.warehouseId,
    this.customerId,
    this.customerPoid,
    this.customerLocationId,
    this.customerLocationShiptoId,
    this.billingAddressId,
    this.dateOfSo,
    this.soTerm,
    this.shipDate,
    this.shipViaId,
    this.carrierId,
    this.fob,
    this.soNotes,
    this.accountNumber,
    this.isAllowAdditionalQty,
    this.isAttachedProtoPpap,
    this.uploadPpap,
    this.totalAmount,
    this.estimatedWeight,
    this.isActive,
    this.updatelog,
    this.soNumber,
    this.createdBy,
    this.createdOn,
    this.updatedBy,
    this.updatedOn,
    this.refSalesOrderId,
    this.salesOrderStatusTerm,
    this.shippingOrToteAddressId,
    this.totalCount,
    this.rowNo,
    this.isEdit,
    this.warehouseName,
    this.customerName,
    this.customerLocation,
    this.inVoiceNumber,
    this.shipperName,
    this.carrierName,
    this.pickOrderStatus,
    this.createdDate,
    this.shippingDate,
    this.shippingOrToteAddress,
    this.billingAddress,
    this.paymentTerms,
    this.shipToName,
    this.isAllowAdditionalQtyStr,
    this.isAttachedProtoPpapStr,
    this.shipDateStr,
    this.dateOfSoStr,
    this.companyName,
    this.pickOrderId,
    this.bolNumber,
    this.invoiceNote,
    this.attachmentStr,
    this.attachment,
    this.isAllPalletsVerifiedOrNot,
    this.isInvoiceIsCreatedOrNot,
    this.isPalletCompletedOrNot,
    this.invoiceId,
    this.isCreditMemoGenerated,
    this.isBolAttachmentUploadedOrNot,
    this.isSupportingDocUploadedOrNot,
    this.isSalesOrderIsPickedOrNot,
    this.isPickOrderCreatedOrNot,
    this.isPickOrderIsCompletedOrNot,
    this.isMergeWithPickOrder,
    this.invoiceNo,
    this.pickOrderNote,
    this.documentCount,
    this.isPermissionToEdit,
    this.isEditShippingVerification,
    this.userId,
    this.pastDueOpenOrder,
    this.todayOpenOrder,
    this.tomorrowOpenOrder,
  });

  int? salesOrderId;
  int? companyId;
  int? warehouseId;
  int? customerId;
  int? customerPoid;
  int? customerLocationId;
  int? customerLocationShiptoId;
  int? billingAddressId;
  DateTime?dateOfSo;
  dynamic soTerm;
  dynamic shipDate;
  int? shipViaId;
  int? carrierId;
  dynamic fob;
  dynamic soNotes;
  dynamic accountNumber;
  bool? isAllowAdditionalQty;
  bool? isAttachedProtoPpap;
  dynamic uploadPpap;
  dynamic totalAmount;
  dynamic estimatedWeight;
  bool? isActive;
  DateTime? updatelog;
  String? soNumber;
  int? createdBy;
  DateTime? createdOn;
  int? updatedBy;
  DateTime? updatedOn;
  int? refSalesOrderId;
  dynamic salesOrderStatusTerm;
  int? shippingOrToteAddressId;
  int? totalCount;
  int? rowNo;
  bool? isEdit;
  String? warehouseName;
  String? customerName;
  dynamic customerLocation;
  dynamic inVoiceNumber;
  String? shipperName;
  String? carrierName;
  dynamic pickOrderStatus;
  dynamic createdDate;
  dynamic shippingDate;
  String? shippingOrToteAddress;
  String? billingAddress;
  dynamic paymentTerms;
  String? shipToName;
  dynamic isAllowAdditionalQtyStr;
  dynamic isAttachedProtoPpapStr;
  String? shipDateStr;
  String? dateOfSoStr;
  dynamic companyName;
  int? pickOrderId;
  String? bolNumber;
  dynamic invoiceNote;
  dynamic attachmentStr;
  dynamic attachment;
  bool? isAllPalletsVerifiedOrNot;
  bool? isInvoiceIsCreatedOrNot;
  bool? isPalletCompletedOrNot;
  // int?  totalQty;
  int?  invoiceId;
  bool? isCreditMemoGenerated;
  bool? isBolAttachmentUploadedOrNot;
  bool? isSupportingDocUploadedOrNot;
  bool? isSalesOrderIsPickedOrNot;
  bool? isPickOrderCreatedOrNot;
  bool? isPickOrderIsCompletedOrNot;
  bool? isMergeWithPickOrder;
  dynamic invoiceNo;
  dynamic pickOrderNote;
  dynamic documentCount;
  bool? isPermissionToEdit;
  bool? isEditShippingVerification;
  int? userId;
  dynamic pastDueOpenOrder;
  dynamic todayOpenOrder;
  dynamic tomorrowOpenOrder;

  factory SalesOrder.fromJson(Map<String, dynamic> json) => SalesOrder(
    salesOrderId: json["salesOrderID"] == null ? null : json["salesOrderID"],
    companyId: json["companyID"] == null ? null : json["companyID"],
    warehouseId: json["warehouseID"] == null ? null : json["warehouseID"],
    customerId: json["customerID"] == null ? null : json["customerID"],
    customerPoid: json["customerPOID"] == null ? null : json["customerPOID"],
    customerLocationId: json["customerLocationID"] == null ? null : json["customerLocationID"],
    customerLocationShiptoId: json["customerLocationShiptoID"] == null ? null : json["customerLocationShiptoID"],
    billingAddressId: json["billingAddressID"] == null ? null : json["billingAddressID"],
    dateOfSo: json["dateOfSO"] == null ? null : DateTime.parse(json["dateOfSO"]),
    soTerm: json["soTerm"],
    shipDate: json["shipDate"],
    shipViaId: json["shipViaID"] == null ? null : json["shipViaID"],
    carrierId: json["carrierID"] == null ? null : json["carrierID"],
    fob: json["fob"],
    soNotes: json["soNotes"],
    accountNumber: json["accountNumber"],
    isAllowAdditionalQty: json["isAllowAdditionalQty"] == null ? null : json["isAllowAdditionalQty"],
    isAttachedProtoPpap: json["isAttachedProtoPPAP"] == null ? null : json["isAttachedProtoPPAP"],
    uploadPpap: json["uploadPPAP"],
    totalAmount: json["totalAmount"],
    estimatedWeight: json["estimatedWeight"],
    isActive: json["isActive"] == null ? null : json["isActive"],
    updatelog: json["updatelog"] == null ? null : DateTime.parse(json["updatelog"]),
    soNumber: json["soNumber"] == null ? null : json["soNumber"],
    createdBy: json["createdBy"] == null ? null : json["createdBy"],
    createdOn: json["createdOn"] == null ? null : DateTime.parse(json["createdOn"]),
    updatedBy: json["updatedBy"] == null ? null : json["updatedBy"],
    updatedOn: json["updatedOn"] == null ? null : DateTime.parse(json["updatedOn"]),
    refSalesOrderId: json["refSalesOrderID"] == null ? null : json["refSalesOrderID"],
    salesOrderStatusTerm: json["salesOrderStatus_Term"],
    shippingOrToteAddressId: json["shippingOrToteAddressID"] == null ? null : json["shippingOrToteAddressID"],
    totalCount: json["totalCount"] == null ? null : json["totalCount"],
    rowNo: json["rowNo"] == null ? null : json["rowNo"],
    isEdit: json["isEdit"] == null ? null : json["isEdit"],
    warehouseName: json["warehouseName"],
    customerName: json["customerName"] == null ? null : json["customerName"],
    customerLocation: json["customerLocation"],
    inVoiceNumber: json["inVoiceNumber"],
    shipperName: json["shipperName"] == null ? null : json["shipperName"],
    carrierName: json["carrierName"],
    pickOrderStatus: json["pickOrderStatus"],
    createdDate: json["createdDate"],
    shippingDate: json["shippingDate"],
    shippingOrToteAddress: json["shippingOrToteAddress"] == null ? null : json["shippingOrToteAddress"],
    billingAddress: json["billingAddress"] == null ? null : json["billingAddress"],
    paymentTerms: json["paymentTerms"],
    shipToName: json["shipToName"] == null ? null : json["shipToName"],
    isAllowAdditionalQtyStr: json["isAllowAdditionalQtyStr"],
    isAttachedProtoPpapStr: json["isAttachedProtoPPAPStr"],
    shipDateStr: json["shipDateStr"] == null ? null : json["shipDateStr"],
    dateOfSoStr: json["dateOfSOStr"] == null ? null : json["dateOfSOStr"],
    companyName: json["companyName"],
    pickOrderId: json["pickOrderID"] == null ? null : json["pickOrderID"],
    bolNumber: json["bolNumber"] == null ? null : json["bolNumber"],
    invoiceNote: json["invoiceNote"],
    attachmentStr: json["attachmentStr"],
    attachment: json["attachment"],
    isAllPalletsVerifiedOrNot: json["isAllPalletsVerifiedOrNot"] == null ? null : json["isAllPalletsVerifiedOrNot"],
    isInvoiceIsCreatedOrNot: json["isInvoiceIsCreatedOrNot"] == null ? null : json["isInvoiceIsCreatedOrNot"],
    isPalletCompletedOrNot: json["isPalletCompletedOrNot"] == null ? null : json["isPalletCompletedOrNot"],
    // totalQty: json["totalQty"] == null ? null : json["totalQty"],
    invoiceId: json["invoiceID"] == null ? null : json["invoiceID"],
    isCreditMemoGenerated: json["isCreditMemoGenerated"] == null ? null : json["isCreditMemoGenerated"],
    isBolAttachmentUploadedOrNot: json["isBOLAttachmentUploadedOrNot"] == null ? null : json["isBOLAttachmentUploadedOrNot"],
    isSupportingDocUploadedOrNot: json["isSupportingDocUploadedOrNot"] == null ? null : json["isSupportingDocUploadedOrNot"],
    isSalesOrderIsPickedOrNot: json["isSalesOrderIsPickedOrNot"] == null ? null : json["isSalesOrderIsPickedOrNot"],
    isPickOrderCreatedOrNot: json["isPickOrderCreatedOrNot"] == null ? null : json["isPickOrderCreatedOrNot"],
    isPickOrderIsCompletedOrNot: json["isPickOrderIsCompletedOrNot"] == null ? null : json["isPickOrderIsCompletedOrNot"],
    isMergeWithPickOrder: json["isMergeWithPickOrder"] == null ? null : json["isMergeWithPickOrder"],
    invoiceNo: json["invoiceNo"],
    pickOrderNote: json["pickOrderNote"],
    documentCount: json["documentCount"],
    isPermissionToEdit: json["isPermissionToEdit"] == null ? null : json["isPermissionToEdit"],
    isEditShippingVerification: json["isEditShippingVerification"] == null ? null : json["isEditShippingVerification"],
    userId: json["userID"] == null ? null : json["userID"],
    pastDueOpenOrder: json["pastDueOpenOrder"],
    todayOpenOrder: json["todayOpenOrder"],
    tomorrowOpenOrder: json["tomorrowOpenOrder"],
  );
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
