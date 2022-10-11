import 'package:flutter/cupertino.dart';

class SignupProvider extends ChangeNotifier {
  bool loginOrSignup = false;
  bool isLoading = false;
  bool showOtpWidget = false;

  void changePage() async {
    showOtpWidget = false;
    loginOrSignup = !loginOrSignup;
    notifyListeners();
  }

  bool otpSucsess = false;
  void sendEmailOtp() async {
    isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));
    showOtpWidget = true;
    isLoading = false;
    notifyListeners();
  }

  void verifyOtp() async {
    isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));
    isLoading = false;
    notifyListeners();
  }
}
