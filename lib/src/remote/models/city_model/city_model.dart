class CityModel {
  final String? id;
  final String? code;
  final String? cityName;
  final String? isActive;
  final String? isDelete;
  final String? addID;
  final String? addIP;
  final String? addDate;
  final String? editIP;
  final String? editID;
  final String? editDate;
  final String? deleteID;
  final String? deleteIP;
  final String? deleteDate;
  final String? deliveryCharge;
  final String? minOrderCurrency;
  final String? minOrder;
  final String? deliveryChargeCurrency;
  final String? deliveryChargesPerKm;
  final String? minFreeDeliveryKm;
  final String? latitude;
  final String? longitude;

  CityModel({
    required this.id,
    required this.code,
    required this.cityName,
    required this.isActive,
    this.isDelete,
    required this.addID,
    required this.addIP,
    required this.addDate,
    this.editIP,
    this.editID,
    this.editDate,
    this.deleteID,
    this.deleteIP,
    this.deleteDate,
    required this.deliveryCharge,
    required this.minOrderCurrency,
    required this.minOrder,
    required this.deliveryChargeCurrency,
    required this.deliveryChargesPerKm,
    required this.minFreeDeliveryKm,
    this.latitude,
    this.longitude,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) =>
      CityModel(
        id: json["id"] ?? "",
        code: json["code"] ?? "",
        cityName: json["cityName"] ?? "",
        isActive: json["isActive"] ?? "",
        isDelete: json["isDelete"] ?? "",
        addID: json["addID"] ?? "",
        addIP: json["addIP"] ?? "",
        addDate: json["addDate"] ?? "",
        editIP: json["editIP"] ?? "",
        editID: json["editID"] ?? "",
        editDate: json["editDate"] ?? "",
        deleteID: json["deleteID"] ?? "",
        deleteIP: json["deleteIP"] ?? "",
        deleteDate: json["deleteDate"] ?? "",
        deliveryCharge: json["deliveryCharge"] ?? "",
        minOrderCurrency: json["minOrderCurrency"] ?? "",
        minOrder: json["minOrder"] ?? "",
        deliveryChargeCurrency: json["deliveryChargeCurrency"] ?? "",
        deliveryChargesPerKm: json["deliveryChargesPerKm"] ?? "",
        minFreeDeliveryKm: json["minFreeDeliveryKm"] ?? "",
        latitude: json["latitude"] ?? "",
        longitude: json["longitude"] ?? "",
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "code": code,
        "cityName": cityName,
        "isActive": isActive,
        "isDelete": isDelete,
        "addID": addID,
        "addIP": addIP,
        "addDate": addDate,
        "editIP": editIP,
        "editID": editID,
        "editDate": editDate,
        "deleteID": deleteID,
        "deleteIP": deleteIP,
        "deleteDate": deleteDate,
        "deliveryCharge": deliveryCharge,
        "minOrderCurrency": minOrderCurrency,
        "minOrder": minOrder,
        "deliveryChargeCurrency": deliveryChargeCurrency,
        "deliveryChargesPerKm": deliveryChargesPerKm,
        "minFreeDeliveryKm": minFreeDeliveryKm,
        "latitude": latitude,
        "longitude": longitude,
      };
}