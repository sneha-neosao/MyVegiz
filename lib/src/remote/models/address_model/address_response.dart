class AddressResponse {
  final String status;
  final String? message;
  final AddressData? result;

  AddressResponse({required this.status, this.message, this.result});

  factory AddressResponse.fromJson(Map<String, dynamic> json) {
    return AddressResponse(
      status: json['status'] ?? '',
      message: json['message'],
      result: json['result'] != null
          ? AddressData.fromJson(json['result'])
          : null,
    );
  }
}

class AddressData {
  final List<AddressResult> addresses;

  AddressData({required this.addresses});

  factory AddressData.fromJson(Map<String, dynamic> json) {
    return AddressData(
      addresses: json['addresses'] != null
          ? (json['addresses'] as List)
                .map((e) => AddressResult.fromJson(e))
                .toList()
          : [],
    );
  }
}

class AddressResult {
  final String id;
  final String city;
  final String area;
  final String address;
  final String latitude;
  final String longitude;
  final String cityCode;
  final String areaCode;
  final String addressType;
  final String flat;
  final String directionToReach;
  final String landMark;
  final String isSelected;
  final String state;
  final String pincode;
  final String country;

  AddressResult({
    required this.id,
    required this.city,
    required this.area,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.cityCode,
    required this.areaCode,
    required this.addressType,
    required this.flat,
    required this.directionToReach,
    required this.landMark,
    required this.isSelected,
    required this.state,
    required this.pincode,
    required this.country,
  });

  factory AddressResult.fromJson(Map<String, dynamic> json) {
    return AddressResult(
      id: json['id'] ?? '',
      city: json['city'] ?? '',
      area: json['area'] ?? '',
      address: json['address'] ?? '',
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
      cityCode: json['cityCode'] ?? '',
      areaCode: json['areaCode'] ?? '',
      addressType: json['addressType'] ?? '',
      flat: json['flat'] ?? '',
      directionToReach: json['directionToReach'] ?? '',
      landMark: json['landMark'] ?? '',
      isSelected: json['isSelected'] ?? '',
      state: json['state'] ?? '',
      pincode: json['pincode'] ?? '',
      country: json['country'] ?? '',
    );
  }
}
