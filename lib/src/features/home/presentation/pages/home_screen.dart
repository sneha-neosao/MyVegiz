import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:myvegiz_flutter/src/configs/injector/injector.dart';
import 'package:myvegiz_flutter/src/configs/injector/injector_conf.dart';
import 'package:myvegiz_flutter/src/core/extensions/integer_sizedbox_extension.dart';
import 'package:myvegiz_flutter/src/core/session/session_manager.dart';
import 'package:myvegiz_flutter/src/core/themes/app_color.dart';
import 'package:myvegiz_flutter/src/routes/app_route_path.dart';

class HomeScreen extends StatefulWidget {
  final Widget child;

  const HomeScreen({super.key, required this.child});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadClientCode();
  }

  void _loadClientCode() async{
    final clientcode = await SessionManager.getClientCode();
    context.read<CartCountBloc>().add(CartCountGetEvent(clientcode!));
  }

  // Define the tab routes
  final tabs = [
    AppRoute.homeContentScreen,
    AppRoute.searchScreen,
    AppRoute.cartScreen,
    AppRoute.myAccountScreen,
  ];

  @override
  Widget build(BuildContext context) {
    // Get current location from GoRouter
    final location = GoRouterState.of(context).uri.toString();

    // Match current index based on location
    int currentIndex = tabs.indexWhere((route) => location.startsWith(route.path));
    if (currentIndex == -1) currentIndex = 0; // Default to HomeContentScreen

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<CartCountBloc>())
      ],
      child: Scaffold(
        body: widget.child, // ShellRoute injects child here
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            context.goNamed(tabs[index].name); // Navigate to selected tab
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColor.orangeDark,
          items: [
            BottomNavigationBarItem(
              icon: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/icons/home_icon.png",
                    width: 20,
                    height: 28,
                    color: currentIndex == 0 ? AppColor.orangeDark : AppColor.black,
                  ),
                  4.hS,
                  Text(
                    "home".tr(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: currentIndex == 0 ? AppColor.orangeDark : AppColor.black,
                      fontWeight: FontWeight.bold,fontSize: 10
                    ),
                  ),
                ],
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/icons/search_icon.png",
                    width: 20,
                    height: 28,
                    color: currentIndex == 1 ? AppColor.orangeDark : AppColor.black,
                  ),
                  4.hS,
                  Text(
                    "search".tr(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: currentIndex == 1 ? AppColor.orangeDark : AppColor.black,
                        fontWeight: FontWeight.bold,fontSize: 10
                    ),
                  ),
                ],
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/icons/cart_icon.png",
                        width: 20,
                        height: 28,
                        color: currentIndex == 2 ? AppColor.orangeDark : AppColor.black,
                      ),
                      4.hS,
                      Text(
                        "cart".tr(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: currentIndex == 2 ? AppColor.orangeDark : AppColor.black,
                            fontWeight: FontWeight.bold,fontSize: 10
                        ),
                      ),
                    ],
                  ),
                Positioned(
                    right: -6,
                    top: -2,
                    child: BlocBuilder<CartCountBloc, VegetableGroceryCartCountState>(
                        builder: (context, state) {
                          if (state is VegetableGroceryCartCountSuccessState && state.data.result.groceryCartCount > 0) {
                            return CircleAvatar(
                              radius: 8,
                              backgroundColor: Colors.red,
                              child: Text(
                                state.data.result.groceryCartCount.toString(),
                                style: const TextStyle( color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold, ),
                              ),
                            );
                          }
                          return const SizedBox.shrink(); // No badge if count is 0
                        },
                    ),
                ),
                ],
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/icons/person_icon.png",
                    width: 20,
                    height: 28,
                    color: currentIndex == 3 ? AppColor.orangeDark : AppColor.black,
                  ),
                  4.hS,
                  Text(
                    "my_account".tr(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: currentIndex == 3 ? AppColor.orangeDark : AppColor.black,
                        fontWeight: FontWeight.bold,fontSize: 10
                    ),
                  ),
                ],
              ),
              label: "",
            ),
          ],
        ),
      ),
    );
  }
}
