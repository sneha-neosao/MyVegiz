import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
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
        pageBuilder: (context, state) => _fadePage(const OtpVerificationScreen()),
      ),

      GoRoute(
        path: AppRoute.homeScreen.path,
        name: AppRoute.homeScreen.name,
        pageBuilder: (context, state) => _fadePage(const HomeScreen()),
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
