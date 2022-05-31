
class ResGetContainerListFilter {
  bool? success;

  ResGetContainerListFilter({
    this.success,
    this.message,
    this.data,
    this.statusCode,
    this.statusValueCode,
  });


  String? message;
  Data? data;
  int? statusCode;
  int? statusValueCode;

  factory ResGetContainerListFilter.fromJson(Map<String, dynamic> json) => ResGetContainerListFilter(
    success: json["success"] == null ? null : json["success"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    statusCode: json["statusCode"] == null ? null : json["statusCode"],
    statusValueCode: json["statusValueCode"] == null ? null : json["statusValueCode"],
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toJson(),
    "statusCode": statusCode == null ? null : statusCode,
    "statusValueCode": statusValueCode == null ? null : statusValueCode,
  };
}

class Data {
  Data({
    this.warehouselist,
  });

  List<Warehouselist>? warehouselist;


  factory Data.fromJson(Map<String, dynamic> json) => Data(
    warehouselist: json["warehouselist"] == null ? null : List<Warehouselist>.from(json["warehouselist"].map((x) => Warehouselist.fromJson(x))),

  );

  Map<String, dynamic> toJson() => {
    "warehouselist": warehouselist == null ? null : List<dynamic>.from(warehouselist!.map((x) => x.toJson())),
  };
}

class Warehouselist {
  Warehouselist({
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

  factory Warehouselist.fromJson(Map<String, dynamic> json) => Warehouselist(
    disabled: json["disabled"] == null ? null : json["disabled"],
    group: json["group"],
    selected: json["selected"] == null ? null : json["selected"],
    text: json["text"] == null ? null : json["text"],
    value: json["value"] == null ? null : json["value"],
  );

  Map<String, dynamic> toJson() => {
    "disabled": disabled == null ? null : disabled,
    "group": group,
    "selected": selected == null ? null : selected,
    "text": text == null ? null : text,
    "value": value == null ? null : value,
  };
}
