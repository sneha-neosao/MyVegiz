import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:myvegiz_flutter/src/features/login/domain/usecase/get_otp_usecase.dart';
import 'injector.dart';

final getIt = GetIt.I;

/// Configures all dependencies (Blocs, UseCases, Repositories, Services, API helpers)
void configureDepedencies() {

  /// App Essentials

  getIt.registerLazySingleton<InternetConnectionChecker>(
        () => InternetConnectionChecker.createInstance(),
  );

  getIt.registerLazySingleton(
        () => ThemeBloc(),
  );

  getIt.registerLazySingleton(
        () => TranslateBloc(),
  );

  getIt.registerLazySingleton(
        () => AppRouteConf(),
  );

  // getIt.registerFactory(
  //       () => BottomNavFourBloc(),
  // );

  getIt.registerFactory(
        () => SplashBloc(),
  );

  /// Other API Configuration

  getIt.registerFactory(
        () => SignInBloc(getIt<GetOtpUseCase>()),
  );
  getIt.registerFactory(
        () => GetOtpUseCase(getIt<AuthRepositoryImpl>()),
  );
  getIt.registerFactory(
        () => GetOtpFormBloc(),
  );

  
  
  /// API Helper

  getIt.registerLazySingleton(
        () => NetworkInfo(),
  );

  getIt.registerLazySingleton(
        () =>
        AuthRepositoryImpl(getIt<RemoteDataSourceImpl>(), getIt<NetworkInfo>()),
  );

  getIt.registerLazySingleton(
        () => RemoteDataSourceImpl(getIt<ApiHelper>()),
  );

  getIt.registerLazySingleton(
        () => ApiHelper(getIt<Dio>(),),
  );

  getIt.registerLazySingleton(
        () =>
    Dio()
      ..interceptors.add(getIt<ApiInterceptor>(),),
  );

  getIt.registerLazySingleton(
        () => ApiInterceptor(),
  );
}