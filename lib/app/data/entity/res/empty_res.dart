class EmptyRes {
  EmptyRes({
    this.success,
    this.message,
    this.statusCode,
    this.statusValueCode,
  });

  bool? success;
  String? message;
  int? statusCode;
  int? statusValueCode;

  factory EmptyRes.fromJson(Map<String, dynamic> json) => EmptyRes(
    success: json["success"] == null ? null : json["success"],
    message: json["message"] == null ? null : json["message"],
    statusCode: json["statusCode"] == null ? null : json["statusCode"],
    statusValueCode: json["statusValueCode"] == null ? null : json["statusValueCode"],
  );
}