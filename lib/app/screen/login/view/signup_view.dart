import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';
import '../../../core/app_helper.dart';
import '../../../core/colors.dart';
import '../view_model/signup_provider.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "SignUP",
                style: TextStyle(
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              GestureDetector(
                onTap: () {
                  context.read<SignupProvider>().changePage();
                },
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      color: blackColour,
                      fontSize: 12,
                    ),
                    text: "Already account? ",
                    children: [
                      TextSpan(
                        text: "Login",
                        style: TextStyle(
                          color: blackColour,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          space20,
          TextFormField(
            cursorColor: blackColour,
            keyboardType: TextInputType.emailAddress,
            decoration: inputdecoration(
              labelText: "Email",
              icon: Icons.alternate_email,
            ),
          ),
          space10,
          TextFormField(
            cursorColor: blackColour,
            keyboardType: TextInputType.emailAddress,
            decoration: inputdecoration(
              labelText: "Password",
              icon: Icons.lock_outline,
            ),
          ),
          space10,
          Consumer<SignupProvider>(
            builder: (context, value, child) => Column(
              children: [
                Visibility(
                  visible: value.showOtpWidget,
                  child: TextFormField(
                    cursorColor: blackColour,
                    keyboardType: TextInputType.emailAddress,
                    decoration: inputdecoration(
                      labelText: "OTP",
                      icon: UniconsLine.message,
                    ),
                  ),
                ),
                space10,
                Visibility(
                  visible: !value.showOtpWidget,
                  child: SizedBox(
                    height: 54,
                    width: double.infinity,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: blackColour,
                      ),
                      onPressed: () {
                        value.sendEmailOtp();
                      },
                      child: value.isLoading
                          ? const Center(
                              child: CupertinoActivityIndicator(),
                            )
                          : const Text(
                              "SEND OTP",
                              style: TextStyle(
                                fontSize: 18,
                                color: blackColour,
                              ),
                            ),
                    ),
                  ),
                ),
                Visibility(
                  visible: value.showOtpWidget,
                  child: SizedBox(
                    height: 54,
                    width: double.infinity,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: blackColour,
                      ),
                      onPressed: () {
                        value.verifyOtp();
                      },
                      child: value.isLoading
                          ? const Center(
                              child: CupertinoActivityIndicator(),
                            )
                          : const Text(
                              "VERIFY OTP",
                              style: TextStyle(
                                fontSize: 18,
                                color: blackColour,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
