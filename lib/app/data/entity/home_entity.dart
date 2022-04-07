class Welcome {
  Welcome({
    this.userId,
    this.id,
    this.title,
    this.completed,
  });

  int? userId;
  int? id;
  String? title;
  bool? completed;

  factory Welcome.fromJson(Map<String, dynamic>? json) {

    if (json != null) {
      try{
        return Welcome(
          userId: json["userId"],
          id: json["id"],
          title: json["title"],
          completed: json["completed"],
        );
      }catch(e){
        throw 'Unexpected response.';
      }

    } else {
      throw '';
    }
  }
}

class MyModel implements Serializable {
  String? id;
  String? title;

  MyModel({this.id, this.title});

  factory MyModel.fromJson(Map<String, dynamic> json) {
    return MyModel(
      id: json["id"],
      title: json["title"],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    "id": this.id,
    "title": this.title,
  };
}

class BaseResponse<T extends Serializable> {
  bool? status;
  String? message;
  T? data;
  BaseResponse({this.status, this.message, this.data});

  factory BaseResponse.fromJson(Map<String, dynamic> json, Function(Map<String, dynamic>) create) {
    return BaseResponse<T>(
      status: json["status"],
      message: json["message"],
      data: create(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": this.status,
    "message": this.message,
    "data": this.data?.toJson(),
  };
}

abstract class Serializable {
  Map<String, dynamic> toJson();
}

class Test {
  test() {
    BaseResponse apiResponse = BaseResponse<MyModel>();
    var json = apiResponse.toJson();
    var response = BaseResponse<MyModel>.fromJson(json, (data) => MyModel.fromJson(data));
  }
}
