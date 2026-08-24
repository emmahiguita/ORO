class AppLink {
  AppLink._();

  /// Desarrollo Android Emulator: http://10.0.2.2/ecommerce
  /// Producción: inyectar HTTPS con --dart-define=API_BASE_URL=https://...
  static const String server = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://10.0.2.2/ecommerce',
  );

  static const String image = String.fromEnvironment(
    'ASSET_BASE_URL',
    defaultValue: '$server/upload',
  );

  static const String test = '$server/test.php';
  static const String publicConfig = '$server/config/public.php';
  static const String signup = '$server/auth/signup.php';
  static const String login = '$server/auth/login.php';
  static const String verifycode = '$server/auth/verifycode.php';
  static const String resendcode = '$server/auth/resendcode.php';
  static const String checkemail = '$server/forgotpassword/checkemail.php';
  static const String verifycodepass =
      '$server/forgotpassword/verifycodepass.php';
  static const String resetpassword =
      '$server/forgotpassword/resetpassword.php';
  static const String home = '$server/home/home.php';

  static const String itemimage = '$image/items/';
  static const String categoriesimage = '$image/categories/';
  static const String pfpimage = '$image/pfp/';
  static const String bannerimage = '$image/banner/';
  static const String homeimage = '$image/home/';
  static const String notificationimage = '$image/notification/';
  static const String notificationicon = '$image/notification/icons/';

  static const String items = '$server/items/items.php';
  static const String favouritesAdd = '$server/favourites/add.php';
  static const String favouritesDelete = '$server/favourites/delete.php';
  static const String favouritesView = '$server/favourites/view.php';
  static const String cartAdd = '$server/cart/addcart.php';
  static const String cartDelete = '$server/cart/deletecart.php';
  static const String cartView = '$server/cart/viewcart.php';
  static const String cartCount = '$server/cart/countcart.php';
  static const String search = '$server/search/search.php';
  static const String suggestion = '$server/search/suggestion.php';
  static const String updateAccountInformation =
      '$server/settings/editaccountinfo.php';
  static const String addAddress = '$server/address/add.php';
  static const String deleteAddress = '$server/address/delete.php';
  static const String updateAddress = '$server/address/update.php';
  static const String viewAddress = '$server/address/view.php';
  static const String checkCoupon = '$server/coupon/checkcoupon.php';
  static const String checkout = '$server/checkout/checkout.php';
  static const String viewNotification =
      '$server/notification/viewnotification.php';
  static const String deleteNotification =
      '$server/notification/deletenotification.php';
  static const String readNotification =
      '$server/notification/readnotification.php';
  static const String newNotificationsCount =
      '$server/notification/getunreadcount.php';
  static const String registerDevice =
      '$server/notification/registerdevice.php';
  static const String unregisterDevice =
      '$server/notification/unregisterdevice.php';
  static const String viewPendingOrders = '$server/orders/pending.php';
  static const String viewArchivedOrders = '$server/orders/archived.php';
  static const String getOrderDetails = '$server/orders/vieworder.php';
  static const String cancelOrder = '$server/orders/cancel.php';
  static const String addRating = '$server/rating/add.php';
  static const String getRating = '$server/rating/get.php';
  static const String getIsOrdered = '$server/rating/isordered.php';
  static const String deleteRating = '$server/rating/delete.php';
  static const String viewAllRating = '$server/rating/viewrating.php';
  static const String undeliveredOrders = '$server/delivery/requests.php';
  static const String deliveryOrderDetails =
      '$server/delivery/orderdetails.php';
  static const String acceptorder = '$server/delivery/acceptorder.php';
  static const String viewAcceptedOrders = '$server/delivery/viewaccepted.php';
  static const String markAsDelivered = '$server/delivery/markasdelivered.php';
  static const String countDelivered = '$server/delivery/countdelivered.php';
  static const String delivered = '$server/delivery/delivered.php';

  static const String getCategories = '$server/admin/categories/view.php';
  static const String addCategories = '$server/admin/categories/add.php';
  static const String updateCategories = '$server/admin/categories/update.php';
  static const String deleteCategories = '$server/admin/categories/delete.php';
  static const String getItems = '$server/admin/items/view.php';
  static const String addItems = '$server/admin/items/add.php';
  static const String updateItems = '$server/admin/items/update.php';
  static const String deleteItems = '$server/admin/items/delete.php';
  static const String getOrders = '$server/admin/orders/getorders.php';
  static const String adminOrderDetails =
      '$server/admin/orders/orderdetails.php';
  static const String approveOrder = '$server/admin/orders/aproveorder.php';
  static const String informdelivery =
      '$server/admin/orders/informdelivery.php';
  static const String readytopickup = '$server/admin/orders/readytopickup.php';
  static const String userpickedup = '$server/admin/orders/userpickedup.php';
  static const String cancelorder = '$server/admin/orders/cancelorder.php';
  static const String archiveOrder = '$server/admin/orders/archiveorder.php';
  static const String dashboardInfo = '$server/admin/dashboard.php';
  static const String getCoupons = '$server/admin/coupon/viewcoupons.php';
  static const String addCoupon = '$server/admin/coupon/addcoupon.php';
  static const String editCoupon = '$server/admin/coupon/editcoupon.php';
  static const String announceCoupon =
      '$server/admin/coupon/announcetousers.php';
  static const String getOfferMessage =
      '$server/admin/offermessage/getoffermessage.php';
  static const String editOfferMessage =
      '$server/admin/offermessage/editoffermessage.php';
  static const String createNewDeliveryAccount =
      '$server/admin/settings/createnewdeliveryaccount.php';
  static const String createNewAdminAccount =
      '$server/admin/settings/createnewadminaccount.php';
  static const String getTotalOrders = '$server/profile/orderscount.php';

  static bool _isSecurePublicUrl(String value) {
    final uri = Uri.tryParse(value);
    return uri != null &&
        uri.scheme.toLowerCase() == 'https' &&
        uri.host.isNotEmpty &&
        uri.host != '10.0.2.2' &&
        uri.host != 'localhost' &&
        uri.host != '127.0.0.1';
  }

  static bool get isProductionUrlSafe =>
      _isSecurePublicUrl(server) && _isSecurePublicUrl(image);
}
