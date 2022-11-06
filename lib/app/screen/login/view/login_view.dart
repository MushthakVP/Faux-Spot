import 'package:faux_spot/app/core/app_helper.dart';
import 'package:faux_spot/app/core/colors.dart';
import 'package:faux_spot/app/core/images.dart';
import 'package:faux_spot/app/screen/login/view/signup_view.dart';
import 'package:faux_spot/app/screen/login/view/widgets/loginmail.dart';
import 'package:faux_spot/app/screen/login/view/widgets/loginmobile.dart';
import 'package:faux_spot/app/screen/login/view_model/login_provider.dart';
import 'package:faux_spot/app/screen/login/view_model/signup_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: whiteColor,
        systemOverlayStyle: uiOverlay(navigate: whiteColor, status: whiteColor),
        elevation: 0,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          imageMethod(size),
          space30,
          Selector<SignupProvider, bool>(
            selector: (context, value) => value.loginOrSignup,
            builder: (context, loginOrSignup, _) {
              return loginOrSignup ? const SignupView() : loginBody(context);
            },
          ),
        ],
      ),
    );
  }

  Container loginBody(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: greyColor,
            blurRadius: 15,
            offset: Offset(0, 10),
          ),
        ],
        color: whiteColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "SignIn",
                style: TextStyle(
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              Row(
                children: [
                  const Text(
                    "New User?",
                    style: TextStyle(
                      fontSize: 16,
                      color: greyColor,
                    ),
                  ),
                  space5,
                  InkWell(
                    onTap: () {
                      context.read<SignupProvider>().changePage();
                    },
                    child: const Text(
                      "SignUp",
                      style: TextStyle(
                        fontSize: 16,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          space20,
          Selector<LoginProvider, bool>(
            selector: (context, value) => value.continueWith,
            builder: (context, continueWith, child) =>
                continueWith ? const LoginMobile() : const LoginEmail(),
          ),
        ],
      ),
    );
  }

  Container imageMethod(Size size) {
    return Container(
      height: size.height * 0.2,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(loginImage),
        ),
      ),
    );
  }
}
