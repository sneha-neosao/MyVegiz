import 'package:dio/dio.dart';
import '../../core/api/api_exception.dart';
import '../../core/api/api_helper.dart';
import '../../core/api/api_url.dart';
import '../../core/constants/error_message.dart';
import '../../core/errors/exceptions.dart';
import '../../core/utils/logger.dart';

sealed class RemoteDataSource {
  // Future<LoginResponse> login(LoginParams params);

  Future<void> logout();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final ApiHelper? _helper;

  const RemoteDataSourceImpl(this._helper,);

  // @override
  // Future<LoginResponse> login(LoginParams params) async {
  //   try {
  //     var data = { "company_code": params.company_code,"email": params.email, "password": params.password,};
  //
  //     final response = await _superAdminHelper.execute(
  //         method: Method.post, url: ApiUrl.login, data: data);
  //
  //     logger.d('📨 Raw API response:');
  //     logger.d(response);
  //
  //     final user = LoginResponse.fromJson(response);
  //     return user;
  //   } on EmptyException {
  //     throw AuthException();
  //   } catch (e) {
  //     logger.e(e);
  //     if (e.toString() == noElement) {
  //       throw AuthException();
  //     }
  //     if (e is ApiException) {
  //       throw e; // rethrow as-is
  //     }
  //     throw ServerException();
  //     // throw here i want to pass same exception which is send by catch();
  //   }
  // }

  @override
  Future<void> logout() {
    throw UnimplementedError();
  }
}
