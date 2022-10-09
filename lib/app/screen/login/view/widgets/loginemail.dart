import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import '../../../../core/app_helper.dart';
import '../../../../core/colors.dart';
import 'orwidgetlogin.dart';

class LoginEmail extends StatelessWidget {
  const LoginEmail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
        SizedBox(
          height: 54,
          width: double.infinity,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: blackColour,
            ),
            onPressed: () {},
            child: const Text(
              "LOGIN",
              style: TextStyle(
                fontSize: 18,
                color: blackColour,
              ),
            ),
          ),
        ),
        const OrWidgetLogin(
          text: "Continue with number",
          icon: UniconsLine.mobile_android,
        ),
      ],
    );
  }
}
