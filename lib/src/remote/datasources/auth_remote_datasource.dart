import 'package:myvegiz_flutter/src/features/login/domain/usecase/get_otp_usecase.dart';
import 'package:myvegiz_flutter/src/features/login/domain/usecase/verify_otp_usecase.dart';
import 'package:myvegiz_flutter/src/features/myAccount/domain/usecase/account_delete_usecase.dart';
import 'package:myvegiz_flutter/src/features/register/domain/usecase/registeration_usecase.dart';
import 'package:myvegiz_flutter/src/features/vegetablesAndGrocery/domain/usecase/category_and_product_usecase.dart';
import 'package:myvegiz_flutter/src/features/vegetablesAndGrocery/domain/usecase/category_usecase.dart';
import 'package:myvegiz_flutter/src/features/vegetablesAndGrocery/domain/usecase/slider_usecase.dart';
import 'package:myvegiz_flutter/src/remote/models/auth_models/get_otp_response.dart';
import 'package:myvegiz_flutter/src/remote/models/auth_models/otp_verify_response.dart';
import 'package:myvegiz_flutter/src/remote/models/category_and_product_model/category_and_product_response.dart';
import 'package:myvegiz_flutter/src/remote/models/city_model/city_list_response.dart';
import 'package:myvegiz_flutter/src/remote/models/common_response.dart';
import 'package:myvegiz_flutter/src/remote/models/home_slider_model/home_slider_response.dart';
import 'package:myvegiz_flutter/src/remote/models/registration_model/registration_response.dart';
import 'package:myvegiz_flutter/src/remote/models/slider_model/slider_response.dart';
import 'package:myvegiz_flutter/src/remote/models/category_model/category_response.dart';
import '../../core/api/api_exception.dart';
import '../../core/api/api_helper.dart';
import '../../core/api/api_url.dart';
import '../../core/constants/error_message.dart';
import '../../core/errors/exceptions.dart';
import '../../core/utils/logger.dart';

sealed class RemoteDataSource {
  /// Authentication
  Future<GetOtpResponse> getOtp(GetOtpParams params);
  Future<OtpVerifyResponse> verifyOtp(VerifyOtpParams params);
  Future<RegistrationResponse> registration(RegistrationParams params);

  /// Home Slider
  Future<HomeSliderResponse> homeSlider();

  /// City List
  Future<CityListResponse> cityList();

  /// Account Delete
  Future<CommonResponse> accountDelete(AccountDeleteParams params);

  /// Slider
  Future<SliderResponse> slider(SliderParams params);

  /// Category
  Future<CategoryResponse> category(CategoryParams params);

  /// Category And Product
  Future<CategoryAndProductResponse> categoryAndProduct(CategoryAndProductParams params);
  Future<void> logout();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final ApiHelper _helper;

  const RemoteDataSourceImpl(this._helper,);

  @override
  Future<GetOtpResponse> getOtp(GetOtpParams params) async {
    try {
      var data = {
        "contactNumber": params.contactNumber,
        "resend": params.resend,
      };

      final response = await _helper.execute(
        method: Method.post,
        url: ApiUrl.getOtp,
        data: data,
      );

      // logger.d('📨 Raw API response:');
      // logger.d(response);

      final user = GetOtpResponse.fromJson(response);
      return user;
    } on EmptyException {
      throw AuthException();
    } catch (e) {
      logger.e(e);
      if (e.toString() == noElement) {
        throw AuthException();
      }
      if (e is ApiException) {
        throw e; // rethrow as-is
      }
      throw ServerException();
      // throw here i want to pass same exception which is send by catch();
    }
  }

  @override
  Future<OtpVerifyResponse> verifyOtp(VerifyOtpParams params) async {
    try {
      var data = {
        "contactNumber": params.contactNumber,
      };

      final response = await _helper.execute(
        method: Method.post,
        url: ApiUrl.verifyOtp,
        data: data,
      );

      // logger.d('📨 Raw API response:');
      // logger.d(response);

      final user = OtpVerifyResponse.fromJson(response);
      return user;
    } on EmptyException {
      throw AuthException();
    } catch (e) {
      logger.e(e);
      if (e.toString() == noElement) {
        throw AuthException();
      }
      if (e is ApiException) {
        throw e; // rethrow as-is
      }
      throw ServerException();
      // throw here i want to pass same exception which is send by catch();
    }
  }

  @override
  Future<RegistrationResponse> registration(RegistrationParams params) async {
    try {
      var data = {
        "name": params.name,
        "contactNumber": params.contactNumber,
        "emailId": params.emailId,
        "cityCode": params.cityCode
      };

      final response = await _helper.execute(
        method: Method.post,
        url: ApiUrl.registration,
        data: data,
      );

      // logger.d('📨 Raw API response:');
      // logger.d(response);

      final user = RegistrationResponse.fromJson(response);
      return user;
    } on EmptyException {
      throw AuthException();
    } catch (e) {
      logger.e(e);
      if (e.toString() == noElement) {
        throw AuthException();
      }
      if (e is ApiException) {
        throw e; // rethrow as-is
      }
      throw ServerException();
      // throw here i want to pass same exception which is send by catch();
    }
  }

