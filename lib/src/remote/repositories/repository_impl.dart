import 'package:easy_localization/easy_localization.dart';
import 'package:fpdart/fpdart.dart';
import 'package:myvegiz_flutter/src/core/api/api_exception.dart';
import 'package:myvegiz_flutter/src/core/errors/exceptions.dart';
import 'package:myvegiz_flutter/src/core/errors/failures.dart';
import 'package:myvegiz_flutter/src/core/network/network_checker.dart';
import 'package:myvegiz_flutter/src/core/usecases/usecase.dart';
import 'package:myvegiz_flutter/src/core/utils/failure_converter.dart';
import 'package:myvegiz_flutter/src/features/login/domain/usecase/get_otp_usecase.dart';
import 'package:myvegiz_flutter/src/features/login/domain/usecase/verify_otp_usecase.dart';
import 'package:myvegiz_flutter/src/remote/datasources/auth_remote_datasource.dart';
import 'package:myvegiz_flutter/src/remote/models/auth_models/get_otp_response.dart';
import 'package:myvegiz_flutter/src/remote/models/auth_models/otp_verify_response.dart';
import 'package:myvegiz_flutter/src/remote/models/home_slider_model/home_slider_response.dart';
import '../../configs/injector/injector_conf.dart';
import '../../core/api/api_url.dart';

/// Abstract Repository interface defining all data operations for the app

abstract class Repository {

  /// Authentication
  Future<Either<Failure, GetOtpResponse>> get_otp(GetOtpParams params);
  Future<Either<Failure, OtpVerifyResponse>> verify_otp(VerifyOtpParams params);

  /// Home Slider
  Future<Either<Failure, HomeSliderResponse>> home_slider(NoParams params);

}

/// Implements Repository to handle authentication and user-related remote operations.

class AuthRepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  const AuthRepositoryImpl(
    this._remoteDataSource,
    this._networkInfo,
  );

  @override
  Future<Either<Failure, GetOtpResponse>> get_otp(GetOtpParams params) {
    return _networkInfo.check<GetOtpResponse>(
      connected: () async {
        try {
          final respData = await _remoteDataSource.getOtp(params);

          if (respData.status == "200") {
            return Right(respData);
          } else {
            return Left(ApiFailure(respData.message!));
          }
        } on ServerException {
          return Left(ServerFailure(mapFailureToMessage(ServerFailure(""))));
        } catch (e) {
          if (e is ApiException) {
            return Left(ApiFailure(e.message)); // rethrow as-is
          }
          return Left(ServerFailure(mapFailureToMessage(ServerFailure(""))));
        }
      },
      notConnected: () async {
        try {
          return Left(
              InternetFailure("please_check_your_internet_connection".tr()));
        } on CacheException {
          return Left(CacheFailure(mapFailureToMessage(CacheFailure(""))));
        }
      },
    );
  }

  @override
  Future<Either<Failure, OtpVerifyResponse>> verify_otp(VerifyOtpParams params) {
    return _networkInfo.check<OtpVerifyResponse>(
      connected: () async {
        try {
          final respData = await _remoteDataSource.verifyOtp(params);

          if (respData.status == 200) {
            return Right(respData);
          } else {
            return Left(ApiFailure(respData.message!));
          }
        } on ServerException {
          return Left(ServerFailure(mapFailureToMessage(ServerFailure(""))));
        } catch (e) {
          if (e is ApiException) {
            return Left(ApiFailure(e.message)); // rethrow as-is
          }
          return Left(ServerFailure(mapFailureToMessage(ServerFailure(""))));
        }
      },
      notConnected: () async {
        try {
          return Left(
              InternetFailure("please_check_your_internet_connection".tr()));
        } on CacheException {
          return Left(CacheFailure(mapFailureToMessage(CacheFailure(""))));
        }
      },
    );
  }

  @override
  Future<Either<Failure, HomeSliderResponse>> home_slider(NoParams params) {
    return _networkInfo.check<HomeSliderResponse>(
      connected: () async {
        try {
          final respData = await _remoteDataSource.homeSlider();

          if (respData.status == "200") {
            return Right(respData);
          } else {
            return Left(ApiFailure(respData.message!));
          }
        } on ServerException {
          return Left(ServerFailure(mapFailureToMessage(ServerFailure(""))));
        } catch (e) {
          if (e is ApiException) {
            return Left(ApiFailure(e.message)); // rethrow as-is
          }
          return Left(ServerFailure(mapFailureToMessage(ServerFailure(""))));
        }
      },
      notConnected: () async {
        try {
          return Left(
              InternetFailure("please_check_your_internet_connection".tr()));
        } on CacheException {
          return Left(CacheFailure(mapFailureToMessage(CacheFailure(""))));
        }
      },
    );
  }
}
