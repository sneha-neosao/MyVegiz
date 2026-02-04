import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:myvegiz_flutter/src/configs/injector/injector.dart';
import 'package:myvegiz_flutter/src/core/extensions/integer_sizedbox_extension.dart';
import 'package:myvegiz_flutter/src/core/session/session_manager.dart';
import 'package:myvegiz_flutter/src/core/themes/app_color.dart';
import 'package:myvegiz_flutter/src/routes/app_route_path.dart';

import '../../../../configs/injector/injector_conf.dart';

class HomeScreen extends StatefulWidget {
  final Widget child;

  const HomeScreen({super.key, required this.child});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final CartCountBloc _cartCountBloc;

  // Define the tab routes
  final tabs = [
    AppRoute.homeContentScreen,
    AppRoute.searchScreen,
    AppRoute.cartScreen,
    AppRoute.myAccountScreen,
  ];

  @override
  void initState() {
    super.initState();

    // Create bloc once
    _cartCountBloc = getIt<CartCountBloc>();

    // Call after first frame so context is ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadClientCode();
    });
  }

  void _loadClientCode() async {
    final clientcode = await SessionManager.getClientCode();
    if (clientcode != null) {
      _cartCountBloc.add(CartCountGetEvent(clientcode));
    }
  }

  @override
  void dispose() {
    _cartCountBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get current location from GoRouter
    final location = GoRouterState.of(context).uri.toString();

    int currentIndex =
    tabs.indexWhere((route) => location.startsWith(route.path));
    if (currentIndex == -1) currentIndex = 0;

    return BlocProvider.value(
      value: _cartCountBloc,
      child: Scaffold(
        body: widget.child,

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            context.goNamed(tabs[index].name);
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColor.orangeDark,

          items: [
            BottomNavigationBarItem(
              icon: _navItem(
                context,
                "assets/icons/home_icon.png",
                "home".tr(),
                currentIndex == 0,
              ),
              label: "",
            ),

            BottomNavigationBarItem(
              icon: _navItem(
                context,
                "assets/icons/search_icon.png",
                "search".tr(),
                currentIndex == 1,
              ),
              label: "",
            ),

            BottomNavigationBarItem(
              icon: Stack(
                children: [
                  _navItem(
                    context,
                    "assets/icons/cart_icon.png",
                    "cart".tr(),
                    currentIndex == 2,
                  ),

                  Positioned(
                    right: 0,
                    top: 0,
                    child: BlocBuilder<CartCountBloc,
                        VegetableGroceryCartCountState>(
                      builder: (context, state) {
                        if (state
                        is VegetableGroceryCartCountSuccessState &&
                            state.data.result.groceryCartCount > 0) {
                          return CircleAvatar(
                            radius: 6,
                            backgroundColor: AppColor.orangeDark,
                            child: Center(
                              child: Text(
                                state.data.result.groceryCartCount.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ],
              ),
              label: "",
            ),

            BottomNavigationBarItem(
              icon: _navItem(
                context,
                "assets/icons/person_icon.png",
                "my_account".tr(),
                currentIndex == 3,
              ),
              label: "",
            ),
          ],
        ),
      ),
    );
  }

  Widget _navItem(
      BuildContext context, String icon, String label, bool selected) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          icon,
          width: 20,
          height: 28,
          color: selected ? AppColor.orangeDark : AppColor.black,
        ),
        4.hS,
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: selected ? AppColor.orangeDark : AppColor.black,
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
