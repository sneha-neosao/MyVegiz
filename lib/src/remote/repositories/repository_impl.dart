import 'package:easy_localization/easy_localization.dart';
import 'package:fpdart/fpdart.dart';
import 'package:myvegiz_flutter/src/core/network/network_checker.dart';
import 'package:myvegiz_flutter/src/remote/datasources/auth_remote_datasource.dart';
import '../../configs/injector/injector_conf.dart';
import '../../core/api/api_url.dart';

/// Abstract Repository interface defining all data operations for the app

abstract class Repository {
  // Future<Either<Failure, LoginResponse>> login(LoginParams params);
}

/// Implements Repository to handle authentication and user-related remote operations.

class AuthRepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  const AuthRepositoryImpl(
    this._remoteDataSource,
    this._networkInfo,
  );

  // @override
  // Future<Either<Failure, LoginResponse>> login(LoginParams params) async {
  //   try {
  //     final result = await _remoteDataSource.login(params);
  //     if (result.status != 200) {
  //       return Left(CredentialFailure(result.message!));
  //     }
  //
  //     SessionManager.saveLoginStatus(true);
  //     SessionManager.saveSessionId(result.data!.token);
  //     SessionManager.saveUserSessionInfo(result.data);
  //     await SessionManager.saveBaseUrl(result.baseUrl);
  //
  //     // Assume user.defaultBaseUrl is returned from API
  //     await configureDefaultApi(result.baseUrl);
  //
  //     return Right(result);
  //   } on AuthException {
  //     return Left(
  //         CredentialFailure(mapFailureToMessage(CredentialFailure(""))));
  //   } on ServerException {
  //     return Left(ServerFailure(mapFailureToMessage(ServerFailure(""))));
  //   } catch (e) {
  //     if (e is ApiException) {
  //       return Left(ApiFailure(e.message)); // rethrow as-is
  //     }
  //     return Left(ServerFailure(mapFailureToMessage(ServerFailure(""))));
  //   }
  // }

}
