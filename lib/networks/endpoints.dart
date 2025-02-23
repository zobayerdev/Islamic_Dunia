// ignore_for_file: constant_identifier_names

const String url = "";

final class NetworkConstants {
  NetworkConstants._();
  static const ACCEPT = "Accept";
  static const APP_KEY = "App-Key";
  static const ACCEPT_LANGUAGE = "Accept-Language";
  static const ACCEPT_LANGUAGE_VALUE = "pt";
  static const APP_KEY_VALUE = String.fromEnvironment("APP_KEY_VALUE");
  static const ACCEPT_TYPE = "application/json";
  static const AUTHORIZATION = "Authorization";
  static const CONTENT_TYPE = "content-Type";
}

final class PaymentGateway {
  PaymentGateway._();
  static String gateway(String orderId) => "";
}

final class Endpoints {
  Endpoints._();
  //backend_url
  static String signUp() => "/api/register";
  static String logIn() => "/api/login";
  static String resendEmailVarificationOtp() =>
      "/api/resend-email-verification-otp";
  static String verifyCode() => "/api/verify-email";
  static String logout() => "/api/logout";
  static String forgotPasswordEmail() => "/api/forget-password";
  static String verifyOtpFP() => "/api/verify-otp";
  static String profile() => "/api/profile/details";
  static String updateProfile() => "/api/profile/update";
  static String getAllRemainders() => "/api/reminder";
  static String addNewRemainder() => "/api/reminder";
  static String remainder(String slug) => "/api/reminder/$slug";
  static String deleteRemainder(int slug) => "/api/reminder/$slug";
  static String updateRemainder(int slug) => "/api/reminder/$slug";
  static String resetPassword() => "/api/reset-password";
  static String changeStatus(int slug) => "/api/reminder/status/$slug";
  static String categoryByType() => "/api/category-type";
  static String quoteListByCategoryWithIdes(ids) =>
      "/api/quote?per_page=1000&page=1&categories=$ids";
  static String quoteAllList() => "/api/quote?per_page=1000&page=1";
  static String favQuote() => "/api/favourite/quote";
  static String addQuote() => "/api/personal-quote";
  static String deleteFavQuote() => "/api/favourite/quote/remove";
  static String theme() => "/api/theme";
  static String personalQuote() => "/api/personal-quote";
  static String deleteMyQuote(int slug) => "/api/personal-quote/$slug";

/*old









  */
  static String appCategories() => "/api/product-categories";
  static String allShopCategories() => "/api/shop-categories";
  static String getShopByCategories(String slug) =>
      "/api/shop-categories/$slug/";
  static String allShops(double lat, double lng) =>
      "/api/shops?lat=$lat&lng=$lng";
  static String searchShops() => "/api/filter-shops";

  static String socialLogin() => "/api/social-login";

  static String allShopSubCategories() => "/api/shop-sub-categories";
  static String shopDetails(String slug) => "/api/shops/$slug";
  static String productDetails(String slug) => "/api/products/$slug";
  static String shopsProductCategories() => "/api/product-categories";
  static String shopProducts(String slug) => "/api/shops/$slug/products";
  static String orders() => "/api/orders";
  static String allOrders() => "/api/all-orders";
  static String reOrders() => "/api/re-order";
  static String ordersOngoing() => "/api/orders-ongoing";
  static String orderDetail(String orderId) => "/api/orders/$orderId";

  static String deliveryAddresses() => "/api/v2/delivery-addresses";
  static String deleteDeliveryAddress(int id) => "/api/delivery-addresses/$id";
  static String saveDeliveryAddress() => "/api/save-delivery-address";
  static String updateAddress() => "/api/update-address";
  static String postIssues() => "/api/register-issue";
  static String defaultDeliveryAddress() => "/api/default-delivery-address";

  static String carts() => "/api/carts";
  static String addToCart() => "/api/carts";

  static String addMultipleAddon() => "/api/cart-addons-multiple";
  static String paymentMethods() => "/api/payment-methods";
  static String timeSlots(String slug) => "/api/shops/$slug/time-slots";

  static String changePassword() => "/api/change-password";
  static String sliders() => "/api/sliders";
  static String sendMailToAdmin() => "/api/send-mail-to-admin";
  static String adminSettings() => "/api/admin-settings";
  static String trendingFood() => "/api/trending-food";
  static String deviceToken() => "/api/device-token";
  static String deleteAccount() => "/api/profile/delete";
  static String deleteToken() => "/api/delete-device-token";
  static String productRating() => "/api/product-rating";
  static String applyVoucher() => "/api/apply-voucher";
  static String reviews() => "/api/reviews";
  static String removeVoucher() => "/api/remove-voucher";
  static String getCartRestaurant() => "/api/cart-restaurant";
  static String getFavouriteRestaurant() => "/api/favourite-restaurants";
  static String makeFavouriteRestaurant() => "/api/favourite-restaurant";
  static String getDefaultDeliveryAddress() =>
      "/api/get-default-delivery-address";
  static String getProductByCategory(String slug) =>
      "/api/product-categories/$slug/products";
  static String getSubCategoryByCategory(String slug) =>
      "/api/shop-categories/$slug/subs";
  static String postCancelOrder() => "/api/order-cancel";
  static String getDeliveryAddressCategory() =>
      "/api/delivery-address-categories";
  static String getCartProcessingTime(num time, num id) =>
      "/api/cart-food-processing-time?duration=$time&restaurant_id=$id";
  static String getFilteredProduct() => "/api/filter-products";

  //gloabal url
  static String gDistanceApi() =>
      "https://maps.googleapis.com/maps/api/distancematrix/json?origins=";
  static String successfulPaymentUrlPrefix() => "";
  static String failedPaymentUrlPrefix() => "";
  static String paymentUrlProcessing() => "";
}
