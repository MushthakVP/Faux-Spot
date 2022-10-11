import 'package:dio/dio.dart';
import 'package:faux_spot/app/screen/login/model/emai_model.dart';
import 'package:faux_spot/app/service/endpoints.dart';
import 'package:faux_spot/app/service/error.dart';
import '../model/number_model.dart';

class LoginSignupService {
  final Dio _dio = Dio(BaseOptions(baseUrl: EndPoints.baseurl));

// ================================== Number Login ===================================

  Future<NumberRespones?> createAccount(int number) async {
    Map<String, int> data = {"user_number": number};
    try {
      Response response = await _dio.post(EndPoints.phoneLogin, data: data);
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        return NumberRespones.fromJson(response.data);
      }
    } catch (e) {
      return NumberRespones(error: false, message: handleError(e));
    }
    return null;
  }

// ================================== Verify OTP ======================================

  Future<NumberOtpRespones?> verifyOtp(NumberVerify data) async {
    try {
      Response response = await _dio.post(EndPoints.verifyOtp, data: data);
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        return NumberOtpRespones.fromJson(response.data);
      }
    } catch (e) {
      return NumberOtpRespones(error: false, message: handleError(e));
    }
    return null;
  }

  // ================================== Email Login ===================================

  Future<EmailSignupRespones?> emailLogin(String eamil, String password) async {
    Map<String, String> data = {"user_mail": eamil, "user_password": password};

    try {
      Response respones = await _dio.post(EndPoints.loginEmail, data: data);
      if (respones.statusCode! >= 200 && respones.statusCode! <= 299) {
        return EmailSignupRespones.fromJson(respones.data);
      }
    } catch (e) {
      EmailSignupRespones(error: false, message: handleError(e));
    }
    return null;
  }
}
