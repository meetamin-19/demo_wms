import 'package:demo_win_wms/app/utils/user_prefs.dart';

class ReqScanPartList {
  ReqScanPartList(
      {required this.pickOrderId,
      required this.palletNo,
      required this.pickOrderSODetailID,
      required this.itemID,
      required this.itemName,
      required this.requestedQty,
      required this.actualPicked,
      required this.year,
      required this.month,
      required this.boxQty,
      required this.companyId,
      required this.customCode,
      required this.locationID,
      required this.locationTypeTerm,
      required this.numberOfBoxes,
      required this.pONumber,
      required this.pOPalletID,
      required this.sODetailID,
      required this.warehouseID});

  int pickOrderId;
  int companyId;
  int warehouseID;
  int pOPalletID;
  int itemID;
  int requestedQty;
  int actualPicked;
  int boxQty;
  int numberOfBoxes;
  int locationID;
  int sODetailID;
  int pickOrderSODetailID;
  int year;

  String palletNo;
  String locationTypeTerm;
  String itemName;
  String pONumber;
  String month;
  String customCode;

   Future<Map<String, dynamic>> toJson() async {
    final user = await UserPrefs.shared.getUser;

    return {
      "PickOrderID": pickOrderId,
      "CompanyID": companyId,
      "WarehouseID": warehouseID,
      "POPalletID": pOPalletID,
      "PalletNo": palletNo,
      "Item_ID": itemID,
      "RequestedQty": requestedQty,
      "ActualPicked": actualPicked,
      "BoxQty": boxQty,
      "NumberOfBoxes": numberOfBoxes,
      "LocationID": locationID,
      "LocationType_Term": locationTypeTerm,
      "SODetailID": sODetailID,
      "PickOrderSODetailID": pickOrderSODetailID,
      "ItemName": itemName,
      "PONumber": pONumber,
      "Month": month,
      "Year": year,
      "CustomCode": customCode,
      "UserID": user.userID
    };
  }
}
