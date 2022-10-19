class EndPoints {
  static const String baseurl = "https://fauxspot.herokuapp.com";
  static const String phoneLogin = "/account/loginwith-number";
  static const String verifyOtp = "/account/verify-number-otp";
  static const String loginEmail = "/account/login-email";
  static const String signupEmail = "/account/signup-email";
  static const String emailOtpVerify = "/account/verify-email-otp";
  static const String nearestTurf = "/user/nearest-turf/{spot}";
  static const String getWishlist = "/user/get-whishlist/{id}";
  static const String addWishlist = "/user/add-whishlist";
  static const String bookingList = "/turf/booking";
}
