import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// session for managing the data locally
class SessionManager {

  // static Future<bool> checkIsKeyPresent(String key) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.containsKey(key);
  // }
  //
  // static saveLoginStatus(bool isLoggedIn) async {
  //   final prefs =await SharedPreferences.getInstance();
  //   prefs.setBool("isLoggedIn", isLoggedIn);
  // }
  //
  // static saveSessionId(String token) async {
  //   final prefs =await SharedPreferences.getInstance();
  //   prefs.setString("token", token);
  // }
  //
  // static Future<dynamic> saveUserSessionInfo(value) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setString("userInfo", json.encode(value.toJson()));
  // }
  //
  // static saveInvitationCode(String code) async {
  //   final prefs =await SharedPreferences.getInstance();
  //   prefs.setString("invitationCode", code);
  // }
  //
  // static saveFirebaseToken(String? firebasetoken) async {
  //   final prefs =await SharedPreferences.getInstance();
  //   prefs.setString("firebasetoken", firebasetoken!);
  // }
  //
  // static Future<bool?> isLoggedIn() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getBool("isLoggedIn");
  // }
  //
  // static Future<void> saveBaseUrl(String baseUrl) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setString("baseUrl", baseUrl);
  // }
  //
  // static getUserSessionInfo() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return LoginResult.fromJson(json.decode(prefs.getString("userInfo")!));
  // }
  //
  //
  // static Future<String?> getAuthToken() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString("token");
  // }
  //
  //
  // static Future<String?> getInvitationCode() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString("invitationCode");
  // }
  //
  // static Future<String?> getFirebaseToken() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString("firebasetoken");
  // }
  //
  // static Future<Either<Failure, void>> clear() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   if(await preferences.clear())
  //     {
  //      return Right(true);
  //     }
  //   else{
  //     return Left(ServerFailure(mapFailureToMessage(ServerFailure(""))));
  //   }
  // }
  //
  // static saveTwitterVerifier(String verifier) async {
  //   final prefs =await SharedPreferences.getInstance();
  //   prefs.setString("twitterVerifier", verifier);
  // }
  //
  // static Future<String?> getTwitterVerifier() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString("twitterVerifier");
  // }
  //
  // static Future<String> getBaseUrl() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final baseUrl = prefs.getString("baseUrl");
  //   if (baseUrl == null) {
  //     return "";
  //   }
  //   return baseUrl;
  // }
  //
  // /// 🚨 Force logout: clear session and navigate to login
  // static Future<void> forceLogout(BuildContext context) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.clear();
  //
  //   // Navigate to login page using go_router
  //   GoRouter.of(context).go(AppRoute.login.path);
  // }
}