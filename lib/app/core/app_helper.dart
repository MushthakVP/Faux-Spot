import 'package:faux_spot/app/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

SystemUiOverlayStyle uiOverlay(
    {Color? status, Color? navigate, Brightness? brightness}) {
  return SystemUiOverlayStyle(
    statusBarColor: status,
    systemNavigationBarColor: navigate,
    statusBarBrightness: brightness,
    systemNavigationBarIconBrightness: brightness,
  );
}

const space10 = SizedBox(height: 10, width: 10);
const space20 = SizedBox(height: 20, width: 20);
const space30 = SizedBox(height: 30, width: 30);

InputDecoration inputdecoration({String? labelText, IconData? icon}) {
  return InputDecoration(
    prefixIcon: Icon(
      icon,
      color: blackColour,
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    labelStyle: const TextStyle(color: blackColour, letterSpacing: 1),
    hintText: labelText,
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: lightGreyColour,
      ),
    ),
    disabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: lightGreyColour,
      ),
    ),
    border: const OutlineInputBorder(
      borderSide: BorderSide(
        color: lightGreyColour,
      ),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: greyColour,
      ),
    ),
  );
}
