class ResCheckForCycleCount {
  ResCheckForCycleCount({
    this.success,
    this.message,
    this.data,
    this.statusCode,
    this.statusValueCode,
  });

  bool? success;
  String? message;
  List<CheckForCycleBool>? data;
  int? statusCode;
  int? statusValueCode;

  factory ResCheckForCycleCount.fromJson(Map<String, dynamic> json) => ResCheckForCycleCount(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<CheckForCycleBool>.from(json["data"].map((x) => CheckForCycleBool.fromJson(x))),
        statusCode: json["statusCode"] == null ? null : json["statusCode"],
        statusValueCode: json["statusValueCode"] == null ? null : json["statusValueCode"],
      );


}

class CheckForCycleBool {
  CheckForCycleBool({
    this.isCycleCountRequiredOrNot,
  });

  int? isCycleCountRequiredOrNot;

  factory CheckForCycleBool.fromJson(Map<String, dynamic> json) => CheckForCycleBool(
        isCycleCountRequiredOrNot: json["IsCycleCountRequiredOrNot"] == null ? null : json["IsCycleCountRequiredOrNot"],
      );

}
