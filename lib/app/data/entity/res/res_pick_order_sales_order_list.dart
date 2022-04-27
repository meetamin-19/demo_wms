class ResSalesOrderListGet {
  ResSalesOrderListGet({
    this.success,
    this.message,
    this.data,
    this.statusCode,
    this.statusValueCode,
  });

  bool? success;
  String? message;
  List<SalesOrderList>? data;
  int? statusCode;
  int? statusValueCode;

  factory ResSalesOrderListGet.fromJson(Map<String, dynamic> json) => ResSalesOrderListGet(
    success: json["success"] == null ? null : json["success"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<SalesOrderList>.from(json["data"].map((x) => SalesOrderList.fromJson(x))),
    statusCode: json["statusCode"] == null ? null : json["statusCode"],
    statusValueCode: json["statusValueCode"] == null ? null : json["statusValueCode"],
  );

}

class SalesOrderList {
  SalesOrderList({
    this.pickOrderSoDetailId,
    this.pickOrderId,
    this.salesOrderId,
    this.soDetailId,
    this.companyId,
    this.warehouseId,
    this.itemId,
    this.customerPoid,
    this.poNumber,
    this.qty,
    this.weights,
    this.totalWeights,
    this.description,
    this.uom,
    this.rate,
    this.amount,
    this.statusTerm,
    this.isActive,
    this.updatelog,
    this.createdBy,
    this.createdOn,
    this.updatedBy,
    this.updatedOn,
    this.totalCount,
    this.isEdit,
    this.rowNo,
    this.itemName,
    this.availableQty,
    this.actualPicked,
    this.palletNo,
    this.requestedQty,
    this.boxQty,
    this.currentPartStatusTerm,
    this.pendingQty,
    this.isPartInQaAlertOrNot,
    this.isPartInTote,
    this.etaDate,
    this.shipDate,
    this.isQtyArrivingBeforeShipDate,
    this.oldestStockSuggestedLocation,
    this.transistQty,
  });

  int? pickOrderSoDetailId;
  int ?pickOrderId;
  int? salesOrderId;
  int? soDetailId;
  int? companyId;
  int? warehouseId;
  int? itemId;
  int? customerPoid;
  String? poNumber;
  int? qty;
  int? weights;
  int? totalWeights;
  String? description;
  String? uom;
  double? rate;
  double? amount;
  String? statusTerm;
  bool? isActive;
  DateTime? updatelog;
  int? createdBy;
  DateTime?createdOn;
  int? updatedBy;
  DateTime? updatedOn;
  int? totalCount;
  bool? isEdit;
  int? rowNo;
  String? itemName;
  int? availableQty;
  int? actualPicked;
  String? palletNo;
  int? requestedQty;
  int? boxQty;
  String? currentPartStatusTerm;
  int? pendingQty;
  bool? isPartInQaAlertOrNot;
  bool? isPartInTote;
  DateTime? etaDate;
  DateTime? shipDate;
  bool? isQtyArrivingBeforeShipDate;
  String? oldestStockSuggestedLocation;
  int? transistQty;

  factory SalesOrderList.fromJson(Map<String, dynamic> json) => SalesOrderList(
    pickOrderSoDetailId: json["pickOrderSODetailID"] == null ? null : json["pickOrderSODetailID"],
    pickOrderId: json["pickOrderID"] == null ? null : json["pickOrderID"],
    salesOrderId: json["salesOrderID"] == null ? null : json["salesOrderID"],
    soDetailId: json["soDetailID"] == null ? null : json["soDetailID"],
    companyId: json["companyID"] == null ? null : json["companyID"],
    warehouseId: json["warehouseID"] == null ? null : json["warehouseID"],
    itemId: json["itemID"] == null ? null : json["itemID"],
    customerPoid: json["customerPOID"] == null ? null : json["customerPOID"],
    poNumber: json["poNumber"] == null ? null : json["poNumber"],
    qty: json["qty"] == null ? null : json["qty"].toInt(),
    weights: json["weights"] == null ? null : json["weights"].toInt(),
    totalWeights: json["totalWeights"] == null ? null : json["totalWeights"].toInt(),
    description: json["description"] == null ? null : json["description"],
    uom: json["uom"] == null ? null : json["uom"],
    rate: json["rate"] == null ? null : json["rate"],
    amount: json["amount"] == null ? null : json["amount"],
    statusTerm: json["status_Term"] == null ? null : json["status_Term"],
    isActive: json["isActive"] == null ? null : json["isActive"],
    updatelog: json["updatelog"] == null ? null : DateTime.parse(json["updatelog"]),
    createdBy: json["createdBy"] == null ? null : json["createdBy"],
    createdOn: json["createdOn"] == null ? null : DateTime.parse(json["createdOn"]),
    updatedBy: json["updatedBy"] == null ? null : json["updatedBy"],
    updatedOn: json["updatedOn"] == null ? null : DateTime.parse(json["updatedOn"]),
    totalCount: json["totalCount"] == null ? null : json["totalCount"],
    isEdit: json["isEdit"] == null ? null : json["isEdit"],
    rowNo: json["rowNo"] == null ? null : json["rowNo"],
    itemName: json["itemName"] == null ? null : json["itemName"],
    availableQty: json["availableQty"] == null ? null : json["availableQty"],
    actualPicked: json["actualPicked"] == null ? null : json["actualPicked"].toInt(),
    palletNo: json["palletNo"] == null ? null : json["palletNo"],
    requestedQty: json["requestedQty"] == null ? null : json["requestedQty"],
    boxQty: json["boxQty"] == null ? null : json["boxQty"],
    currentPartStatusTerm: json["currentPartStatusTerm"] == null ? null :json["currentPartStatusTerm"],
    pendingQty: json["pendingQty"] == null ? null : json["pendingQty"].toInt(),
    isPartInQaAlertOrNot: json["isPartInQaAlertOrNot"] == null ? null : json["isPartInQaAlertOrNot"],
    isPartInTote: json["isPartInTote"] == null ? null : json["isPartInTote"],
    etaDate: json["etaDate"] == null ? null : DateTime.parse(json["etaDate"]),
    shipDate: json["shipDate"] == null ? null : DateTime.parse(json["shipDate"]),
    isQtyArrivingBeforeShipDate: json["isQtyArrivingBeforeShipDate"] == null ? null : json["isQtyArrivingBeforeShipDate"],
    oldestStockSuggestedLocation: json["oldestStockSuggestedLocation"] == null ? null : json["oldestStockSuggestedLocation"],
    transistQty: json["transistQty"] == null ? null : json["transistQty"],
  );
}

