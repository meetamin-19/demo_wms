
import 'package:demo_win_wms/app/data/entity/res/res_get_pick_order_data_for_view.dart';

class ResPickOrderLinkUserList {
  ResPickOrderLinkUserList({
    this.success,
    this.message,
    this.data,
    this.statusCode,
    this.statusValueCode,
  });

  bool? success;
  String? message;
  Data? data;
  int? statusCode;
  int? statusValueCode;

  factory ResPickOrderLinkUserList.fromJson(Map<String, dynamic> json) => ResPickOrderLinkUserList(
    success: json["success"] == null ? null : json["success"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    statusCode: json["statusCode"] == null ? null : json["statusCode"],
    statusValueCode: json["statusValueCode"] == null ? null : json["statusValueCode"],
  );
}

class Data {
  Data({
    this.pickOrder,
    this.userList,
  });

  PickOrder? pickOrder;
  List<PickOrderLinkUser>? userList;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    pickOrder: json["pickOrder"] == null ? null : PickOrder.fromJson(json["pickOrder"]),
    userList: json["userList"] == null ? null : List<PickOrderLinkUser>.from(json["userList"].map((x) => PickOrderLinkUser.fromJson(x))),
  );

}

class PickOrder {
  PickOrder({
    this.pickOrderId,
});
  int? pickOrderId;

  factory PickOrder.fromJson(Map<String, dynamic> json) => PickOrder(
    pickOrderId: json["pickOrderID"] ?? null,
  );

}

class PickOrderLinkUser {
  PickOrderLinkUser({
    this.disabled,
    this.group,
    this.selected,
    this.text,
    this.value,
  });

  bool? disabled;
  dynamic group;
  bool? selected;
  String? text;
  String? value;

  factory PickOrderLinkUser.fromJson(Map<String, dynamic> json) => PickOrderLinkUser(
    disabled: json["disabled"] == null ? null : json["disabled"],
    group: json["group"],
    selected: json["selected"] == null ? null : json["selected"],
    text: json["text"] == null ? null : json["text"],
    value: json["value"] == null ? null : json["value"],
  );

}
