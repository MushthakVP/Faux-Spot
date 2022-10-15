import 'package:dio/dio.dart';
import 'package:faux_spot/app/screen/login/model/emai_model.dart';
import 'package:faux_spot/app/service/endpoints.dart';
import 'package:faux_spot/app/service/error.dart';
import '../model/number_model.dart';

class LoginSignupService {
  final Dio _dio = Dio(BaseOptions(baseUrl: EndPoints.baseurl));

// ================================== Number Login ===================================

  Future<NumberResponse?> createAccount(int number) async {
    Map<String, int> data = {"user_number": number};
    try {
      Response response = await _dio.post(EndPoints.phoneLogin, data: data);
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        return NumberResponse.fromJson(response.data);
      }
    } catch (e) {
      return NumberResponse(error: false, message: handleError(e));
    }
    return null;
  }

// ================================== Verify OTP ======================================

  Future<NumberOtpResponse?> verifyOtp(NumberVerify data) async {
    try {
      Response response = await _dio.post(EndPoints.verifyOtp, data: data);
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        return NumberOtpResponse.fromJson(response.data);
      }
    } catch (e) {
      return NumberOtpResponse(error: false, message: handleError(e));
    }
    return null;
  }

  // ================================== Email Login ===================================

  Future<EmailLoginResponse?> emailLogin(String email, String password) async {
    Map<String, String> data = {"user_mail": email, "user_password": password};

    try {
      Response response = await _dio.post(EndPoints.loginEmail, data: data);
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        return EmailLoginResponse.fromJson(response.data);
      }
    } catch (e) {
      return EmailLoginResponse(error: false, message: handleError(e));
    }
    return null;
  }

  // ================================== SIGNUP EMAIL ===================================

  Future<EmailSignupResponse?> signupEmail(
      String email, String password) async {
    Map<String, String> data = {"user_mail": email, "user_password": password};
    try {
      Response response = await _dio.post(EndPoints.signupEmail, data: data);
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        return EmailSignupResponse.fromJson(response.data);
      }
    } catch (e) {
      return EmailSignupResponse(error: false, message: handleError(e));
    }
    return null;
  }

  // ================================== VERIFY EMAIL OTP ===================================

  Future<EmailVerifyResponse?> verifyEmailOtp(String otp, String id) async {
    Map<String, String> data = {"user_otp": otp, "_id": id};
    try {
      Response response = await _dio.post(EndPoints.emailOtpVerify, data: data);
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        return EmailVerifyResponse.fromJson(response.data);
      }
    } catch (e) {
      return EmailVerifyResponse(error: false, message: handleError(e));
    }
    return null;
  }
}
