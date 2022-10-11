import 'package:dio/dio.dart';
import 'package:faux_spot/app/service/endpoints.dart';
import 'package:faux_spot/app/service/error.dart';
import '../model/login_signup_model.dart';

class LoginSignupService {
  final Dio _dio = Dio(BaseOptions(baseUrl: EndPoints.baseurl));

// ================================== Number Login ===================================

  Future<NumberRespones?> createAccount(int number) async {
    try {
      Response response = await _dio
          .post(EndPoints.phoneLogin, data: {"user_number": number});
      return NumberRespones.fromJson(response.data);
    } catch (e) {
      return NumberRespones(error: true, message: handleError(e));
    }
  }

// ================================== Verify OTP ======================================

  Future<NumberLoginRespones?> verifyOtp(NumberVerify data) async {
    try {
      Response response = await _dio.post(EndPoints.verifyOtp,
          data: data);
      return NumberLoginRespones.fromJson(response.data);
    } catch (e) {
      return NumberLoginRespones(error: true, message: handleError(e));
    }
  }
}
