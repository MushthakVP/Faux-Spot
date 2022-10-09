import 'dart:async';

import 'package:faux_spot/app/routes/routes.dart';
import 'package:faux_spot/app/screen/home/view/home_view.dart';
import 'package:faux_spot/app/screen/login/view/login_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SplashProvider extends ChangeNotifier {
  Future<void> init() async {
    const storage = FlutterSecureStorage();
    String? value = await storage.read(key: 'login');
    Timer(const Duration(seconds: 2), () {
      if (value != null) {
        Routes.pushreplace(screen: const HomeView());
      } else {
        Routes.pushreplace(screen: const LoginView());
      }
    });
  }
}
