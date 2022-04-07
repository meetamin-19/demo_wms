class ResPath {
  ResPath({
    this.success,
    this.message,
    this.data,
    this.statusCode,
    this.statusValueCode,
  });

  bool? success;
  String? message;
  String? data;
  int? statusCode;
  int? statusValueCode;

  factory ResPath.fromJson(Map<String, dynamic> json) => ResPath(
    data : json["data"] == null ? null : json["data"],
    success: json["success"] == null ? null : json["success"],
    message: json["message"] == null ? null : json["message"],
    statusCode: json["statusCode"] == null ? null : json["statusCode"],
    statusValueCode: json["statusValueCode"] == null ? null : json["statusValueCode"],
  );

}