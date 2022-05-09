class ResWithPrimaryKeyAndErrorMessage {
  ResWithPrimaryKeyAndErrorMessage({
    this.success,
    this.message,
    this.data,
    this.statusCode,
    this.statusValueCode,
  });

  bool? success;
  String? message;
  List<Data>? data;
  int? statusCode;
  int? statusValueCode;

  factory ResWithPrimaryKeyAndErrorMessage.fromJson(Map<String, dynamic> json) => ResWithPrimaryKeyAndErrorMessage(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
        statusCode: json["statusCode"] == null ? null : json["statusCode"],
        statusValueCode: json["statusValueCode"] == null ? null : json["statusValueCode"],
      );
}

class Data {
  Data({
    this.primaryKey,
    this.errorMessage,
  });

  String? primaryKey;
  String? errorMessage;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        primaryKey: json["primaryKey"] == null ? null : json["primaryKey"],
        errorMessage: json["errorMessage"] == null ? "Something went wrong" : json["errorMessage"],
      );
}
