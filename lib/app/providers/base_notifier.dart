
import 'package:flutter/cupertino.dart';
import 'package:demo_win_wms/app/utils/api_response.dart';
import 'package:demo_win_wms/app/utils/enums.dart';

class BaseNotifier extends ChangeNotifier{

  apiResIsLoading(ApiResponse res){

    res.state = Status.LOADING;

    notifyListeners();
  }

  apiResIsSuccess<T>(ApiResponse res,T data){

    res.state = Status.COMPLETED;

    res.data = data;

    notifyListeners();
  }

  apiResIsFailed(ApiResponse res,Object e){

    res.state = Status.ERROR;

    res.msg = e.toString();

    notifyListeners();
  }

}