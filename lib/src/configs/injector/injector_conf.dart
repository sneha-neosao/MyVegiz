import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:myvegiz_flutter/src/features/home/domain/usecase/home_slider_usecase.dart';
import 'package:myvegiz_flutter/src/features/login/domain/usecase/get_otp_usecase.dart';
import 'package:myvegiz_flutter/src/features/login/domain/usecase/verify_otp_usecase.dart';
import 'package:myvegiz_flutter/src/features/myAccount/domain/usecase/account_delete_usecase.dart';
import 'package:myvegiz_flutter/src/features/myAccount/domain/usecase/edit_profile_usecase.dart';
import 'package:myvegiz_flutter/src/features/common/domain/usecase/city_list_usecase.dart';
import 'package:myvegiz_flutter/src/features/myAccount/domain/usecase/profile_details_usecase.dart';
import 'package:myvegiz_flutter/src/features/myAccount/domain/usecase/wish_list_usecase.dart';
import 'package:myvegiz_flutter/src/features/register/domain/usecase/registeration_usecase.dart';
import 'package:myvegiz_flutter/src/features/vegetablesAndGrocery/domain/usecase/add_to_wishlist_usecase.dart';
import 'package:myvegiz_flutter/src/features/vegetablesAndGrocery/domain/usecase/category_and_product_usecase.dart';
import 'package:myvegiz_flutter/src/features/vegetablesAndGrocery/domain/usecase/category_usecase.dart';
import 'package:myvegiz_flutter/src/features/vegetablesAndGrocery/domain/usecase/product_by_category_usecase.dart';
import 'package:myvegiz_flutter/src/features/vegetablesAndGrocery/domain/usecase/slider_usecase.dart';
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
        () => SliderBloc(getIt<SliderUseCase>()),
  );
  getIt.registerFactory(
        () => SliderUseCase(getIt<AuthRepositoryImpl>()),
  );

  getIt.registerFactory(
        () => CategoryBloc(getIt<CategoryUseCase>()),
  );
  getIt.registerFactory(
        () => CategoryUseCase(getIt<AuthRepositoryImpl>()),
  );

  getIt.registerFactory(
        () => CategoryAndProductBloc(getIt<CategoryAndProductUseCase>()),
  );
  getIt.registerFactory(
        () => CategoryAndProductUseCase(getIt<AuthRepositoryImpl>()),
  );

  getIt.registerFactory(
        () => EditProfileBloc(getIt<EditProfileUseCase>()),
  );
  getIt.registerFactory(
        () => EditProfileUseCase(getIt<AuthRepositoryImpl>()),
  );
  getIt.registerFactory(
        () => EditProfileFormBloc(),
  );

  getIt.registerFactory(
        () => ProductByCategoryBloc(getIt<ProductByCategoryUseCase>()),
  );
  getIt.registerFactory(
        () => ProductByCategoryUseCase(getIt<AuthRepositoryImpl>()),
  );

  getIt.registerFactory(
        () => AddToWishListBloc(getIt<AddToWishListUseCase>()),
  );
  getIt.registerFactory(
        () => AddToWishListUseCase(getIt<AuthRepositoryImpl>()),
  );

  getIt.registerFactory(
        () => WishListBloc(getIt<WishListUseCase>()),
  );
  getIt.registerFactory(
        () => WishListUseCase(getIt<AuthRepositoryImpl>()),
  );

  getIt.registerFactory(
        () => ProfileDetailsBloc(getIt<ProfileDetailsUseCase>()),
  );
  getIt.registerFactory(
        () => ProfileDetailsUseCase(getIt<AuthRepositoryImpl>()),
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