import 'dart:convert';

class OtpVerifyResponse {
  final String status;
  final String message;
  final int accountExists;
  final Result? result;

  OtpVerifyResponse({
    required this.status,
    required this.message,
    required this.accountExists,
    this.result,
  });

  factory OtpVerifyResponse.fromRawJson(String str) =>
      OtpVerifyResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OtpVerifyResponse.fromJson(Map<String, dynamic> json) =>
      OtpVerifyResponse(
        status: json["status"] ?? "",
        message: json["message"] ?? "",
        accountExists: json["accountExists"] ?? 0,
        result: json["result"] != null ? Result.fromJson(json["result"]) : null,
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "accountExists": accountExists,
    "result": result?.toJson(),
  };
}

class Result {
  final UserData? userData;

  Result({this.userData});

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    userData:
    json["userData"] != null ? UserData.fromJson(json["userData"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "userData": userData?.toJson(),
  };
}

class UserData {
  final String code;
  final String name;
  final String emailId;
  final String cityCode;
  final String mobile;
  final String? comCode;
  final String status;
  final String? forgot;
  final String? cartCode;
  final String isActive;
  final String cityName;
  final String isCodEnabled;

  UserData({
    required this.code,
    required this.name,
    required this.emailId,
    required this.cityCode,
    required this.mobile,
    this.comCode,
    required this.status,
    this.forgot,
    this.cartCode,
    required this.isActive,
    required this.cityName,
    required this.isCodEnabled,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    code: json["code"] ?? "",
    name: json["name"] ?? "",
    emailId: json["emailId"] ?? "",
    cityCode: json["cityCode"] ?? "",
    mobile: json["mobile"] ?? "",
    comCode: json["comCode"],
    status: json["status"] ?? "",
    forgot: json["forgot"],
    cartCode: json["cartCode"],
    isActive: json["isActive"] ?? "",
    cityName: json["cityName"] ?? "",
    isCodEnabled: json["isCodEnabled"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "name": name,
    "emailId": emailId,
    "cityCode": cityCode,
    "mobile": mobile,
    "comCode": comCode,
    "status": status,
    "forgot": forgot,
    "cartCode": cartCode,
    "isActive": isActive,
    "cityName": cityName,
    "isCodEnabled": isCodEnabled,
  };
}
