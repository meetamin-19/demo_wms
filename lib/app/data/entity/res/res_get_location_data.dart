class ResGetLocationData {
  ResGetLocationData({
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

  factory ResGetLocationData.fromJson(Map<String, dynamic> json) => ResGetLocationData(
    success: json["success"] == null ? null : json["success"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    statusCode: json["statusCode"] == null ? null : json["statusCode"],
    statusValueCode: json["statusValueCode"] == null ? null : json["statusValueCode"],
  );

}

class Data {
  Data({
    this.locationId,
    this.warehouseId,
    this.sectionId,
    this.rackId,
    this.rowId,
    this.columnId,
    this.locationCode,
    this.locationTitle,
    this.locationTypeTerm,
    this.description,
    this.storageCapacity,
    this.statusTerm,
    this.currentStorage,
    this.associationId,
    this.associationTypeTerm,
    this.customerId,
    this.customerLocationId,
    this.isActive,
    this.updatelog,
    this.orderNo,
    this.createdOn,
    this.createdBy,
    this.updatedBy,
    this.updatedOn,
    this.companyId,
    this.totalCount,
    this.rowNo,
    this.isEdit,
    this.warehouseName,
    this.sectionName,
    this.rackName,
    this.companyName,
    this.isQtyExistsOrNot,
    this.isDefault,
    this.displayName,
    this.isDefaultLocationOrNot,
    this.isLocationFull,
  });

  int? locationId;
  int? warehouseId;
  int? sectionId;
  int? rackId;
  int? rowId;
  int? columnId;
  String? locationCode;
  String? locationTitle;
  String ?locationTypeTerm;
  dynamic description;
  int? storageCapacity;
  dynamic statusTerm;
  int ?currentStorage;
  int? associationId;
  dynamic associationTypeTerm;
  int? customerId;
  int? customerLocationId;
  bool? isActive;
  DateTime? updatelog;
  int? orderNo;
  DateTime? createdOn;
  int? createdBy;
  int? updatedBy;
  DateTime? updatedOn;
  int? companyId;
  int? totalCount;
  int? rowNo;
  bool? isEdit;
  dynamic warehouseName;
  dynamic sectionName;
  dynamic rackName;
  dynamic companyName;
  bool? isQtyExistsOrNot;
  bool? isDefault;
  String? displayName;
  bool? isDefaultLocationOrNot;
  bool? isLocationFull;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    locationId: json["locationID"] == null ? null : json["locationID"],
    warehouseId: json["warehouseID"] == null ? null : json["warehouseID"],
    sectionId: json["sectionID"] == null ? null : json["sectionID"],
    rackId: json["rackID"] == null ? null : json["rackID"],
    rowId: json["rowID"] == null ? null : json["rowID"],
    columnId: json["columnID"] == null ? null : json["columnID"],
    locationCode: json["locationCode"] == null ? null : json["locationCode"],
    locationTitle: json["locationTitle"] == null ? null : json["locationTitle"],
    locationTypeTerm: json["locationType_Term"] == null ? null : json["locationType_Term"],
    description: json["description"],
    storageCapacity: json["storageCapacity"] == null ? null : json["storageCapacity"],
    statusTerm: json["status_Term"],
    currentStorage: json["currentStorage"] == null ? null : json["currentStorage"],
    associationId: json["associationID"] == null ? null : json["associationID"],
    associationTypeTerm: json["associationType_Term"],
    customerId: json["customerID"] == null ? null : json["customerID"],
    customerLocationId: json["customerLocationID"] == null ? null : json["customerLocationID"],
    isActive: json["isActive"] == null ? null : json["isActive"],
    updatelog: json["updatelog"] == null ? null : DateTime.parse(json["updatelog"]),
    orderNo: json["orderNo"] == null ? null : json["orderNo"],
    createdOn: json["createdOn"] == null ? null : DateTime.parse(json["createdOn"]),
    createdBy: json["createdBy"] == null ? null : json["createdBy"],
    updatedBy: json["updatedBy"] == null ? null : json["updatedBy"],
    updatedOn: json["updatedOn"] == null ? null : DateTime.parse(json["updatedOn"]),
    companyId: json["companyID"] == null ? null : json["companyID"],
    totalCount: json["totalCount"] == null ? null : json["totalCount"],
    rowNo: json["rowNo"] == null ? null : json["rowNo"],
    isEdit: json["isEdit"] == null ? null : json["isEdit"],
    warehouseName: json["warehouseName"],
    sectionName: json["sectionName"],
    rackName: json["rackName"],
    companyName: json["companyName"],
    isQtyExistsOrNot: json["isQtyExistsOrNot"] == null ? null : json["isQtyExistsOrNot"],
    isDefault: json["isDefault"] == null ? null : json["isDefault"],
    displayName: json["displayName"] == null ? null : json["displayName"],
    isDefaultLocationOrNot: json["isDefaultLocationOrNot"] == null ? null : json["isDefaultLocationOrNot"],
    isLocationFull: json["isLocationFull"] == null ? null : json["isLocationFull"],
  );

}
