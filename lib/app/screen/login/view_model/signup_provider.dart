import 'dart:developer';

import 'package:faux_spot/app/routes/routes.dart';
import 'package:faux_spot/app/screen/login/model/emai_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../routes/messenger.dart';
import '../../home/view/location_widget.dart';
import '../service/login_signup_service.dart';

class SignupProvider extends ChangeNotifier {
  final storage = const FlutterSecureStorage();
  bool loginOrSignup = false;
  bool isLoading = false;
  bool showOtpWidget = false;
  bool otpSuccess = false;

  void changePage() async {
    showOtpWidget = false;
    loginOrSignup = !loginOrSignup;
    notifyListeners();
  }

  //================================ VERIFY EMAIL ======================================

  final formKeySignup = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void verifyEmail() async {
    isLoading = true;
    notifyListeners();
    if (!formKeySignup.currentState!.validate()) {
      isLoading = false;
      notifyListeners();
      return;
    }

    if (!hasPasswordOneNumber && !isPasswordEightCharacters) {
      Messenger.pop(msg: "Set a strong password");
      isLoading = false;
      notifyListeners();
      return;
    }

    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    EmailSignupResponse? response =
        await LoginSignupService().signupEmail(email, password);

    if (response != null) {
      if (response.error == true) {
        await storage.write(key: "id", value: response.id);
        Messenger.pop(msg: response.message.toString());
        showOtpWidget = true;
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
        Messenger.pop(msg: response.message.toString());
      }
    } else {
      isLoading = false;
      notifyListeners();
    }
  }

  //================================ VERIFY EMAIL OTP ======================================

  void verifyOtp() async {
    isLoading = true;
    notifyListeners();

    if (!formKeySignup.currentState!.validate()) {
      isLoading = false;
      notifyListeners();
      return;
    }
    String? id = await storage.read(key: "id");
    String otp = otpController.text.trim();

    EmailVerifyResponse? response =
        await LoginSignupService().verifyEmailOtp(otp, id!);
    if (response!.error == true) {
      storage.write(key: "refreshToken", value: response.refreshToken);
      storage.write(key: "token", value: response.token);
      storage.write(key: "login", value: "true");
      storage.write(key: "id", value: response.id.toString());
      Routes.pushRemoveUntil(screen: const LocationPick());
      isLoading = false;
      notifyListeners();
    } else {
      Messenger.pop(msg: response.message.toString());
      isLoading = false;
      notifyListeners();
    }
  }

  //================================ CHECK PASSWORD ======================================

  bool isPasswordEightCharacters = false;
  bool hasPasswordOneNumber = false;

  onPasswordChanged(String password) {
    final numericRegex = RegExp(r'[0-9]');
    log(password);
    notifyListeners();

    isPasswordEightCharacters = false;
    if (password.length >= 8) {
      isPasswordEightCharacters = true;
    }

    hasPasswordOneNumber = false;
    if (numericRegex.hasMatch(password)) {
      hasPasswordOneNumber = true;
    }
  }
}
