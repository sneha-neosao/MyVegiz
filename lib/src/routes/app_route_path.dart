enum AppRoute {
  splash(path: "/"),
  loginScreen(path: "/loginScreen"),
  otpVerificationScreen(path: "/otpVerificationScreen"),
  homeScreen(path: "/homeScreen"),
  homeContentScreen(path: "/homeContentScreen"),
  searchScreen(path: "/searchScreen"),
  cartScreen(path: "/cartScreen"),
  myAccountScreen(path: "/myAccountScreen"),
  editProfileScreen(path: "/editProfileScreen"),
  myWishlistScreen(path: "/myWishlistScreen"),
  vegetablesAndGroceryScreen(path: "/vegetablesAndGroceryScreen"),
  registerScreen(path: "/registerScreen"),
  selectLocationScreen(path: "/selectLocationScreen"),
  confirmLocationScreen(path: "/confirmLocationScreen"),
  vegetableProductListScreen(path: "/vegetableProductListScreen"),
  groceryProductListScreen(path: "/groceryProductListScreen"),
  appInfoScreen(path: "/appInfoScreen"),
  webViewScreen(path: "/webViewScreen"),
  addressesScreen(path: "/addressesScreen");

  /// Enum defining all named app routes and their associated path patterns for navigation throughout the application.

  final String path;
  const AppRoute({required this.path});
}
