
class ResPickOrderViewLineItem {
  ResPickOrderViewLineItem({
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

  factory ResPickOrderViewLineItem.fromJson(Map<String, dynamic> json) => ResPickOrderViewLineItem(
    success: json["success"] == null ? null : json["success"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    statusCode: json["statusCode"] == null ? null : json["statusCode"],
    statusValueCode: json["statusValueCode"] == null ? null : json["statusValueCode"],
  );
}

class Data {
  Data({
    this.itemLocationList,
    this.pickOrderSoDetail,
    this.pickOrder,
  });

  List<ItemLocationList>? itemLocationList;
  PickOrderSoDetail? pickOrderSoDetail;
  PickOrder? pickOrder;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    itemLocationList: json["itemLocationList"] == null ? null : List<ItemLocationList>.from(json["itemLocationList"].map((x) => ItemLocationList.fromJson(x))),
    pickOrderSoDetail: json["pickOrderSODetail"] == null ? null : PickOrderSoDetail.fromJson(json["pickOrderSODetail"]),
    pickOrder: json["pickOrder"] == null ? null : PickOrder.fromJson(json["pickOrder"]),
  );
}

class ItemLocationList {
  ItemLocationList({
    this.itemLocationId,
    this.itemId,
    this.itemName,
    this.locationName,
    this.locationType,
    this.updatelog,
    this.warehouseName,
    this.companyName,
    this.sectionName,
    this.year,
    this.monthName,
    this.fullYear,
    this.isTotePart,
    this.availableQty
  });

  int? itemLocationId;
  int? itemId;
  String? itemName;
  String? locationName;
  String? locationType;
  DateTime? updatelog;
  String? warehouseName;
  String? companyName;
  String? sectionName;
  int? year;
  String? monthName;
  String? fullYear;
  bool? isTotePart;
  int? availableQty;

  factory ItemLocationList.fromJson(Map<String, dynamic> json) => ItemLocationList(
    itemLocationId: json["itemLocationID"] == null ? null : json["itemLocationID"],
    itemId: json["itemID"] == null ? null : json["itemID"],
    itemName: json["itemName"] == null ? null : json["itemName"],
    locationName: json["locationName"] == null ? null : json["locationName"],
    locationType: json["locationType"] == null ? null : json["locationType"],
    updatelog: json["updatelog"] == null ? null : DateTime.parse(json["updatelog"]),
    warehouseName: json["warehouseName"] == null ? null : json["warehouseName"],
    companyName: json["companyName"] == null ? null : json["companyName"],
    sectionName: json["sectionName"] == null ? null : json["sectionName"],
    year: json["year"] == null ? null : json["year"],
    monthName: json["monthName"] == null ? null : json["monthName"],
    fullYear: json["fullYear"] == null ? null : json["fullYear"],
    isTotePart: json["isTotePart"] == null ? null : json["isTotePart"],
    availableQty: json["availableQty"] == null ? null : json["availableQty"],
  );
}

class PickOrder {
  PickOrder({
    this.statusTerm,
    this.soNumber,
    this.pickOrderID
  });

  int? pickOrderID;
  String? statusTerm;
  String? soNumber;

  factory PickOrder.fromJson(Map<String, dynamic> json) => PickOrder(
    statusTerm: json["status_Term"] == null ? null : json["status_Term"],
    pickOrderID: json["pickOrderID"] == null ? 0 : json["pickOrderID"],
    soNumber: json["soNumber"] == null ? null : json["soNumber"],
  );
}

class PickOrderSoDetail {
  PickOrderSoDetail({
    this.pickOrderSODetailID,
    this.poNumber,
    this.uom,
    this.updatelog,
    this.itemName,
    this.boxQty,
    this.requestedQty,
    this.currentPartStatusTerm,
    this.itemID,
    this.isTotePart
  });

  bool? isTotePart;
  int? pickOrderSODetailID;
  int? itemID;
  String? poNumber;
  String? uom;
  String? updatelog;
  String? itemName;
  int? boxQty;
  int? requestedQty;
  String? currentPartStatusTerm;

  factory PickOrderSoDetail.fromJson(Map<String, dynamic> json) => PickOrderSoDetail(
    poNumber: json["poNumber"] == null ? null : json["poNumber"],
    isTotePart: json["isTotePart"] == null ? null : json["isTotePart"],
    uom: json["uom"] == null ? null : json["uom"],
    pickOrderSODetailID: json["pickOrderSODetailID"] == null ? null : json["pickOrderSODetailID"],
    updatelog: json["updatelog"] == null ? null : json["updatelog"],
    itemID: json["itemID"] == null ? null : json["itemID"],
    itemName: json["itemName"] == null ? null : json["itemName"],
    boxQty: json["boxQty"] == null ? null : json["boxQty"],
    requestedQty: json["qty"] == null ? null : json["qty"].toInt(),
    currentPartStatusTerm: json["currentPartStatusTerm"] == null ? null : json["currentPartStatusTerm"],
  );
}
