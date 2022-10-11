import 'package:flutter/material.dart';
import '../../../../core/app_helper.dart';
import '../../../../core/colors.dart';

class OrWidgetLogin extends StatelessWidget {
  final IconData icon;
  final String text;
  const OrWidgetLogin({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        space20,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            Expanded(child: Divider(color: greyColour)),
            space20,
            Text("OR"),
            space20,
            Expanded(child: Divider(color: greyColour)),
          ],
        ),
        space20,
        Container(
          height: 54,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: lightGreyColour),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              space10,
              Icon(icon),
              const Spacer(),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ],
    );
  }
}
