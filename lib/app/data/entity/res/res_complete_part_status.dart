
class ResGetCompletePartStatus {
  ResGetCompletePartStatus({
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

  factory ResGetCompletePartStatus.fromJson(Map<String, dynamic> json) => ResGetCompletePartStatus(
    success: json["success"] == null ? null : json["success"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    statusCode: json["statusCode"] == null ? null : json["statusCode"],
    statusValueCode: json["statusValueCode"] == null ? null : json["statusValueCode"],
  );

}

class Data {
  Data({
    this.pickOrderList,
    this.objSaveUpdateResponseModel,
  });

  List<PickOrderList>? pickOrderList;
  List<ObjSaveUpdateResponseModel>? objSaveUpdateResponseModel;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    pickOrderList: json["pickOrderList"] == null ? null : List<PickOrderList>.from(json["pickOrderList"].map((x) => PickOrderList.fromJson(x))),
    objSaveUpdateResponseModel: json["objSaveUpdateResponseModel"] == null ? null : List<ObjSaveUpdateResponseModel>.from(json["objSaveUpdateResponseModel"].map((x) => ObjSaveUpdateResponseModel.fromJson(x))),
  );


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

class PickOrderList {
  PickOrderList({
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
    this.invoiceId,
    this.palletCount,
    this.updatedBy,
    this.updatedOn,
    this.totalCount,
    this.rowNo,
    this.isEdit,
    this.pickOrderLinkedTo,
    this.pickOrderLinkedOn,
    this.isPickOrderIsPickedOrNot,
    this.isPickOrderLinked,
    this.isPickOrderLinkedOrNot,
    this.isPoAlreadyLinkOrNot,
    this.isPoAlreadyLinked,
    this.isAbleToPickOrNot,
    this.pickOrderCompletedOn,
    this.pickOrderNote,
    this.isInvoiceIsCreatedOrNot,
    this.isAbleToView,
    this.isAbleToDelete,
    this.pickOrderAcknowledeger,
    this.isPickOrderAcknowledegerOrNot,
    this.isAbleToAcknowledge,

  });

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
  DateTime? updatelog;

  int? invoiceId;
  int? palletCount;
  int? updatedBy;
  DateTime? updatedOn;
  int? totalCount;
  int? rowNo;
  bool? isEdit;

  int? pickOrderLinkedTo;
  DateTime? pickOrderLinkedOn;
  bool? isPickOrderIsPickedOrNot;
  bool? isPickOrderLinked;
  bool? isPickOrderLinkedOrNot;
  bool? isPoAlreadyLinkOrNot;
  bool? isPoAlreadyLinked;
  bool? isAbleToPickOrNot;
  DateTime? pickOrderCompletedOn;

  String? pickOrderNote;
  bool? isInvoiceIsCreatedOrNot;
  bool? isAbleToView;
  bool? isAbleToDelete;
  int? pickOrderAcknowledeger;
  bool? isPickOrderAcknowledegerOrNot;
  bool? isAbleToAcknowledge;


  factory PickOrderList.fromJson(Map<String, dynamic> json) => PickOrderList(
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
    updatelog: json["updatelog"] == null ? null : DateTime.parse(json["updatelog"]),
    invoiceId: json["invoiceID"] == null ? null : json["invoiceID"],
    palletCount: json["palletCount"] == null ? null : json["palletCount"],
    updatedBy: json["updatedBy"] == null ? null : json["updatedBy"],
    updatedOn: json["updatedOn"] == null ? null : DateTime.parse(json["updatedOn"]),
    totalCount: json["totalCount"] == null ? null : json["totalCount"],
    rowNo: json["rowNo"] == null ? null : json["rowNo"],
    isEdit: json["isEdit"] == null ? null : json["isEdit"],
    pickOrderLinkedTo: json["pickOrderLinkedTo"] == null ? null : json["pickOrderLinkedTo"],
    pickOrderLinkedOn: json["pickOrderLinkedOn"] == null ? null : DateTime.parse(json["pickOrderLinkedOn"]),
    isPickOrderIsPickedOrNot: json["isPickOrderIsPickedOrNot"] == null ? null : json["isPickOrderIsPickedOrNot"],
    isPickOrderLinked: json["isPickOrderLinked"] == null ? null : json["isPickOrderLinked"],
    isPickOrderLinkedOrNot: json["isPickOrderLinkedOrNot"] == null ? null : json["isPickOrderLinkedOrNot"],
    isPoAlreadyLinkOrNot: json["isPOAlreadyLinkOrNot"] == null ? null : json["isPOAlreadyLinkOrNot"],
    isPoAlreadyLinked: json["isPOAlreadyLinked"] == null ? null : json["isPOAlreadyLinked"],
    isAbleToPickOrNot: json["isAbleToPickOrNot"] == null ? null : json["isAbleToPickOrNot"],
    pickOrderCompletedOn: json["pickOrderCompletedOn"] == null ? null : DateTime.parse(json["pickOrderCompletedOn"]),
    pickOrderNote: json["pickOrderNote"] == null ? null : json["pickOrderNote"],
    isInvoiceIsCreatedOrNot: json["isInvoiceIsCreatedOrNot"] == null ? null : json["isInvoiceIsCreatedOrNot"],
    isAbleToView: json["isAbleToView"] == null ? null : json["isAbleToView"],
    isAbleToDelete: json["isAbleToDelete"] == null ? null : json["isAbleToDelete"],
    pickOrderAcknowledeger: json["pickOrderAcknowledeger"] == null ? null : json["pickOrderAcknowledeger"],
    isPickOrderAcknowledegerOrNot: json["isPickOrderAcknowledegerOrNot"] == null ? null : json["isPickOrderAcknowledegerOrNot"],
    isAbleToAcknowledge: json["isAbleToAcknowledge"] == null ? null : json["isAbleToAcknowledge"],

  );
}
