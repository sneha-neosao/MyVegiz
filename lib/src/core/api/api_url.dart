/// Centralized API endpoints and domain URLs used throughout the app.
class ApiUrl {
  const ApiUrl._();

  static const baseUrl = "https://myvegiz.com/Apiv1_8/";

  static const environment = "TEST"; //"PRODCTION";

  static const domainUrl = "https://myvegiz.com";

  static const privacyUrl = "/Home/privacypolicy";

  static const termsConditionUrl = "/Home/termsandcondition";

  static const copyRightUrl = "https://www.neosao.com";

  static const contactDetailsUrl = "/Home/contactdetails";

  static const getOtp = "Api/sendRegisterOTP";

  static const verifyOtp = "Api/verifyRegisterOTP";

  static const homeSliderImages = "Api/homeSliderImages";

  static const cityList = "Api/cityList";

  static const registration = "Api/registration";

  static const editProfile = "Api/updateProfile";

  static const accountDelete = "Api/deleteUser";

  static const profileDetails = "Api/userProfile";

  // static const mainCategoryList = "Api/getMainCategoryList";

  static const sliderImages = "Api/sliderImages";

  static const categoriesList = "Api/categoryList";

  static const productByCategory = "Api/productByCategory";

  static const productCategoryList = "Api/categoryAndProduct";

  static const addProductToWishList = "Api/addToWishlist";

  static const wishList = "Api/getWishList";

  static const cartList = "Api/getCartList";

  static const vegetableGroceryCartCount = "Api/getGroceryProductCartCount";

  static const addProductToCart = "Api/addToCart";

  static const updateCart = "Api/updateCart";

  static const searchProductByKeyword = "Api/searchProductByKeyword";

  static const deleteCartItem = "Api/deleteCartItem";

  static const getAddressesList = "Api/getAddressesByclienCode";
  static const deleteClientAddress = "Api/deleteClientAddress";
}
