import 'package:demo_win_wms/app/data/data_service/web_service.dart';
import 'package:demo_win_wms/app/data/entity/res/res_get_pick_order_data_for_view.dart';
import 'package:demo_win_wms/app/data/entity/res/res_pick_order_sales_order_list.dart';
import 'package:demo_win_wms/app/data/entity/res/res_primarykey_errormessage.dart';
import 'package:demo_win_wms/app/utils/constants.dart';
import 'package:demo_win_wms/app/utils/user_prefs.dart';

abstract class PickOrderData{
  Future<ResGetPickOrderDataForView> getPickOrderDataForView({required int pickOrderID, required int salesOrderID});
  Future<ResSalesOrderListGet> getSalesOrderList({required int numOfData, required int startPoint,required int pickOrderID, required int salesOrderID});
  Future<ResWithPrimaryKeyAndErrorMessage> completePickOrder({required int pickOrderID});
  // Future<>

}

class PickOrderDataImpl extends PickOrderData{
  @override
  Future<ResGetPickOrderDataForView> getPickOrderDataForView({required int pickOrderID, required int salesOrderID}) async {
    final user = await UserPrefs.shared.getUser;

    final res = await WebService.shared.postApiDIO(url: kBaseURL + 'pickorder/GetPickOrderDataForView_ByID',data: {
      "UserID": user.userID,
      "PickOrderID": pickOrderID,
      "SalesOrderID": salesOrderID
    });

    try {
      return ResGetPickOrderDataForView.fromJson(res!);
    }catch (e) {
      throw kErrorWithRes;
    }
  }


  @override
  Future<ResSalesOrderListGet> getSalesOrderList({required int numOfData, required int startPoint,required int pickOrderID, required int salesOrderID}) async{

    final user = await UserPrefs.shared.getUser;
    
    final res = await WebService.shared.postApiDIO(url: kBaseURL + 'pickorder/Get_SalesOrderDetail_List',data: {
      "length" : numOfData,
      "start" : startPoint,
      "UserID" : user.userID,
      "UserType_Term" : user.userType_Term,
      "DefaultCompanyID" : user.defaultCompanyID,
      "DefaultWarehouseID" : user.defaultWarehouseID,
      "SalesOrderID" : salesOrderID,
      "PickOrderID" : pickOrderID
    });

    try{
      return ResSalesOrderListGet.fromJson(res!);
    } catch(e) {
      throw kErrorWithRes;
    }


  }

  @override
  Future<ResWithPrimaryKeyAndErrorMessage> completePickOrder({required int pickOrderID}) async{
    
    final user = await UserPrefs.shared.getUser;
    
    final res = await WebService.shared.postApiDIO(url: kBaseURL + 'pickorder/CompletePickOrder', data: {
      "PickOrderID" : pickOrderID,
      "UserID" : user.userID
    });

    try {
      return ResWithPrimaryKeyAndErrorMessage.fromJson(res!);
    }
    catch (e) {
      throw kErrorWithRes;
    }
  }

}