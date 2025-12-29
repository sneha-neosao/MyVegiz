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
    // redirect: (context, state) {
    //   final uri = state.uri;
    //   // 👇 Detect your auth redirect
    //   if (uri.scheme == "engagerewardauth") {
    //     // Send to a handler route instead of splash
    //     final code = uri.queryParameters['code'];
    //     // redirect to /auth-callback route, passing code as query param
    //     return "/auth-callback?code=$code";
    //   }
    //   return null; // default, stay on splash
    // },

    /// Each GoRoute defines a route path, name, and a page builder
    routes: [
      // GoRoute(
      //   path: AppRoute.splash.path,
      //   name: AppRoute.splash.name,
      //   pageBuilder: (context, state) => _fadePage(const SplashScreen()),
      // ),
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
