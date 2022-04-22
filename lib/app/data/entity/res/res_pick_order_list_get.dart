
class ResPickOrderListGet {
  ResPickOrderListGet({
    this.success,
    this.message,
    this.data,
    this.statusCode,
    this.statusValueCode,
  });

  bool? success;
  String? message;
  List<ResPickOrderListGetData>? data;
  int? statusCode;
  int? statusValueCode;

  factory ResPickOrderListGet.fromJson(Map<String, dynamic> json) => ResPickOrderListGet(
    success: json["success"] == null ? null : json["success"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<ResPickOrderListGetData>.from(json["data"].map((x) => ResPickOrderListGetData.fromJson(x))),
    statusCode: json["statusCode"] == null ? null : json["statusCode"],
    statusValueCode: json["statusValueCode"] == null ? null : json["statusValueCode"],
  );

}

class ResPickOrderListGetData {
  ResPickOrderListGetData({
    this.pickOrderId,
    this.salesOrderId,
    this.companyId,
    this.warehouseId,
    this.dateOfShipment,
    this.customerId,
    this.statusTerm,
    this.customerLocationId,
    this.createdOn,
    this.createdBy,
    this.carrierId,
    this.totalItems,
    this.isActive,
    this.updatelog,
    this.wayBillNo,
    this.invoiceId,
    this.palletCount,
    this.updatedBy,
    this.updatedOn,
    this.totalCount,
    this.rowNo,
    this.isEdit,
    this.soNumber,
    this.customerName,
    this.customerLocation,
    this.companyName,
    this.warehouseName,
    this.shippingDate,
    this.carrierName,
    this.createdDate,
    this.completedOn,
    this.pickOrderLinkedTo,
    this.pickOrderLinkedOn,
    this.isPickOrderIsPickedOrNot,
    this.isPickOrderAcknowledegerOrNot,
    this.isPickOrderLinked,
    this.isPickOrderLinkedOrNot,
    this.isPoAlreadyLinkOrNot,
    this.isPoAlreadyLinked,
    this.isAbleToPickOrNot,
    this.pickOrderCompletedOn,
    this.shipperName,
    this.pickedByUserName,
    this.pickOrderNote,
    this.isInvoiceIsCreatedOrNot,
    this.isAbleToAcknowledge
  });

  bool? isPickOrderAcknowledegerOrNot;
  bool? isAbleToAcknowledge;
  int? pickOrderId;
  int? salesOrderId;
  int? companyId;
  int? warehouseId;
  DateTime? dateOfShipment;
  int? customerId;
  String? statusTerm;
  int? customerLocationId;
  DateTime? createdOn;
  int? createdBy;
  int? carrierId;
  int? totalItems;
  bool? isActive;
  String? updatelog;
  dynamic wayBillNo;
  int? invoiceId;
  int? palletCount;
  int? updatedBy;
  DateTime? updatedOn;
  int? totalCount;
  int? rowNo;
  bool? isEdit;
  String? soNumber;
  String? customerName;
  String? customerLocation;
  String? companyName;
  String? warehouseName;
  String? shippingDate;
  String? carrierName;
  String? createdDate;
  String? completedOn;
  int? pickOrderLinkedTo;
  DateTime? pickOrderLinkedOn;
  bool? isPickOrderIsPickedOrNot;
  bool? isPickOrderLinked;
  bool? isPickOrderLinkedOrNot;
  bool? isPoAlreadyLinkOrNot;
  bool? isPoAlreadyLinked;
  bool? isAbleToPickOrNot;
  DateTime? pickOrderCompletedOn;
  String? shipperName;
  String? pickedByUserName;
  String? pickOrderNote;
  bool? isInvoiceIsCreatedOrNot;

