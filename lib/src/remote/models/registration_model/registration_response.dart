import 'dart:convert';

import 'package:myvegiz_flutter/src/remote/models/user_model/user_model.dart';

class RegistrationResponse {
  final String status;
  final String message;
  final Result? result;

  RegistrationResponse({
    required this.status,
    required this.message,
    this.result,
  });

  factory RegistrationResponse.fromRawJson(String str) =>
      RegistrationResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegistrationResponse.fromJson(Map<String, dynamic> json) =>
      RegistrationResponse(
        status: json["status"] ?? "",
        message: json["message"] ?? "",
        result: json["result"] != null ? Result.fromJson(json["result"]) : null,
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "result": result?.toJson(),
  };
}

class Result {
  final UserModel? userData;

  Result({this.userData});

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    userData:
    json["userData"] != null ? UserModel.fromJson(json["userData"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "userData": userData?.toJson(),
  };
}
