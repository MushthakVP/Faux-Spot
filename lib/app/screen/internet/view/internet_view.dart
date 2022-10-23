import 'package:faux_spot/app/core/app_helper.dart';
import 'package:faux_spot/app/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../core/images.dart';
import '../view_model/internet_provider.dart';

class NoInternet extends StatelessWidget {
  final dynamic screen;
   const NoInternet({super.key , required this.screen});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: whiteColor,
        systemOverlayStyle: uiOverlay(
          status: whiteColor,
          navigate: whiteColor,
          brightness: Brightness.dark,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              "No Internet Connection",
              style: TextStyle(
                color: primaryColor,
                fontSize: 18,
              ),
            ),
            Lottie.asset(
              noInternet,
              width: 170,
              height: 170,
            ),
            SizedBox(
              height: 54,
              width: 200,
              child: TextButton(
                onPressed: () {
                  InternetProvider().tryAgain(screen: screen);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Try Again',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
