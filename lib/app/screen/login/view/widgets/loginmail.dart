import 'package:faux_spot/app/screen/login/view_model/login_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/icons/ci.dart';
import 'package:provider/provider.dart';
import '../../../../core/app_helper.dart';
import '../../../../core/colors.dart';
import 'orwidgetlogin.dart';

class LoginEmail extends StatelessWidget {
  const LoginEmail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginProvider provider = context.read<LoginProvider>();
    return Form(
      key: provider.formKeyEmail,
      child: Column(
        children: [
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter valid email';
              }
              return null;
            },
            controller: provider.eamilController,
            cursorColor: blackColour,
            keyboardType: TextInputType.emailAddress,
            decoration: inputdecoration(
              labelText: "Email",
              icon: Icons.alternate_email,
            ),
          ),
          space10,
          TextFormField(
             validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter valid password';
              }
              return null;
            },
            controller: provider.passwordController,
            cursorColor: blackColour,
            keyboardType: TextInputType.emailAddress,
            decoration: inputdecoration(
              labelText: "Password",
              icon: Icons.lock_outline,
            ),
          ),
          space10,
          SizedBox(
            height: 54,
            width: double.infinity,
            child: Selector<LoginProvider, bool>(
              selector: (context, value) => value.isLoading,
              builder: (context, isLoading, _) => OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: blackColour,
                ),
                onPressed: () {
                  provider.loginMail();
                },
                child: isLoading
                    ? const CupertinoActivityIndicator()
                    : const Text(
                        "LOGIN",
                        style: TextStyle(
                          fontSize: 18,
                          color: blackColour,
                        ),
                      ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              provider.emailOrMobile();
            },
            child:  const OrWidgetLogin(
              text: "Continue with number",
              icon: Ci.mobile,
            ),
          ),
        ],
      ),
    );
  }
}
