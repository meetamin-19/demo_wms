

import 'package:demo_win_wms/app/utils/user_prefs.dart';

class ReqGetContainerPartList {
  ReqGetContainerPartList({
    this.length,
    this.start,
    this.sortcol,
    this.sortdir,
    this.gloablsearch,
    this.userId,
    this.userTypeTerm,
    this.defaultCompanyId,
    this.defaultWarehouseId,
    this.containerId,
    this.companyId,
  });

  String? length;
  String? start;
  int? sortcol;
  String? sortdir;
  String? gloablsearch;
  int? userId;
  String? userTypeTerm;
  int? defaultCompanyId;
  int? defaultWarehouseId;
  int? containerId;
  int? companyId;

  factory ReqGetContainerPartList.fromJson(Map<String, dynamic> json) => ReqGetContainerPartList(
    length: json["length"] == null ? null : json["length"],
    start: json["start"] == null ? null : json["start"],
    sortcol: json["sortcol"] == null ? null : json["sortcol"],
    sortdir: json["sortdir"] == null ? null : json["sortdir"],
    gloablsearch: json["gloablsearch"] == null ? null : json["gloablsearch"],
    userId: json["UserID"] == null ? null : json["UserID"],
    userTypeTerm: json["UserType_Term"] == null ? null : json["UserType_Term"],
    defaultCompanyId: json["DefaultCompanyID"] == null ? null : json["DefaultCompanyID"],
    defaultWarehouseId: json["DefaultWarehouseID"] == null ? null : json["DefaultWarehouseID"],
    containerId: json["ContainerID"] == null ? null : json["ContainerID"],
    companyId: json["CompanyID"] == null ? null : json["CompanyID"],
  );

  Future<Map<String, dynamic>> toJson() async {
    final user = await UserPrefs.shared.getUser;
    return {
      "length": length == null ? null : length,
      "start": start == null ? null : start,
      "sortcol": sortcol == null ? null : sortcol,
      "sortdir": sortdir == null ? null : sortdir,
      "gloablsearch": gloablsearch == null ? null : gloablsearch,
      "UserID": user.userID,
      "UserType_Term": user.userType_Term,
      "DefaultCompanyID": user.defaultCompanyID,
      "DefaultWarehouseID": user.defaultWarehouseID,
      "ContainerID": containerId == null ? null : containerId,
      "CompanyID": companyId == null ? null : companyId,
    };
  }


}
