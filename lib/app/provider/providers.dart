import 'package:faux_spot/app/screen/booking/view_model/booking_provider.dart';
import 'package:faux_spot/app/screen/booking/view_model/payment_provider.dart';
import 'package:faux_spot/app/screen/favorite/view_model/favorite_provider.dart';
import 'package:faux_spot/app/screen/home/service/location.dart';
import 'package:faux_spot/app/screen/home/view_model/home_provider.dart';
import 'package:faux_spot/app/screen/login/view_model/login_provider.dart';
import 'package:faux_spot/app/screen/login/view_model/signup_provider.dart';
import 'package:faux_spot/app/screen/overview/view_model/overview_provider.dart';
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
        ChangeNotifierProvider(create: (context) => SignupProvider()),
        ChangeNotifierProvider(create: (context) => GetUserLocation()),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(create: (context) => OverViewProvider()),
        ChangeNotifierProvider(create: (context) => FavoriteProvider()),
        ChangeNotifierProvider(create: (context) => BookingProvider()),
        ChangeNotifierProvider(create: (context) => PaymentProvider()),
      ],
      child: const MyApp(),
    );
  }
}
