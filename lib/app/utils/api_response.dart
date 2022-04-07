
import 'enums.dart';

class ApiResponse<T> {
  Status? state;
  T? data;
  String? msg;

  ApiResponse();

  ApiResponse.loading(this.msg) : state = Status.LOADING;

  ApiResponse.completed(this.data) : state = Status.COMPLETED;

  ApiResponse.error(this.msg) : state = Status.ERROR;

  @override
  String toString() {
    return "Status : $state \n Message : $msg \n Data : $data";
  }
}