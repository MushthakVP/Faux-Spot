
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
  bool otpSuccess = false;
  bool isLoading = false;
  bool continueWith = false;

  void emailOrMobile() {
    otpSuccess = false;
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

    NumberResponse? response =
        await LoginSignupService().createAccount(number!);
    if (response?.error == true) {
      await storage.write(key: "id", value: response?.id.toString());
      isLoading = false;
      otpSuccess = true;
      notifyListeners();
      Messenger.pop(msg: response!.message.toString());
    } else {
      isLoading = false;
      notifyListeners();
      Messenger.pop(msg: response!.message.toString(), color: redColor);
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
    NumberOtpResponse? response = await LoginSignupService().verifyOtp(data);

    if (response?.error == true) {
      storage.write(key: "mobileNumber", value: numberController.text.trim());
      storage.write(key: "refreshToken", value: response!.refreshToken);
      storage.write(key: "token", value: response.token);
      Routes.pushRemoveUntil(screen: const LocationPick());
      storage.write(key: "login", value: "true");
      isLoading = false;
      notifyListeners();
    } else {
      isLoading = false;
      notifyListeners();
      Messenger.pop(msg: response!.message.toString());
    }
  }

  //================================ LOGIN EMAIL ======================================

  final formKeyEmail = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void loginMail() async {
    isLoading = true;
    notifyListeners();

    if (!formKeyEmail.currentState!.validate()) {
      isLoading = false;
      notifyListeners();
      return;
    }

    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    if (email.isEmpty || password.isEmpty) {
      isLoading = false;
      notifyListeners();
      Messenger.pop(msg: "Enter valid information");
      return;
    }

    EmailLoginResponse? response =
        await LoginSignupService().emailLogin(email, password);

    if (response!.error == true) {
      storage.write(key: "refreshToken", value: response.refreshToken);
      storage.write(key: "email", value: email.trim());
      storage.write(key: "token", value: response.token);
      storage.write(key: "login", value: "true");
      await storage.write(key: "id", value: response.id.toString());
      Routes.pushRemoveUntil(screen: const LocationPick());
      isLoading = false;
      notifyListeners();
    } else {
      isLoading = false;
      notifyListeners();
      Messenger.pop(msg: response.message.toString());
    }
  }
}
