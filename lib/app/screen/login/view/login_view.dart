import 'package:faux_spot/app/core/app_helper.dart';
import 'package:faux_spot/app/core/colors.dart';
import 'package:faux_spot/app/core/images.dart';
import 'package:flutter/material.dart';
import 'widgets/loginemail.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColour,
        systemOverlayStyle:
            uiOverlay(navigate: whiteColour, status: whiteColour),
        elevation: 0,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          imageMethod(),
          space30,
          loginBody(),
        ],
      ),
    );
  }

  Container loginBody() {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 400,
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: greyColour,
            blurRadius: 15,
            offset: Offset(0, 10),
          ),
        ],
        color: whiteColour,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "SignIn",
            style: TextStyle(
              letterSpacing: 1,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          space20,
          LoginEmail(),
        ],
      ),
    );
  }

  Container imageMethod() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(loginImage),
        ),
      ),
    );
  }
}
