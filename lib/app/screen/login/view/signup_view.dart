import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/app_helper.dart';
import '../../../core/colors.dart';
import '../view_model/signup_provider.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    SignupProvider provider = context.read<SignupProvider>();
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: greyColor,
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
        color: whiteColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Form(
        key: provider.formKeySignup,
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
                        color: blackColor,
                        fontSize: 12,
                      ),
                      text: "Already account? ",
                      children: [
                        TextSpan(
                          text: "Login",
                          style: TextStyle(
                            color: blackColor,
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter valid email';
                }
                return null;
              },
              controller: provider.emailController,
              cursorColor: blackColor,
              keyboardType: TextInputType.emailAddress,
              decoration: inputdecoration(
                labelText: "Email",
                icon: Icons.alternate_email,
              ),
            ),
            space10,
            TextFormField(
              onChanged: (String values) {
                provider.onPasswordChanged(values);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter valid password';
                }
                return null;
              },
              controller: provider.passwordController,
              cursorColor: blackColor,
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter valid otp';
                        }
                        return null;
                      },
                      controller: provider.otpController,
                      cursorColor: blackColor,
                      keyboardType: TextInputType.emailAddress,
                      decoration: inputdecoration(
                        labelText: "OTP",
                        icon: Icons.mark_email_unread_outlined,
                      ),
                    ),
                  ),
                  EmailRegWidget(provider: provider),
                  space10,
                  Visibility(
                    visible: !value.showOtpWidget,
                    child: SizedBox(
                      height: 54,
                      width: double.infinity,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: blackColor,
                        ),
                        onPressed: () {
                          value.verifyEmail();
                        },
                        child: value.isLoading
                            ? const Center(
                                child: CupertinoActivityIndicator(),
                              )
                            : const Text(
                                "SEND OTP",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: blackColor,
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
                          foregroundColor: blackColor,
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
                                  color: blackColor,
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
      ),
    );
  }
}

class EmailRegWidget extends StatelessWidget {
  const EmailRegWidget({
    Key? key,
    required this.provider,
  }) : super(key: key);

  final SignupProvider provider;

  @override
  Widget build(BuildContext context) {
    return Consumer<SignupProvider>(
      builder: (context, value, _) {
        return Visibility(
          visible: !value.showOtpWidget,
          child: Column(
            children: [
              space10,
              Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                        color: value.isPasswordEightCharacters
                            ? Colors.green
                            : Colors.transparent,
                        border: value.isPasswordEightCharacters
                            ? Border.all(color: Colors.transparent)
                            : Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(50)),
                    child: const Center(
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text("Contains at least 8 characters")
                ],
              ),
              space10,
              Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                        color: value.hasPasswordOneNumber
                            ? Colors.green
                            : Colors.transparent,
                        border: value.hasPasswordOneNumber
                            ? Border.all(color: Colors.transparent)
                            : Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(50)),
                    child: const Center(
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text("Contains at least 1 number")
                ],
              ),
              space10,
            ],
          ),
        );
      },
    );
  }
}
