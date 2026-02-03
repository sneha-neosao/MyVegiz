class ProfileDetailsResponse {
  final String status;
  final String? message;
  final UserProfileResult result;

  ProfileDetailsResponse({
    required this.status,
    this.message,
    required this.result,
  });

  factory ProfileDetailsResponse.fromJson(Map<String, dynamic> json) {
    return ProfileDetailsResponse(
      status: json['status'] ?? '',
      message: json["message"],
      result: UserProfileResult.fromJson(json['result']),
    );
  }
}

class UserProfileResult {
  final UserProfile userProfile;

  UserProfileResult({required this.userProfile});

  factory UserProfileResult.fromJson(Map<String, dynamic> json) {
    return UserProfileResult(
      userProfile: UserProfile.fromJson(json['userProfile']),
    );
  }
}

class UserProfile {
  final String code;
  final String name;
  final String emailId;
  final String mobile;
  final String cityCode;
  final String cartCode;
  final String isCodEnabled;
  final String? gender;
  final String address;
  final String latitude;
  final String longitude;
  final String areaCode;
  final String addressType;
  final String? area;
  final String? local;
  final String flat;
  final String? pincode;
  final String? state;
  final String? landmark;
  final String city;

  UserProfile({
    required this.code,
    required this.name,
    required this.emailId,
    required this.mobile,
    required this.cityCode,
    required this.cartCode,
    required this.isCodEnabled,
    this.gender,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.areaCode,
    required this.addressType,
    this.area,
    this.local,
    required this.flat,
    this.pincode,
    this.state,
    this.landmark,
    required this.city,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      code: json['code'] ?? '',
      name: json['name'] ?? '',
      emailId: json['emailId'] ?? '',
      mobile: json['mobile'] ?? '',
      cityCode: json['cityCode'] ?? '',
      cartCode: json['cartCode'] ?? '',
      isCodEnabled: json['isCodEnabled'] ?? '',
      gender: json['gender'],
      address: json['address'] ?? '',
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
      areaCode: json['areaCode'] ?? '',
      addressType: json['addressType'] ?? '',
      area: json['area'],
      local: json['local'],
      flat: json['flat'] ?? '',
      pincode: json['pincode'],
      state: json['state'],
      landmark: json['landmark'],
      city: json['city'] ?? '',
    );
  }
}
