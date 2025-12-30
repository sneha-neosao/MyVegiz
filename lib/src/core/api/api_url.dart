
/// Centralized API endpoints and domain URLs used throughout the app.
class ApiUrl {
  const ApiUrl._();

  static const baseUrl = "https://myvegiz.com/Apiv1_8/";

  static const environment = "TEST";//"PRODCTION";

  static const domainUrl = "https://myvegiz.com";

  static const privacyUrl="";

  static const termsConditionUrl="";

  static const getOtp = "Api/sendRegisterOTP";

  static const verifyOtp = "Api/verifyRegisterOTP";
}