  factory ResPickOrderListGetData.fromJson(Map<String, dynamic> json) => ResPickOrderListGetData(
    pickOrderId: json["pickOrderID"] == null ? null : json["pickOrderID"],
    salesOrderId: json["salesOrderID"] == null ? null : json["salesOrderID"],
    companyId: json["companyID"] == null ? null : json["companyID"],
    warehouseId: json["warehouseID"] == null ? null : json["warehouseID"],
    dateOfShipment: json["dateOfShipment"] == null ? null : DateTime.parse(json["dateOfShipment"]),
    customerId: json["customerID"] == null ? null : json["customerID"],
    statusTerm: json["status_Term"] == null ? null : json["status_Term"],
    customerLocationId: json["customerLocationID"] == null ? null : json["customerLocationID"],
    createdOn: json["createdOn"] == null ? null : DateTime.parse(json["createdOn"]),
    createdBy: json["createdBy"] == null ? null : json["createdBy"],
    carrierId: json["carrierID"] == null ? null : json["carrierID"],
    totalItems: json["total_Items"] == null ? null : json["total_Items"],
    isActive: json["isActive"] == null ? null : json["isActive"],
    updatelog: json["updatelog"] == null ? null : json["updatelog"],
    wayBillNo: json["wayBillNo"],
    invoiceId: json["invoiceID"] == null ? null : json["invoiceID"],
    palletCount: json["palletCount"] == null ? null : json["palletCount"],
    updatedBy: json["updatedBy"] == null ? null : json["updatedBy"],
    updatedOn: json["updatedOn"] == null ? null : DateTime.parse(json["updatedOn"]),
    totalCount: json["totalCount"] == null ? null : json["totalCount"],
    rowNo: json["rowNo"] == null ? null : json["rowNo"],
    isEdit: json["isEdit"] == null ? null : json["isEdit"],
    soNumber: json["soNumber"] == null ? null : json["soNumber"],
    customerName: json["customerName"] == null ? null : json["customerName"],
    customerLocation: json["customerLocation"] == null ? null : json["customerLocation"],
    companyName: json["companyName"] == null ? null : json["companyName"],
    warehouseName: json["warehouseName"] == null ? null : json["warehouseName"],
    shippingDate: json["shippingDate"] == null ? null : json["shippingDate"],
    carrierName: json["carrierName"] == null ? null : json["carrierName"],
    createdDate: json["createdDate"] == null ? null : json["createdDate"],
    completedOn: json["completedOn"],
    pickOrderLinkedTo: json["pickOrderLinkedTo"] == null ? null : json["pickOrderLinkedTo"],
    pickOrderLinkedOn: json["pickOrderLinkedOn"] == null ? null : DateTime.parse(json["pickOrderLinkedOn"]),
    isPickOrderIsPickedOrNot: json["isPickOrderIsPickedOrNot"] == null ? null : json["isPickOrderIsPickedOrNot"],
    isAbleToAcknowledge: json["isAbleToAcknowledge"] == null ? null : json["isAbleToAcknowledge"],
    isPickOrderAcknowledegerOrNot: json["isPickOrderAcknowledegerOrNot"] == null ? null : json["isPickOrderAcknowledegerOrNot"],
    isPickOrderLinked: json["isPickOrderLinked"] == null ? null : json["isPickOrderLinked"],
    isPickOrderLinkedOrNot: json["isPickOrderLinkedOrNot"] == null ? null : json["isPickOrderLinkedOrNot"],
    isPoAlreadyLinkOrNot: json["isPOAlreadyLinkOrNot"] == null ? null : json["isPOAlreadyLinkOrNot"],
    isPoAlreadyLinked: json["isPOAlreadyLinked"] == null ? null : json["isPOAlreadyLinked"],
    isAbleToPickOrNot: json["isAbleToPickOrNot"] == null ? null : json["isAbleToPickOrNot"],
    pickOrderCompletedOn: json["pickOrderCompletedOn"] == null ? null : DateTime.parse(json["pickOrderCompletedOn"]),
    shipperName: json["shipperName"] == null ? null : json["shipperName"],
    pickedByUserName: json["pickedByUserName"] == null ? null : json["pickedByUserName"],
    pickOrderNote: json["pickOrderNote"] == null ? null : json["pickOrderNote"],
    isInvoiceIsCreatedOrNot: json["isInvoiceIsCreatedOrNot"] == null ? null : json["isInvoiceIsCreatedOrNot"],
  );
}
