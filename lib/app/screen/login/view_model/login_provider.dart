import 'dart:developer';

import 'package:faux_spot/app/core/colors.dart';
import 'package:faux_spot/app/routes/messenger.dart';
import 'package:faux_spot/app/routes/routes.dart';
import 'package:faux_spot/app/screen/home/view/location_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../model/emai_model.dart';
import '../model/number_model.dart';
import '../service/login_signup_service.dart';

class LoginProvider extends ChangeNotifier {
  final storage = const FlutterSecureStorage();
  bool otpSucsess = false;
  bool isLoading = false;
  bool continueWith = false;

  void emailOrMobile() {
    otpSucsess = false;
    isLoading = false;
    continueWith = !continueWith;
    notifyListeners();
  }

  //================================ VERIFY NUMBER ======================================

  final formKey = GlobalKey<FormState>();
  TextEditingController numberController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  void sendMobileOtp() async {
    isLoading = true;
    notifyListeners();
    int? number = int.tryParse(numberController.text);

    if (!formKey.currentState!.validate()) {
      isLoading = false;
      notifyListeners();
      return;
    }

    NumberRespones? respones =
        await LoginSignupService().createAccount(number!);
    if (respones?.error == true) {
      await storage.write(key: "id", value: respones?.id.toString());
      isLoading = false;
      otpSucsess = true;
      notifyListeners();
      Messenger.pop(msg: respones!.message.toString());
    } else {
      isLoading = false;
      notifyListeners();
      Messenger.pop(msg: respones!.message.toString(), color: redColour);
    }
  }

  //================================ VERIFY NUMBER OTP ======================================

  void verifyOtp() async {
    isLoading = true;
    notifyListeners();
    int? number = int.tryParse(numberController.text);
    String? id = await storage.read(key: "id");
    if (!formKey.currentState!.validate()) {
      isLoading = false;
      notifyListeners();
      return;
    }
    NumberVerify data = NumberVerify(
      id: id,
      userNumber: number,
      userOtp: otpController.text,
    );
    NumberOtpRespones? respones = await LoginSignupService().verifyOtp(data);

    if (respones?.error == true) {
      storage.write(key: "refreshToken", value: respones!.refreshToken);
      storage.write(key: "token", value: respones.token);
      Routes.pushRemoveUntil(screen: const LocationPick());
      log("Login REfresh ${respones.refreshToken} ====== Token ====== ${respones.token}");
      storage.write(key: "login", value: "true");
      isLoading = false;
      notifyListeners();
    } else {
      isLoading = false;
      notifyListeners();
      Messenger.pop(msg: respones!.message.toString());
    }
  }

  //================================ LOGIN EMAIL ======================================

  final formKeyEmail = GlobalKey<FormState>();
  TextEditingController eamilController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void loginMail() async {
    isLoading = true;
    notifyListeners();

    if (!formKeyEmail.currentState!.validate()) {
      isLoading = false;
      notifyListeners();
      return;
    }

    String eamil = eamilController.text.trim();
    String password = passwordController.text.trim();
    if (eamil.isEmpty || password.isEmpty) {
      isLoading = false;
      notifyListeners();
      Messenger.pop(msg: "Enter valid informarion");
      return;
    }

    EmailLoginRespones? respones =
        await LoginSignupService().emailLogin(eamil, password);

    if (respones!.error == true) {
      storage.write(key: "refreshToken", value: respones.refreshToken);
      storage.write(key: "token", value: respones.token);
      storage.write(key: "login", value: "true");
      Routes.pushRemoveUntil(screen: const LocationPick());
      isLoading = false;
      notifyListeners();
    } else {
      isLoading = false;
      notifyListeners();
      Messenger.pop(msg: respones.message.toString());
    }
  }
}
