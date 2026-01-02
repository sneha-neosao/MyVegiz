import 'dart:convert';

class UserModel {
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

  UserModel({
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

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
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

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
