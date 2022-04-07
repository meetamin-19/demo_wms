
class ResGetPickOrderDataForView {
  ResGetPickOrderDataForView({
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

  factory ResGetPickOrderDataForView.fromJson(Map<String, dynamic> json) => ResGetPickOrderDataForView(
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
    this.pickOrder,
    this.salesOrderDetailList,
  });

  SalesOrder? salesOrder;
  PickOrder? pickOrder;
  List<SalesOrderDetailList>? salesOrderDetailList;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    salesOrder: json["salesOrder"] == null ? null : SalesOrder.fromJson(json["salesOrder"]),
    pickOrder: json["pickOrder"] == null ? null : PickOrder.fromJson(json["pickOrder"]),
    salesOrderDetailList: json["salesOrderDetailList"] == null ? null : List<SalesOrderDetailList>.from(json["salesOrderDetailList"].map((x) => SalesOrderDetailList.fromJson(x))),
  );

}

class PickOrder {
  PickOrder({
    this.pickOrderId,
    this.statusTerm,
  });

  int? pickOrderId;
  String? statusTerm;

  factory PickOrder.fromJson(Map<String, dynamic> json) => PickOrder(
    pickOrderId: json["pickOrderID"] == null ? null : json["pickOrderID"],
    statusTerm: json["status_Term"] == null ? null : json["status_Term"],
  );

}

class SalesOrder {
  SalesOrder({
    this.salesOrderId,
    this.customerPoid,
    this.customerLocationId,
    this.billingAddressId,
    this.soTerm,
    this.shipViaId,
    this.carrierId,
    this.soNotes,
    this.accountNumber,
    this.isAllowAdditionalQty,
    this.isAttachedProtoPpap,
    this.soNumber,
    this.shippingOrToteAddressId,
    this.customerName,
    this.customerLocation,
    this.shipperName,
    this.carrierName,
    this.shippingOrToteAddress,
    this.billingAddress,
    this.shipToName,
    this.isAllowAdditionalQtyStr,
    this.isAttachedProtoPpapStr,
    this.shipDateStr,
    this.dateOfSoStr,
    this.isAllPalletsVerifiedOrNot,
    this.isInvoiceIsCreatedOrNot,
    this.isPalletCompletedOrNot,
  });

  int? salesOrderId;
  int? customerPoid;
  int? customerLocationId;
  int? billingAddressId;
  String? soTerm;
  int? shipViaId;
  int? carrierId;
  dynamic soNotes;
  String? accountNumber;
  bool? isAllowAdditionalQty;
  bool? isAttachedProtoPpap;
  String? soNumber;
  int? shippingOrToteAddressId;
  String? customerName;
  String? customerLocation;
  String? shipperName;
  String? carrierName;
  String? shippingOrToteAddress;
  String? billingAddress;
  String? shipToName;
  String? isAllowAdditionalQtyStr;
  String? isAttachedProtoPpapStr;
  String? shipDateStr;
  String? dateOfSoStr;
  bool? isAllPalletsVerifiedOrNot;
  bool? isInvoiceIsCreatedOrNot;
  bool? isPalletCompletedOrNot;

  factory SalesOrder.fromJson(Map<String, dynamic> json) => SalesOrder(
    salesOrderId: json["salesOrderID"] == null ? null : json["salesOrderID"],
    customerPoid: json["customerPOID"] == null ? null : json["customerPOID"],
    customerLocationId: json["customerLocationID"] == null ? null : json["customerLocationID"],
    billingAddressId: json["billingAddressID"] == null ? null : json["billingAddressID"],
    soTerm: json["soTerm"] == null ? null : json["soTerm"],
    shipViaId: json["shipViaID"] == null ? null : json["shipViaID"],
    carrierId: json["carrierID"] == null ? null : json["carrierID"],
    soNotes: json["soNotes"],
    accountNumber: json["accountNumber"] == null ? null : json["accountNumber"],
    isAllowAdditionalQty: json["isAllowAdditionalQty"] == null ? null : json["isAllowAdditionalQty"],
    isAttachedProtoPpap: json["isAttachedProtoPPAP"] == null ? null : json["isAttachedProtoPPAP"],
    soNumber: json["soNumber"] == null ? null : json["soNumber"],
    shippingOrToteAddressId: json["shippingOrToteAddressID"] == null ? null : json["shippingOrToteAddressID"],
    customerName: json["customerName"] == null ? null : json["customerName"],
    customerLocation: json["customerLocation"] == null ? null : json["customerLocation"],
    shipperName: json["shipperName"] == null ? null : json["shipperName"],
    carrierName: json["carrierName"] == null ? null : json["carrierName"],
    shippingOrToteAddress: json["shippingOrToteAddress"] == null ? null : json["shippingOrToteAddress"],
    billingAddress: json["billingAddress"] == null ? null : json["billingAddress"],
    shipToName: json["shipToName"] == null ? null : json["shipToName"],
    isAllowAdditionalQtyStr: json["isAllowAdditionalQtyStr"] == null ? null : json["isAllowAdditionalQtyStr"],
    isAttachedProtoPpapStr: json["isAttachedProtoPPAPStr"] == null ? null : json["isAttachedProtoPPAPStr"],
    shipDateStr: json["shipDateStr"] == null ? null : json["shipDateStr"],
    dateOfSoStr: json["dateOfSOStr"] == null ? null : json["dateOfSOStr"],
    isAllPalletsVerifiedOrNot: json["isAllPalletsVerifiedOrNot"] == null ? null : json["isAllPalletsVerifiedOrNot"],
    isInvoiceIsCreatedOrNot: json["isInvoiceIsCreatedOrNot"] == null ? null : json["isInvoiceIsCreatedOrNot"],
    isPalletCompletedOrNot: json["isPalletCompletedOrNot"] == null ? null : json["isPalletCompletedOrNot"],
  );

}

class SalesOrderDetailList {
  SalesOrderDetailList({
    this.itemId,
    this.poNumber,
    this.qty,
    this.uom,
    this.updatelog,
    this.itemName,
    this.availableQty,
    this.palletNo,
    this.currentPartStatusTerm,
    this.isPartInTote,
    this.actualPicked,
    this.pickOrderSODetailID
  });

  int? pickOrderSODetailID;
  int? itemId;
  String? poNumber;
  double? qty;
  String? uom;
  String? updatelog;
  String? itemName;
  int? availableQty;
  dynamic palletNo;
  String? currentPartStatusTerm;
  bool? isPartInTote;
  double? actualPicked;

  factory SalesOrderDetailList.fromJson(Map<String, dynamic> json) => SalesOrderDetailList(
    itemId: json["itemID"] == null ? null : json["itemID"],
    poNumber: json["poNumber"] == null ? null : json["poNumber"],
    qty: json["qty"] == null ? null : json["qty"],
    uom: json["uom"] == null ? null : json["uom"],
    updatelog: json["updatelog"] == null ? null : json["updatelog"],
    itemName: json["itemName"] == null ? null : json["itemName"],
    availableQty: json["availableQty"] == null ? null : json["availableQty"],
    palletNo: json["palletNo"],
    currentPartStatusTerm: json["currentPartStatusTerm"] == null ? null : json["currentPartStatusTerm"],
    isPartInTote: json["isPartInTote"] == null ? null : json["isPartInTote"],
    actualPicked: json["actualPicked"] == null ? null : json["actualPicked"],
    pickOrderSODetailID: json["pickOrderSODetailID"] == null ? null : json["pickOrderSODetailID"],
  );

}
