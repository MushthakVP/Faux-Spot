import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import '../../../../core/app_helper.dart';
import '../../../../core/colors.dart';

class AmenitiesWidget extends StatelessWidget {
  final String name;
  final String icon;
  final bool visible;
  const AmenitiesWidget({
    Key? key,
    required this.icon,
    required this.name,
    required this.visible,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Visibility(
      visible: visible,
      child: Container(
        height: 60,
        width: size.width / 2.25,
        margin: const EdgeInsets.only(right: 4, bottom: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: lightGreyColor),
          color: whiteColor,
          boxShadow: const [
            BoxShadow(
              color: lightGreyColor,
              blurRadius: 15,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: [
            space15,
            Iconify(icon),
            space10,
            Text(
              name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
