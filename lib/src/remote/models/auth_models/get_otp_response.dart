import 'dart:convert';

/// Represents the API response for fetching OTP success details.
import 'dart:convert';

class GetOtpResponse {
  final String status;
  final String message;
  final String result;
  final SmsResponse? smsResponse;

  GetOtpResponse({
    required this.status,
    required this.message,
    required this.result,
    this.smsResponse,
  });

  factory GetOtpResponse.fromRawJson(String str) =>
      GetOtpResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetOtpResponse.fromJson(Map<String, dynamic> json) => GetOtpResponse(
    status: json["status"] ?? "",
    message: json["message"] ?? "",
    result: json["result"] ?? "",
    smsResponse: json["smsResponse"] != null
        ? SmsResponse.fromJson(json["smsResponse"])
        : null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "result": result,
    "smsResponse": smsResponse?.toJson(),
  };
}

class SmsResponse {
  final bool? status;
  final String? msg;

  SmsResponse({required this.status, required this.msg});

  factory SmsResponse.fromJson(Map<String, dynamic> json) => SmsResponse(
    status: json["status"] ?? false,
    msg: json["msg"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
  };
}