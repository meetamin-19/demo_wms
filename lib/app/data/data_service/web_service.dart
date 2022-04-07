import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:demo_win_wms/app/utils/user_prefs.dart';

class WebService {
  var dio = Dio();

  static final shared = WebService();

  Future<Map<String, dynamic>?> getApiDIO({required String url}) async {
    try {
      final user = await UserPrefs.shared.getUser;

      Response<Map<String, dynamic>> cool = await dio.get<Map<String, dynamic>>(
          url,
          options: Options(headers: {'Authorization': user.access_Token}));

      print('Res: ${cool.data}');

      return handleResponse(cool);
    } on SocketException {
      throw 'No Internet connection';
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.connectTimeout:
          throw 'Connection timeOut';
        case DioErrorType.sendTimeout:
          throw 'Connection timeOut';
        case DioErrorType.receiveTimeout:
          throw 'Connection timeOut';
        case DioErrorType.response:
          throw 'Something went wrong.';
        case DioErrorType.cancel:
          throw 'Request Canceled by user';
        case DioErrorType.other:
          throw 'Something went wrong.';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> postApiDIO({required String url, data}) async {
    try {

      final user = await UserPrefs.shared.getUser;

      print('URL: $url, \n data: $data, \n Header: ${{'Authorization': 'Bearer ' + user.access_Token}}');

      Response<Map<String, dynamic>> cool =
          await dio.post<Map<String, dynamic>>(url,
              data: data,
              options: Options(headers: {'Authorization': 'Bearer ' + user.access_Token}));

      print('Res: ${cool.data}');

      return handleResponse(cool);
    } on SocketException {
      throw 'No Internet connection';
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.connectTimeout:
          throw 'Connection timeOut';
        case DioErrorType.sendTimeout:
          throw 'Connection timeOut';
        case DioErrorType.receiveTimeout:
          throw 'Connection timeOut';
        case DioErrorType.response:

          if(e.response?.statusCode == 401){
            throw UnAuthorised("User is Unauthorised.");
          }else{
            throw 'Something went wrong.';
          }


        case DioErrorType.cancel:
          throw 'Request Canceled by user';
        case DioErrorType.other:
          throw 'Something went wrong.';
      }
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic>? handleResponse(Response<Map<String, dynamic>> cool) {
    try {
      if ((cool.statusCode ?? 0) >= 200 && (cool.statusCode ?? 0) < 300) {
        return cool.data;
      } else {
        throw 'Error occurred while Communication with Server, with StatusCode : ${cool.statusCode}';
      }
    } catch (e) {
      rethrow;
    }
  }
}

class UnAuthorised implements Exception {

  final String? msg;

  UnAuthorised(this.msg);

  String toString() {
    return "$msg";
  }
}