import 'package:faux_spot/app/screen/login/view_model/login_provider.dart';
import 'package:faux_spot/app/screen/splash/view_model/splash_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../main.dart';

class Providers {
  static Widget providers() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SplashProvider()),
        ChangeNotifierProvider(create: (context) => LoginProvider()),
      ],
      child: const MyApp(),
    );
  }
}
