
class ResPickorderLinkUserList {
  ResPickorderLinkUserList({
    this.success,
    this.message,
    this.data,
    this.statusCode,
    this.statusValueCode,
  });

  bool? success;
  String? message;
  List<Datum>? data;
  int? statusCode;
  int? statusValueCode;

  factory ResPickorderLinkUserList.fromJson(Map<String, dynamic> json) => ResPickorderLinkUserList(
    success: json["success"] == null ? null : json["success"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    statusCode: json["statusCode"] == null ? null : json["statusCode"],
    statusValueCode: json["statusValueCode"] == null ? null : json["statusValueCode"],
  );
}

class Datum {
  Datum({
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

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    disabled: json["disabled"] == null ? null : json["disabled"],
    group: json["group"],
    selected: json["selected"] == null ? null : json["selected"],
    text: json["text"] == null ? null : json["text"],
    value: json["value"] == null ? null : json["value"],
  );

}
