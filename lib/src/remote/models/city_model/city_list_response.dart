import 'dart:convert';

import 'package:myvegiz_flutter/src/remote/models/city_model/city_model.dart';

/// Represents the API response for fetching cities.
class CityListResponse {
  final String status;
  final String? message;
  final CityResult? result;

  CityListResponse({
    required this.status,
    this.message,
    this.result,
  });

  factory CityListResponse.fromRawJson(String str) =>
      CityListResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CityListResponse.fromJson(Map<String, dynamic> json) =>
      CityListResponse(
        status: json["status"] ?? "",
        message: json["message"] ?? "",
        result: json["result"] != null
            ? CityResult.fromJson(json["result"])
            : null,
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "result": result?.toJson(),
  };
}

class CityResult {
  final List<CityModel> cities;

  CityResult({required this.cities});

  factory CityResult.fromJson(Map<String, dynamic> json) => CityResult(
    cities: json["cities"] == null
        ? []
        : List<CityModel>.from(json["cities"].map((x) => CityModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "cities": List<dynamic>.from(cities.map((x) => x.toJson())),
  };
}

