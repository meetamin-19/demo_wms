

class ReqContainerLinkLocation {
  ReqContainerLinkLocation({
    this.containerId,
    this.userId,
    this.userTypeTerm,
    this.defaultCompanyId,
    this.defaultWarehouseId,
  });

  int? containerId;
  int? userId;
  String? userTypeTerm;
  int? defaultCompanyId;
  int? defaultWarehouseId;

  factory ReqContainerLinkLocation.fromJson(Map<String, dynamic> json) => ReqContainerLinkLocation(
    containerId: json["ContainerID"] == null ? null : json["ContainerID"],
    userId: json["UserID"] == null ? null : json["UserID"],
    userTypeTerm: json["UserType_Term"] == null ? null : json["UserType_Term"],
    defaultCompanyId: json["DefaultCompanyID"] == null ? null : json["DefaultCompanyID"],
    defaultWarehouseId: json["DefaultWarehouseID"] == null ? null : json["DefaultWarehouseID"],
  );

  Map<String, dynamic> toJson() => {
    "ContainerID": containerId == null ? null : containerId,
    "UserID": userId == null ? null : userId,
    "UserType_Term": userTypeTerm == null ? null : userTypeTerm,
    "DefaultCompanyID": defaultCompanyId == null ? null : defaultCompanyId,
    "DefaultWarehouseID": defaultWarehouseId == null ? null : defaultWarehouseId,
  };
}
