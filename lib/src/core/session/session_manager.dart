import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:myvegiz_flutter/src/core/errors/failures.dart';
import 'package:myvegiz_flutter/src/core/utils/failure_converter.dart';
import 'package:myvegiz_flutter/src/remote/models/user_model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// session for managing the data locally
class SessionManager {

  static Future<bool> checkIsKeyPresent(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  static saveLoginStatus(bool isLoggedIn) async {
    final prefs =await SharedPreferences.getInstance();
    prefs.setBool("isLoggedIn", isLoggedIn);
  }
  static Future<bool?> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isLoggedIn");
  }

  static Future<dynamic> saveUserSessionInfo(value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("userInfo", json.encode(value.toJson()));
  }

  static getUserSessionInfo() async {
    final prefs = await SharedPreferences.getInstance();
    return UserModel.fromJson(json.decode(prefs.getString("userInfo")!));
  }

  static saveFirebaseToken(String? firebasetoken) async {
    final prefs =await SharedPreferences.getInstance();
    prefs.setString("firebasetoken", firebasetoken!);
  }

  static Future<String?> getFirebaseToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("firebasetoken");
  }

  /// Save live location (lat, lng, address)
  static Future<void> saveLiveLocation({
    required double latitude,
    required double longitude,
    required String address,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("latitude", latitude.toString());
    await prefs.setString("longitude", longitude.toString());
    await prefs.setString("address", address); }

  /// Get saved live location
  static Future<({double? lat, double? lng, String? address})> getLiveLocation() async {
    final prefs = await SharedPreferences.getInstance();
    final latStr = prefs.getString("latitude");
    final lngStr = prefs.getString("longitude");
    final address = prefs.getString("address");
    return (
    lat: latStr != null ? double.tryParse(latStr) : null,
    lng: lngStr != null ? double.tryParse(lngStr) : null,
    address: address );
  }

  static Future<Either<Failure, void>> clear() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if(await preferences.clear())
      {
       return Right(true);
      }
    else{
      return Left(ServerFailure(mapFailureToMessage(ServerFailure(""))));
    }
  }
}