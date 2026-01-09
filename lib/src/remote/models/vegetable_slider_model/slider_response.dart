import 'dart:convert';

class VegetableSliderResponse {
  final String status;
  final String message;
  final SliderResult? result;

  VegetableSliderResponse({
    required this.status,
    required this.message,
    required this.result,
  });

  factory VegetableSliderResponse.fromRawJson(String str) =>
      VegetableSliderResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VegetableSliderResponse.fromJson(Map<String, dynamic> json) =>
      VegetableSliderResponse(
        status: json["status"] ?? "",
        message: json["message"] ?? "",
        result: json["result"] != null
            ? SliderResult.fromJson(json["result"])
            : null,
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "result": result?.toJson(),
  };
}

class SliderResult {
  final List<VegetableImage> sliderImages;

  SliderResult({required this.sliderImages});

  factory SliderResult.fromJson(Map<String, dynamic> json) =>
      SliderResult(
        sliderImages: json["sliderImages"] != null
            ? List<VegetableImage>.from(
            json["sliderImages"].map((x) => VegetableImage.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
    "sliderImages": List<dynamic>.from(sliderImages.map((x) => x.toJson())),
  };
}

class VegetableImage {
  final String imagePath;
  final String type;

  VegetableImage({
    required this.imagePath,
    required this.type,
  });

  factory VegetableImage.fromJson(Map<String, dynamic> json) => VegetableImage(
    imagePath: json["imagePath"] ?? "",
    type: json["type"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "imagePath": imagePath,
    "type": type,
  };
}
