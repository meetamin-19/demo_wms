
import '../../../utils/user_prefs.dart';

class ReqShippingVerificationListGet {

  ReqShippingVerificationListGet({
    this.customerId,
    this.customerLocationId,
    this.statusTermStr,
    this.shipViaId,
    this.fromShipDateStr,
    this.toShipDateStr,
    this.carrierId,
    this.numOfResults,
    this.listStartAt,
  });

  String? fromShipDateStr;
  String? toShipDateStr;
  String? customerId;
  String? companyId;
  String? shipperId;
  String? customerLocationId;
  String? shipViaId;
  String? statusTermStr;
  String? carrierId;
  String? listStartAt;
  String? numOfResults;

  Future<Map<String, dynamic>> toJson() async{
    final user = await UserPrefs.shared.getUser;
    return {
      "DisplayLength" : numOfResults,
      "DisplayStart" : listStartAt,
      "UserID": user.userID,
      "UserType_Term": user.userType_Term,
      "DefaultCompanyID": user.defaultCompanyID,
      "DefaultWarehouseID": user.defaultWarehouseID,
      "CustomerID": customerId == null ? null : customerId,
      "CustomerLocationID": customerLocationId == null ? null : customerLocationId,
      "ShipViaID" : shipViaId == null ? null : shipViaId,
      "CarrierID" : carrierId == null? null : carrierId,
      "FromShipDate": fromShipDateStr == null ? null : fromShipDateStr,
      "ToShipDate": toShipDateStr == null ? null : toShipDateStr,
      "Status_TermStr": statusTermStr == null ? "Unverified" : statusTermStr,
    };
  }
}
