
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

  static const homeSliderImages = "Api/homeSliderImages";

  static const cityList = "Api/cityList";

  static const registration = "Api/registration";

  static const accountDelete = "Api/deleteUser";

  // static const mainCategoryList = "Api/getMainCategoryList";

  static const sliderImages = "Api/sliderImages";

  static const categoriesList = "Api/categoryList";

  static const productByCategory = "Api/productByCategory";

  static const productCategoryList = "Api/categoryAndProduct";

  static const editProfile = "Api/updateProfile";

}