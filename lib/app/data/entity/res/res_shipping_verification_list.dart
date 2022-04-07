
class ResShippingVerificationList {
  ResShippingVerificationList({
    this.success,
    this.message,
    this.data,
    this.statusCode,
    this.statusValueCode,
    this.invoiceID,
    this.salesOrderID,
    this.pickOrderID,
    this.invoiceNo,
    this.isCreditMemoGenerated,
    this.isInvoiceIsCreatedOrNot,
    this.isBOLAttachmentUploadedOrNot,
  });

  bool? isBOLAttachmentUploadedOrNot;
  bool? isCreditMemoGenerated;
  bool? isInvoiceIsCreatedOrNot;
  String? invoiceNo;
  int? pickOrderID;
  int? salesOrderID;
  String? invoiceID;
  bool? success;
  String? message;
  List<ShippingVerificationListData>? data;
  int? statusCode;
  int? statusValueCode;

  factory ResShippingVerificationList.fromJson(Map<String, dynamic> json) => ResShippingVerificationList(
    success: json["success"] == null ? null : json["success"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<ShippingVerificationListData>.from(json["data"].map((x) => ShippingVerificationListData.fromJson(x))),
    statusCode: json["statusCode"] == null ? null : json["statusCode"],
    statusValueCode: json["statusValueCode"] == null ? null : json["statusValueCode"],
  );

}

class ShippingVerificationListData {
  ShippingVerificationListData({
    this.pickOrderId,
    this.shipDate,
    this.soNumber,
    this.isEdit,
    this.customerName,
    this.customerLocation,
    this.shipperName,
    this.carrierName,
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
    this.isPermissionToEdit,
    this.isEditShippingVerification,
    this.userId,
    this.salesOrderID,
    this.totalCount
  });
  int? salesOrderID;
  int? companyId;
  int? warehouseId;
  int? customerId;
  int? customerPoid;
  int? customerLocationId;
  int? customerLocationShiptoId;
  int? billingAddressId;
  DateTime? dateOfSo;
  DateTime? shipDate;
  int? shipViaId;
  int? carrierId;
  bool? isAllowAdditionalQty;
  bool ?isAttachedProtoPpap;
  bool? isActive;
  DateTime? updatelog;
  String? soNumber;
  int? createdBy;
  DateTime? createdOn;
  int? updatedBy;
  DateTime? updatedOn;
  int? refSalesOrderId;
  int? shippingOrToteAddressId;
  int? totalCount;
  int ?rowNo;
  bool? isEdit;
  String? customerName;
  String? customerLocation;
  String? shipperName;
  String? carrierName;
  String? shippingDate;
  int? pickOrderId;
  bool? isAllPalletsVerifiedOrNot;
  bool? isInvoiceIsCreatedOrNot;
  bool? isPalletCompletedOrNot;
  int ?totalQty;
  int? invoiceId;
  bool? isCreditMemoGenerated;
  bool? isBolAttachmentUploadedOrNot;
  bool? isSupportingDocUploadedOrNot;
  bool? isSalesOrderIsPickedOrNot;
  bool? isPickOrderCreatedOrNot;
  bool ?isPickOrderIsCompletedOrNot;
  bool ?isMergeWithPickOrder;
  String? invoiceNo;
  bool? isPermissionToEdit;
  bool? isEditShippingVerification;
  int?  userId;


  factory ShippingVerificationListData.fromJson(Map<String, dynamic> json) => ShippingVerificationListData(
    pickOrderId: json["pickOrderID"] == null ? null : json["pickOrderID"],
    totalCount: json["totalCount"] == null ? null : json["totalCount"],
    salesOrderID: json["salesOrderID"] == null ? null : json["salesOrderID"],
    shipDate: json["shipDate"] == null ? null : DateTime.parse(json["shipDate"]),
    soNumber: json["soNumber"] == null ? null : json["soNumber"],
    isEdit: json["isEdit"] == null ? null : json["isEdit"],
    customerName: json["customerName"] == null ? null : json["customerName"],
    customerLocation: json["customerLocation"] == null ? null : json["customerLocation"],
    shipperName: json["shipperName"] == null ? null : json["shipperName"],
    carrierName: json["carrierName"] == null ? null : json["carrierName"],
    isAllPalletsVerifiedOrNot: json["isAllPalletsVerifiedOrNot"] == null ? null : json["isAllPalletsVerifiedOrNot"],
    isInvoiceIsCreatedOrNot: json["isInvoiceIsCreatedOrNot"] == null ? null : json["isInvoiceIsCreatedOrNot"],
    isPalletCompletedOrNot: json["isPalletCompletedOrNot"] == null ? null : json["isPalletCompletedOrNot"],
    invoiceId: json["invoiceID"] == null ? null : json["invoiceID"],
    isCreditMemoGenerated: json["isCreditMemoGenerated"] == null ? null : json["isCreditMemoGenerated"],
    isBolAttachmentUploadedOrNot: json["isBOLAttachmentUploadedOrNot"] == null ? null : json["isBOLAttachmentUploadedOrNot"],
    isSupportingDocUploadedOrNot: json["isSupportingDocUploadedOrNot"] == null ? null : json["isSupportingDocUploadedOrNot"],
    isSalesOrderIsPickedOrNot: json["isSalesOrderIsPickedOrNot"] == null ? null : json["isSalesOrderIsPickedOrNot"],
    isPickOrderCreatedOrNot: json["isPickOrderCreatedOrNot"] == null ? null : json["isPickOrderCreatedOrNot"],
    isPickOrderIsCompletedOrNot: json["isPickOrderIsCompletedOrNot"] == null ? null : json["isPickOrderIsCompletedOrNot"],
    isMergeWithPickOrder: json["isMergeWithPickOrder"] == null ? null : json["isMergeWithPickOrder"],
    invoiceNo: json["invoiceNo"] == null ? null : json["invoiceNo"],
    isPermissionToEdit: json["isPermissionToEdit"] == null ? null : json["isPermissionToEdit"],
    isEditShippingVerification: json["isEditShippingVerification"] == null ? null : json["isEditShippingVerification"],
    userId: json["userID"] == null ? null : json["userID"],
  );

}
