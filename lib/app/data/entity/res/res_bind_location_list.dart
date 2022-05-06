class ResBindLocationList {
  ResBindLocationList({
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

  factory ResBindLocationList.fromJson(Map<String, dynamic> json) => ResBindLocationList(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        statusCode: json["statusCode"] == null ? null : json["statusCode"],
        statusValueCode: json["statusValueCode"] == null ? null : json["statusValueCode"],
      );
}

class Data {
  Data({
    this.bindLocationListData,
  });

  List<BindLocationListData>? bindLocationListData;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        bindLocationListData: json["bindlocationtlist"] == null
            ? null
            : List<BindLocationListData>.from(json["bindlocationtlist"].map((x) => BindLocationListData.fromJson(x))),
      );
}

class BindLocationListData {
  BindLocationListData({
    this.text,
    this.value,
    this.selected,
    this.disabled,
    this.data1,
    this.data2,
    this.data3,
  });

  String? text;
  String? value;
  bool? selected;
  bool? disabled;
  String? data1;
  String? data2;
  String? data3;

  factory BindLocationListData.fromJson(Map<String, dynamic> json) => BindLocationListData(
        text: json["text"] == null ? null : json["text"],
        value: json["value"] == null ? null : json["value"],
        selected: json["selected"] == null ? null : json["selected"],
        disabled: json["disabled"] == null ? null : json["disabled"],
        data1: json["data1"] == null ? null : json["data1"],
        data2: json["data2"] == null ? null : json["data2"],
        data3: json["data3"] == null ? null : json["data3"],
      );

  Map<String, dynamic> toJson() => {
        "text": text == null ? null : text,
        "value": value == null ? null : value,
        "selected": selected == null ? null : selected,
        "disabled": disabled == null ? null : disabled,
        "data1": data1 == null ? null : data1,
        "data2": data2 == null ? null : data2,
        "data3": data3 == null ? null : data3,
      };
}
