
class ResPickOrderListFilter {
  ResPickOrderListFilter({
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

  factory ResPickOrderListFilter.fromJson(Map<String, dynamic> json) => ResPickOrderListFilter(
    success: json["success"] == null ? null : json["success"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    statusCode: json["statusCode"] == null ? null : json["statusCode"],
    statusValueCode: json["statusValueCode"] == null ? null : json["statusValueCode"],
  );
}

class Data {
  Data({
    this.company,
    this.customer,
    this.customerLocation,
    this.status,
    this.shipVia,
  });

  List<Company>? company;
  List<Company>? customer;
  List<Company>? customerLocation;
  List<Company>? status;
  List<Company>? shipVia;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    company: json["company"] == null ? null : List<Company>.from(json["company"].map((x) => Company.fromJson(x))),
    customer: json["customer"] == null ? null : List<Company>.from(json["customer"].map((x) => Company.fromJson(x))),
    customerLocation: json["customerLocation"] == null ? null : List<Company>.from(json["customerLocation"].map((x) => Company.fromJson(x))),
    status: json["status"] == null ? null : List<Company>.from(json["status"].map((x) => Company.fromJson(x))),
    shipVia: json["shipVia"] == null ? null : List<Company>.from(json["shipVia"].map((x) => Company.fromJson(x))),
  );
}

class Company {
  Company({
    this.disabled,
    this.selected,
    this.text,
    this.value,
  });

  bool? disabled;
  bool? selected;
  String? text;
  String? value;

  factory Company.fromJson(Map<String, dynamic> json) => Company(
    disabled: json["disabled"] == null ? null : json["disabled"],
    selected: json["selected"] == null ? null : json["selected"],
    text: json["text"] == null ? null : json["text"],
    value: json["value"] == null ? null : json["value"],
  );
}
