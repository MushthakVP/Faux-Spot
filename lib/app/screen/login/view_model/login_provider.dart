import 'dart:async';
import 'package:faux_spot/app/core/colors.dart';
import 'package:faux_spot/app/routes/messenger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../model/login_signup_model.dart';
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
    if (respones?.error == false) {
      await storage.write(key: "id", value: respones?.id.toString());
      isLoading = false;
      otpSucsess = true;
      notifyListeners();
      Messenger.pop(msg: "Otp Sent");
    } else {
      isLoading = false;
      notifyListeners();
      Messenger.pop(msg: respones!.message.toString(), color: redColour);
    }
  }

  //================================ VERIFY OTP ======================================

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
    NumberLoginRespones? respones = await LoginSignupService().verifyOtp(data);
    if (respones?.error == false) {
      Messenger.pop(msg: "", color: grrenColour);
    } else {
      isLoading = false;
      notifyListeners();
      Messenger.pop(msg: respones!.message.toString());
    }
    isLoading = false;
    notifyListeners();
  }

  void confirmMail() async {
    isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 4));
    isLoading = false;
    notifyListeners();
  }
}
