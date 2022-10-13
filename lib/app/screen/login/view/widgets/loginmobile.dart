import 'package:faux_spot/app/screen/login/view_model/login_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/icons/ci.dart';
import 'package:iconify_flutter/icons/teenyicons.dart';
import 'package:provider/provider.dart';
import '../../../../core/app_helper.dart';
import '../../../../core/colors.dart';
import 'orwidgetlogin.dart';

class LoginMobile extends StatelessWidget {
  const LoginMobile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginProvider provider = context.read<LoginProvider>();
    return Form(
      key: provider.formKey,
      child: Column(
        children: [
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter Phone Number';
              } else if (value.length <= 9) {
                return 'Enter 10 digit number';
              }
              return null;
            },
            controller: provider.numberController,
            cursorColor: blackColour,
            keyboardType: TextInputType.number,
            decoration: inputdecoration(
              labelText: "Number",
              icon: Icons.phone,
            ),
          ),
          space10,
          Selector<LoginProvider, bool>(
            selector: (BuildContext context, obj) => obj.otpSucsess,
            builder: (context, numberOtp, _) => Visibility(
              child: Visibility(
                visible: numberOtp,
                child: TextFormField(
                  controller: provider.otpController,
                   validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter OTP';
              } else if (value.length <= 5) {
                return 'Enter Correct OTP';
              }
              return null;
            },
                  cursorColor: blackColour,
                  keyboardType: TextInputType.number,
                  decoration: inputdecoration(
                    labelText: "OTP",
                    iconn: Teenyicons.otp_outline,
                  ),
                ),
              ),
            ),
          ),
          space10,
          Consumer<LoginProvider>(
            builder: (context, value, _) => Column(
              children: [
                Visibility(
                  visible: value.otpSucsess == false,
                  child: SizedBox(
                    height: 54,
                    width: double.infinity,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: blackColour,
                      ),
                      onPressed: () {
                        provider.sendMobileOtp();
                      },
                      child: provider.isLoading
                          ? const CupertinoActivityIndicator()
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
                  visible: value.otpSucsess == true,
                  child: SizedBox(
                    height: 54,
                    width: double.infinity,
                    child: Selector<LoginProvider, bool>(
                      selector: (context, value) => value.isLoading,
                      builder: (context, isLoading, _) => OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: blackColour,
                        ),
                        onPressed: () {
                          provider.verifyOtp();
                        },
                        child: isLoading
                            ? const CupertinoActivityIndicator()
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
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              provider.emailOrMobile();
            },
            child: const OrWidgetLogin(
              text: "Continue with mail",
              icon: Ci.mail_open,
            ),
          ),
        ],
      ),
    );
  }
}
