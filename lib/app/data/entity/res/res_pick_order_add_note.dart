
class ResPickOrderAddNote {
  ResPickOrderAddNote({
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

  factory ResPickOrderAddNote.fromJson(Map<String, dynamic> json) => ResPickOrderAddNote(
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
  });

  PickOrder? pickOrder;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    pickOrder: json["pickOrder"] == null ? null : PickOrder.fromJson(json["pickOrder"]),
  );
}

class PickOrder {
  PickOrder({
    this.pickOrderId,
    this.pickOrderNote,
    this.updateLog,
  });

  int? pickOrderId;
  String? pickOrderNote;
  String? updateLog;

  factory PickOrder.fromJson(Map<String, dynamic> json) => PickOrder(
    pickOrderId: json["pickOrderID"] == null ? null : json["pickOrderID"],
    pickOrderNote: json["pickOrderNote"] == null ? null : json["pickOrderNote"],
    updateLog: json["updateLog"] == null ? null : json["updateLog"],

  );
}
