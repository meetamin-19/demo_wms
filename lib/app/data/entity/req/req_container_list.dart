

import 'package:demo_win_wms/app/utils/user_prefs.dart';

class ReqGetContainerList {
  ReqGetContainerList({
    this.length,
    this.start,
    this.sortcol,
    this.sortdir,
    this.gloablsearch,
    this.userId,
    this.userTypeTerm,
    this.receivingtypeStr,
    this.statusStr,
    this.defaultCompanyId,
    this.defaultWarehouseId,
    this.warehouseId,
    this.fromEtaDate,
    this.toEtaDate,
  });

  String? length;
  String? start;
  int? sortcol;
  String? sortdir;
  String? gloablsearch;
  int? userId;
  String? userTypeTerm;
  String? receivingtypeStr;
  String? statusStr;
  int? defaultCompanyId;
  int? defaultWarehouseId;
  String? warehouseId;
  DateTime? fromEtaDate;
  String? toEtaDate;

  factory ReqGetContainerList.fromJson(Map<String, dynamic> json) => ReqGetContainerList(
    length: json["length"] == null ? null : json["length"],
    start: json["start"] == null ? null : json["start"],
    sortcol: json["sortcol"] == null ? null : json["sortcol"],
    sortdir: json["sortdir"] == null ? null : json["sortdir"],
    gloablsearch: json["gloablsearch"] == null ? null : json["gloablsearch"],
    userId: json["UserID"] == null ? null : json["UserID"],
    userTypeTerm: json["UserType_Term"] == null ? null : json["UserType_Term"],
    receivingtypeStr: json["ReceivingtypeStr"] == null ? null : json["ReceivingtypeStr"],
    statusStr: json["StatusStr"] == null ? null : json["StatusStr"],
    defaultCompanyId: json["DefaultCompanyID"] == null ? null : json["DefaultCompanyID"],
    defaultWarehouseId: json["DefaultWarehouseID"] == null ? null : json["DefaultWarehouseID"],
    warehouseId: json["WarehouseID"] == null ? null : json["WarehouseID"],
    fromEtaDate: json["from_ETA_date"] == null ? null : DateTime.parse(json["from_ETA_date"]),
    toEtaDate: json["to_ETA_date"] == null ? null : json["to_ETA_date"],
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
     "ReceivingtypeStr": receivingtypeStr == null ? null : receivingtypeStr,
     "StatusStr": statusStr == null ? null : statusStr,
     "DefaultCompanyID": user.defaultCompanyID,
     "DefaultWarehouseID": user.defaultWarehouseID,
     "WarehouseID": warehouseId == null ? null : warehouseId,
     "from_ETA_date": fromEtaDate == null ? null : fromEtaDate!.toIso8601String(),
     "to_ETA_date": toEtaDate == null ? null : toEtaDate
   };
  }
}
