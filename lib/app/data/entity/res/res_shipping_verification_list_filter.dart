class ResShippingVerificationFilter {
  bool? success;

  ResShippingVerificationFilter({
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

  factory ResShippingVerificationFilter.fromJson(Map<String, dynamic> json) =>
      ResShippingVerificationFilter(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        statusCode: json["statusCode"] == null ? null : json["statusCode"],
        statusValueCode:
            json["statusValueCode"] == null ? null : json["statusValueCode"],
      );

Map<String, dynamic> toJson() => {
  "success": success == null ? null : success,
  "message": message == null ? null : message,
  "data": data == null ? null : data?.toJson(),
  "statusCode": statusCode == null ? null : statusCode,
  "statusValueCode": statusValueCode == null ? null : statusValueCode,
};
}

class Data {
  Data({
    this.customerlist,
    this.customerlocationlist,
    this.shipvialist,
    this.carrierlist,
  });

  List<CarrierlistElement>? customerlist;
  List<CarrierlistElement>? customerlocationlist;
  List<CarrierlistElement>? shipvialist;
  List<CarrierlistElement>? carrierlist;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        customerlist: json["customerlist"] == null
            ? null
            : List<CarrierlistElement>.from(json["customerlist"]
                .map((x) => CarrierlistElement.fromJson(x))),
        customerlocationlist: json["customerlocationlist"] == null
            ? null
            : List<CarrierlistElement>.from(json["customerlocationlist"]
                .map((x) => CarrierlistElement.fromJson(x))),
        shipvialist: json["shipvialist"] == null
            ? null
            : List<CarrierlistElement>.from(
                json["shipvialist"].map((x) => CarrierlistElement.fromJson(x))),
        carrierlist: json["carrierlist"] == null
            ? null
            : List<CarrierlistElement>.from(
                json["carrierlist"].map((x) => CarrierlistElement.fromJson(x))),
      );

Map<String, dynamic> toJson() => {
  "customerlist": customerlist == null ? null : List<dynamic>.from(customerlist!.map((x) => x.toJson())),
  "customerlocationlist": customerlocationlist == null ? null : List<dynamic>.from(customerlocationlist!.map((x) => x.toJson())),
  "shipvialist": shipvialist == null ? null : List<dynamic>.from(shipvialist!.map((x) => x.toJson())),
  "carrierlist": carrierlist == null ? null : List<dynamic>.from(carrierlist!.map((x) => x.toJson())),
};
}

class CarrierlistElement {
  CarrierlistElement({
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

  factory CarrierlistElement.fromJson(Map<String, dynamic> json) =>
      CarrierlistElement(
        disabled: json["disabled"] == null ? null : json["disabled"],
        group: json["group"] == null ? null : json["group"],
        selected: json["selected"] == null ? null : json["selected"],
        text: json["text"] == null ? null : json["text"],
        value: json["value"] == null ? null : json["value"],
      );

Map<String, dynamic> toJson() => {
  "disabled": disabled == null ? null : disabled,
  "group": group == null ? null :group,
  "selected": selected == null ? null : selected,
  "text": text == null ? null : text,
  "value": value == null ? null : value,
};
}
