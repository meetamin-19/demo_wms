
class ResUserLogin {
  ResUserLogin({
    this.success,
    this.message,
    this.data,
    this.dynamicData,
    this.statusCode,
    this.statusValueCode,
  });

  bool? success;
  String? message;
  ResUserLoginData? data;
  dynamic dynamicData;
  int? statusCode;
  int? statusValueCode;

  factory ResUserLogin.fromJson(Map<String, dynamic> json) => ResUserLogin(
    success: json["success"] == null ? null : json["success"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : ResUserLoginData.fromJson(json["data"]),
    dynamicData: json["dynamicData"],
    statusCode: json["statusCode"] == null ? null : json["statusCode"],
    statusValueCode: json["statusValueCode"] == null ? null : json["statusValueCode"],
  );

}

class ResUserLoginData {
  ResUserLoginData({
    this.loginUserData,
    this.defaultDpForCompanyAndWarehouse,
  });

  LoginUserData? loginUserData;
  List<DefaultDpForCompanyAndWarehouse>? defaultDpForCompanyAndWarehouse;

  factory ResUserLoginData.fromJson(Map<String, dynamic> json) => ResUserLoginData(
    loginUserData: json["loginUserData"] == null ? null : LoginUserData.fromJson(json["loginUserData"]),
    defaultDpForCompanyAndWarehouse: json["defaultDPForCompanyAndWarehouse"] == null ? null : List<DefaultDpForCompanyAndWarehouse>.from(json["defaultDPForCompanyAndWarehouse"].map((x) => DefaultDpForCompanyAndWarehouse.fromJson(x))),
  );

}

class DefaultDpForCompanyAndWarehouse {
  DefaultDpForCompanyAndWarehouse({
    this.disabled,
    this.selected,
    this.text,
    this.value,
  });

  bool? disabled;
  bool? selected;
  String? text;
  String? value;

  factory DefaultDpForCompanyAndWarehouse.fromJson(Map<String, dynamic> json) => DefaultDpForCompanyAndWarehouse(
    disabled: json["disabled"] == null ? null : json["disabled"],
    selected: json["selected"] == null ? null : json["selected"],
    text: json["text"] == null ? null : json["text"],
    value: json["value"] == null ? null : json["value"],
  );

  Map<String, dynamic> toJson() => {
    "disabled": disabled == null ? null : disabled,
    "selected": selected == null ? null : selected,
    "text": text == null ? null : text,
    "value": value == null ? null : value,
  };
}

class LoginUserData {
  LoginUserData({
    this.userId,
    this.userName,
    this.password,
    this.firstName,
    this.lastName,
    this.displayName,
    this.email,
    this.mobileNo,
    this.profilePic,
    this.address1,
    this.address2,
    this.city,
    this.zipCode,
    this.state,
    this.country,
    this.userTypeTerm,
    this.isDefault,
    this.userProfilePic,
    this.loginUserRoleName,
    this.loginUserDisplayRoleName,
    this.loginUserRoleTypes,
    this.defaultWarehouseId,
    this.defaultCompanyId,
    this.defaultWarehouseIdForSession,
    this.defaultCompanyIdForSession,
    this.accessToken,
  });

  int? userId;
  String? userName;
  String? password;
  String? firstName;
  String? lastName;
  String? displayName;
  String? email;
  String? mobileNo;
  String? profilePic;
  String? address1;
  String? address2;
  String? city;
  String? zipCode;
  String? state;
  String? country;
  String? userTypeTerm;
  bool? isDefault;
  String? userProfilePic;
  String? loginUserRoleName;
  String? loginUserDisplayRoleName;
  String? loginUserRoleTypes;
  int? defaultWarehouseId;
  int? defaultCompanyId;
  int? defaultWarehouseIdForSession;
  int? defaultCompanyIdForSession;
  String? accessToken;

  factory LoginUserData.fromJson(Map<String, dynamic> json) => LoginUserData(
    userId: json["userID"] == null ? null : json["userID"],
    userName: json["userName"] == null ? null : json["userName"],
    password: json["password"] == null ? null : json["password"],
    firstName: json["firstName"] == null ? null : json["firstName"],
    lastName: json["lastName"] == null ? null : json["lastName"],
    displayName: json["displayName"] == null ? null : json["displayName"],
    email: json["email"] == null ? null : json["email"],
    mobileNo: json["mobileNo"] == null ? null : json["mobileNo"],
    profilePic: json["profilePic"],
    address1: json["address1"],
    address2: json["address2"],
    city: json["city"],
    zipCode: json["zipCode"],
    state: json["state"],
    country: json["country"],
    userTypeTerm: json["userType_Term"] == null ? null : json["userType_Term"],
    isDefault: json["isDefault"] == null ? null : json["isDefault"],
    userProfilePic: json["userProfilePic"],
    loginUserRoleName: json["loginUserRoleName"] == null ? null : json["loginUserRoleName"],
    loginUserDisplayRoleName: json["loginUserDisplayRoleName"] == null ? null : json["loginUserDisplayRoleName"],
    loginUserRoleTypes: json["loginUserRoleTypes"] == null ? null : json["loginUserRoleTypes"],
    defaultWarehouseId: json["defaultWarehouseID"] == null ? null : json["defaultWarehouseID"],
    defaultCompanyId: json["defaultCompanyID"] == null ? null : json["defaultCompanyID"],
    defaultWarehouseIdForSession: json["defaultWarehouseIDForSession"] == null ? null : json["defaultWarehouseIDForSession"],
    defaultCompanyIdForSession: json["defaultCompanyIDForSession"] == null ? null : json["defaultCompanyIDForSession"],
    accessToken: json["access_Token"],
  );
}
