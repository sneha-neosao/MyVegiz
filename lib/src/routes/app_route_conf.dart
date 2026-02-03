import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'app_route_path.dart';
import 'routes.dart';

/// Class that configures all app routes using GoRouter
///
class AppRouteConf {
  GoRouter get router => _router;

  late final _router = GoRouter(
    initialLocation: "/",
    debugLogDiagnostics: true,
    /// Each GoRoute defines a route path, name, and a page builder
    routes: [
      GoRoute(
        path: AppRoute.splash.path,
        name: AppRoute.splash.name,
        pageBuilder: (context, state) => _fadePage(const SplashScreen()),
      ),

      GoRoute(
        path: AppRoute.loginScreen.path,
        name: AppRoute.loginScreen.name,
        pageBuilder: (context, state) => _fadePage(const LoginScreen()),
      ),

      GoRoute(
        path: AppRoute.otpVerificationScreen.path,
        name: AppRoute.otpVerificationScreen.name,
        pageBuilder: (context, state) {
          final contactNumber = state.extra as String;
          return _fadePage(
            OtpVerificationScreen(contactNumber: contactNumber),
          );
        },
      ),

      ShellRoute(
          builder: (context, state, child) {
            return HomeScreen(child: child,);
          },
          routes: [
            GoRoute(
              path: AppRoute.homeContentScreen.path,
              name: AppRoute.homeContentScreen.name,
              pageBuilder: (context, state) => _fadePage(const HomeContentScreen()),
            ),
            GoRoute(
              path: AppRoute.searchScreen.path,
              name: AppRoute.searchScreen.name,
              pageBuilder: (context, state) => _fadePage(const SearchScreen()),
            ),
            GoRoute(
              path: AppRoute.cartScreen.path,
              name: AppRoute.cartScreen.name,
              pageBuilder: (context, state) => _fadePage(const CartScreen()),
            ),
            GoRoute(
              path: AppRoute.myAccountScreen.path,
              name: AppRoute.myAccountScreen.name,
              pageBuilder: (context, state) => _fadePage(const MyAccountScreen()),
            ),
          ]
      ),

      GoRoute(
        path: AppRoute.editProfileScreen.path,
        name: AppRoute.editProfileScreen.name,
        pageBuilder: (context, state) => _fadePage(const EditProfileScreen()),
      ),

      GoRoute(
        path: AppRoute.myWishlistScreen.path,
        name: AppRoute.myWishlistScreen.name,
        pageBuilder: (context, state) {
          final extras = state.extra as Map<String, dynamic>;
          final cityCode = extras['cityCode'].toString();
          final clientcode = extras['clientcode'] ?? '';
          return _fadePage(
            MyWishListScreen(
              clientCode: clientcode,
              cityCode: cityCode,
            ),
          );
        },
      ),

      GoRoute(
        path: AppRoute.vegetablesAndGroceryScreen.path,
        name: AppRoute.vegetablesAndGroceryScreen.name,
        pageBuilder: (context, state) {
          final cityCode = state.extra as String ;
          return _fadePage( VegetablesAndGroceryScreen(cityCode: cityCode,));
        },
      ),

      GoRoute(
        path: AppRoute.registerScreen.path,
        name: AppRoute.registerScreen.name,
        pageBuilder: (context, state) => _fadePage(const RegisterScreen()),
      ),

      GoRoute(
        path: AppRoute.selectLocationScreen.path,
        name: AppRoute.selectLocationScreen.name,
        pageBuilder: (context, state) => _fadePage(const SelectLocationScreen()),
      ),

      GoRoute(
        path: AppRoute.confirmLocationScreen.path,
        name: AppRoute.confirmLocationScreen.name,
        pageBuilder: (context, state) {
          final latLng = state.extra as LatLng?;
          return _fadePage(
            ConfirmLocationScreen(initialLatLng: latLng),
          );
        },
      ),

      GoRoute(
        path: AppRoute.vegetableProductListScreen.path,
        name: AppRoute.vegetableProductListScreen.name,
        pageBuilder: (context, state) {
          final extras = state.extra as Map<String, dynamic>;
          final cityCode = extras['cityCode'].toString();
          final categorySName = extras['categorySName'] ?? '';
          return _fadePage(
            VegetablesProductList(
              cityCode: cityCode,
              categorySName: categorySName,
            ),
          );
        },
      ),

    ],
  );
}

/// Fade transition page helper

CustomTransitionPage _fadePage(Widget child) => CustomTransitionPage(
      transitionDuration: const Duration(milliseconds: 800),
      // Duration of the animation
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut, // Smooth in-out fade
        );

        return FadeTransition(
          opacity: curvedAnimation,
          child: child,
        );
      },
    );

/// Slide transition page helper (optional usage)

CustomTransitionPage _slidePage(Widget child) => CustomTransitionPage(
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final offsetAnimation = Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(animation);

        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
