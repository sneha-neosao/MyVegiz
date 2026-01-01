import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myvegiz_flutter/src/core/extensions/integer_sizedbox_extension.dart';
import 'package:myvegiz_flutter/src/core/themes/app_color.dart';
import 'package:myvegiz_flutter/src/routes/app_route_path.dart';

class HomeScreen extends StatefulWidget {
  final Widget child;

  const HomeScreen({super.key, required this.child});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

    return Scaffold(
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
            icon: Column(
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
    );
  }
}
