import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:myvegiz_flutter/src/configs/injector/injector.dart';
import 'package:myvegiz_flutter/src/features/widgets/app_snackbar_widget.dart';
import '../../../../../src/core/themes/app_color.dart';
import '../../../../../src/routes/app_route_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../src/configs/injector/injector_conf.dart';
import '../../../../../src/core/extensions/integer_sizedbox_extension.dart';
import '../../../../../src/features/splash/bloc/splash_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<SignInBloc>()..add(AuthCheckLoginStatusEvent()),
        ),
        BlocProvider(
          create: (_) => getIt<SplashBloc>(),
        ),
      ],
      child: BlocListener<SignInBloc, SignInState>(
        listenWhen: (_, current) =>
        current is AuthCheckLoginStatusSuccessState || current is AuthCheckLoginStatusFailureState,
        listener: (_, state) {
          Future.delayed(const Duration(milliseconds: 2000), () {
            if (!mounted) return; // ✅ Prevent unsafe context usage

            SystemChrome.setEnabledSystemUIMode(
              SystemUiMode.edgeToEdge, // or manual overlays
              overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
            );

            if (state is AuthCheckLoginStatusSuccessState) {
              context.pushNamed(AppRoute.homeContentScreen.name);
            } else {
              context.pushNamed(AppRoute.loginScreen.name);
            }
          });
        },
        child: BlocBuilder<SplashBloc, SplashState>(
          builder: (_, state) {
            return Scaffold(
              body:
              Image.asset(
                'assets/images/splash_screen.png',
                fit: BoxFit.fill,
                width: double.infinity,
                height: double.infinity,
              ),
            );
          },
        ),
      ),
    );
  }
}

