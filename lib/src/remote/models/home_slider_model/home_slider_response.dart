import 'dart:convert';

class HomeSliderResponse {
  final String status;
  final String message;
  final HomeSliderResult? result;

  HomeSliderResponse({
    required this.status,
    required this.message,
    required this.result,
  });

  factory HomeSliderResponse.fromRawJson(String str) =>
      HomeSliderResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HomeSliderResponse.fromJson(Map<String, dynamic> json) =>
      HomeSliderResponse(
        status: json["status"] ?? "",
        message: json["message"] ?? "",
        result: json["result"] != null
            ? HomeSliderResult.fromJson(json["result"])
            : null,
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "result": result?.toJson(),
  };
}

/// Holds the list of home slider images
class HomeSliderResult {
  final List<HomeSliderImage> homesliderImages;

  HomeSliderResult({required this.homesliderImages});

  factory HomeSliderResult.fromJson(Map<String, dynamic> json) =>
      HomeSliderResult(
        homesliderImages: json["homesliderImages"] != null
            ? List<HomeSliderImage>.from(
            json["homesliderImages"].map((x) => HomeSliderImage.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
    "homesliderImages":
    List<dynamic>.from(homesliderImages.map((x) => x.toJson())),
  };
}

/// Each image item
class HomeSliderImage {
  final String imagePath;

  HomeSliderImage({required this.imagePath});

  factory HomeSliderImage.fromJson(Map<String, dynamic> json) =>
      HomeSliderImage(
        imagePath: json["imagePath"] ?? "",
      );

  Map<String, dynamic> toJson() => {
    "imagePath": imagePath,
  };
}
