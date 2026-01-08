import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:myvegiz_flutter/src/features/home/domain/usecase/home_slider_usecase.dart';
import 'package:myvegiz_flutter/src/features/login/domain/usecase/get_otp_usecase.dart';
import 'package:myvegiz_flutter/src/features/login/domain/usecase/verify_otp_usecase.dart';
import 'package:myvegiz_flutter/src/features/myAccount/domain/usecase/account_delete_usecase.dart';
import 'package:myvegiz_flutter/src/features/register/domain/usecase/city_list_usecase.dart';
import 'package:myvegiz_flutter/src/features/register/domain/usecase/registeration_usecase.dart';
import 'package:myvegiz_flutter/src/features/vegetablesAndGrocery/domain/usecase/vegetable_category_usecase.dart';
import 'package:myvegiz_flutter/src/features/vegetablesAndGrocery/domain/usecase/vegetable_slider_usecase.dart';
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
        () => SignInBloc(getIt<GetOtpUseCase>(),getIt<VerifyOtpUseCase>(),getIt<AccountDeleteUseCase>()),
  );
  getIt.registerFactory(
        () => GetOtpUseCase(getIt<AuthRepositoryImpl>()),
  );
  getIt.registerFactory(
        () => VerifyOtpUseCase(getIt<AuthRepositoryImpl>()),
  );
  getIt.registerFactory(
        () => AccountDeleteUseCase(getIt<AuthRepositoryImpl>()),
  );
  getIt.registerFactory(
        () => GetOtpFormBloc(),
  );

  getIt.registerFactory(
        () => HomeSliderBloc(getIt<HomeSliderUseCase>()),
  );
  getIt.registerFactory(
        () => HomeSliderUseCase(getIt<AuthRepositoryImpl>()),
  );

  getIt.registerFactory(
        () => CityListBloc(getIt<CityListUseCase>()),
  );
  getIt.registerFactory(
        () => CityListUseCase(getIt<AuthRepositoryImpl>()),
  );

  getIt.registerFactory(
        () => RegistrationBloc(getIt<RegistrationUseCase>()),
  );
  getIt.registerFactory(
        () => RegistrationUseCase(getIt<AuthRepositoryImpl>()),
  );
  getIt.registerFactory(
        () => RegistrationFormBloc(),
  );

  getIt.registerFactory(
        () => VegetableSliderBloc(getIt<VegetableSliderUseCase>()),
  );
  getIt.registerFactory(
        () => VegetableSliderUseCase(getIt<AuthRepositoryImpl>()),
  );

  getIt.registerFactory(
        () => VegetableCategoryBloc(getIt<VegetableCategoryUseCase>()),
  );
  getIt.registerFactory(
        () => VegetableCategoryUseCase(getIt<AuthRepositoryImpl>()),
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