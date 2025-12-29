enum AppRoute {
  splash(path: "/"),
  login(path: "/login"),
  forgotpassword(path: "/forgotpassword"),
  resetpassword(path: "/reset-password"),
  createaccountstepone(path: "/createaccountstepone"),
  invitation(path: "/invitation"),
  createaccountsteptwo(path: "/createaccountsteptwo/:memberId/:from"),
  createaccountstepthree(path: "/createaccountstepthree/:memberId"),
  emailverification(path: "/emailverification/:email"),
  home(path: "/home"),
  profile(path: "/profile"),
  editprofile(path: "/editprofile"),
  topchart(path: "/topchart"),
  rewardredemption(path: "/rewardredemption/:fromPage"),
  leaderboard(path: "/leaderboard"),
  changepassword(path: "/changepassword"),
  notification(path: "/notification"),
  claimedrewards(path: "/claimedrewards"),
  pointstransaction(path: "/pointstransaction"),
  socialconnections(path: "/socialconnections"),
  reward(path: "/reward");

  /// Enum defining all named app routes and their associated path patterns for navigation throughout the application.

  final String path;
  const AppRoute({required this.path});
}
