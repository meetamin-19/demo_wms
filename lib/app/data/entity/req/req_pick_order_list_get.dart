import 'package:demo_win_wms/app/utils/user_prefs.dart';

class ReqPickOrderListGet {
  ReqPickOrderListGet({
    this.fromShipDateStr,
    this.toShipDateStr,
    this.customerId,
    this.companyId,
    this.shipperId,
    this.warehouseId,
    this.customerLocationId,
    this.statusTermStr,
    this.numOfResults,
    this.listStartAt
  });

  String? listStartAt;
  String? numOfResults;
  String? fromShipDateStr;
  String? toShipDateStr;
  String? customerId;
  String? companyId;
  String? warehouseId;
  String? shipperId;
  String? customerLocationId;
  String? statusTermStr;

  Future<Map<String, dynamic>> toJson() async {
    final user = await UserPrefs.shared.getUser;

    return {
      "length": numOfResults ?? "100",
      "start": listStartAt ?? "0",
      "UserID": user.userID,
      "WarehouseID": warehouseId ?? 0,
      "UserType_Term": user.userType_Term,
      "FromShipDateStr": fromShipDateStr == null ? null : fromShipDateStr,
      "ToShipDateStr": toShipDateStr == null ? null : toShipDateStr,
      "DefaultCompanyID": user.defaultCompanyID,
      "DefaultWarehouseID": user.defaultWarehouseID,
      "CustomerID": customerId == null ? null : customerId,
      "CompanyID": companyId == null ? null : companyId,
      "ShipperID": shipperId == null ? null : shipperId,
      "CustomerLocationID": customerLocationId == null ? null : customerLocationId,
      "Status_TermStr": statusTermStr == null ? null : statusTermStr,
    };
  }
}