  @override
  Future<HomeSliderResponse> homeSlider() async {
    try {

      final response = await _helper.execute(
        method: Method.get,
        url: ApiUrl.homeSliderImages,
      );

      // logger.d('📨 Raw API response:');
      // logger.d(response);

      final user = HomeSliderResponse.fromJson(response);
      return user;
    } on EmptyException {
      throw AuthException();
    } catch (e) {
      logger.e(e);
      if (e.toString() == noElement) {
        throw AuthException();
      }
      if (e is ApiException) {
        throw e; // rethrow as-is
      }
      throw ServerException();
      // throw here i want to pass same exception which is send by catch();
    }
  }

  @override
  Future<CityListResponse> cityList() async {
    try {

      final response = await _helper.execute(
        method: Method.get,
        url: ApiUrl.cityList,
      );

      // logger.d('📨 Raw API response:');
      // logger.d(response);

      final user = CityListResponse.fromJson(response);
      return user;
    } on EmptyException {
      throw AuthException();
    } catch (e) {
      logger.e(e);
      if (e.toString() == noElement) {
        throw AuthException();
      }
      if (e is ApiException) {
        throw e; // rethrow as-is
      }
      throw ServerException();
      // throw here i want to pass same exception which is send by catch();
    }
  }

  @override
  Future<CommonResponse> accountDelete(AccountDeleteParams params) async {
    try {

      var data = {
        "clientCode": params.clientCode,
      };

      final response = await _helper.execute(
        method: Method.post,
        url: ApiUrl.accountDelete,
        data: data
      );

      // logger.d('📨 Raw API response:');
      // logger.d(response);

      final user = CommonResponse.fromJson(response);
      return user;
    } on EmptyException {
      throw AuthException();
    } catch (e) {
      logger.e(e);
      if (e.toString() == noElement) {
        throw AuthException();
      }
      if (e is ApiException) {
        throw e; // rethrow as-is
      }
      throw ServerException();
      // throw here i want to pass same exception which is send by catch();
    }
  }

  @override
  Future<SliderResponse> slider(SliderParams params) async {
    try {

      var data = {
        "cityCode": params.cityCode,
        "mainCategoryCode": params.mainCategoryCode
      };

      final response = await _helper.execute(
        method: Method.post,
        url: ApiUrl.sliderImages,
        data: data
      );

      // logger.d('📨 Raw API response:');
      // logger.d(response);

      final user = SliderResponse.fromJson(response);
      return user;
    } on EmptyException {
      throw AuthException();
    } catch (e) {
      logger.e(e);
      if (e.toString() == noElement) {
        throw AuthException();
      }
      if (e is ApiException) {
        throw e; // rethrow as-is
      }
      throw ServerException();
      // throw here i want to pass same exception which is send by catch();
    }
  }

  @override
  Future<CategoryResponse> category(CategoryParams params) async {
    try {

      var data = {
        "offset": params.offset,
        "mainCategoryCode": params.mainCategoryCode
      };

      final response = await _helper.execute(
          method: Method.post,
          url: ApiUrl.categoriesList,
          data: data
      );

      // logger.d('📨 Raw API response:');
      // logger.d(response);

      final user = CategoryResponse.fromJson(response);
      return user;
    } on EmptyException {
      throw AuthException();
    } catch (e) {
      logger.e(e);
      if (e.toString() == noElement) {
        throw AuthException();
      }
      if (e is ApiException) {
        throw e; // rethrow as-is
      }
      throw ServerException();
      // throw here i want to pass same exception which is send by catch();
    }
  }

  @override
  Future<CategoryAndProductResponse> categoryAndProduct(CategoryAndProductParams params) async {
    try {

      var data = {
        "cityCode": params.cityCode,
        "offset": params.offset,
        "mainCategoryCode": params.mainCategoryCode
      };

      final response = await _helper.execute(
          method: Method.post,
          url: ApiUrl.productCategoryList,
          data: data
      );

      logger.d('📨 Raw API response:');
      logger.d(response);

      final user = CategoryAndProductResponse.fromJson(response);
      return user;
    } on EmptyException {
      throw AuthException();
    } catch (e) {
      logger.e(e);
      if (e.toString() == noElement) {
        throw AuthException();
      }
      if (e is ApiException) {
        throw e; // rethrow as-is
      }
      throw ServerException();
      // throw here i want to pass same exception which is send by catch();
    }
  }

  @override
  Future<void> logout() {
    throw UnimplementedError();
  }
}
