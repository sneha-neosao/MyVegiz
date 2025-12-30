import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
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
        // BlocProvider(
        //   create: (_) => getIt<AuthLoginBloc>()..add(AuthCheckSignInStatusEvent()),
        // ),
        BlocProvider(
          create: (_) => getIt<SplashBloc>(),
        ),
      ],
      child: BlocBuilder<SplashBloc, SplashState>(
        builder: (_, state) {
          return Scaffold(
            body:
            GestureDetector(
              onDoubleTap: (){
                context.pushNamed(AppRoute.loginScreen.name);
              },
              child: Image.asset(
                'assets/images/splash_screen.png',
                fit: BoxFit.fill,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          );
        },
      ),
    );
  }
}

