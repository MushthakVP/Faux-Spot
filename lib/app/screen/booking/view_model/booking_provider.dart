import 'package:faux_spot/app/core/colors.dart';
import 'package:flutter/material.dart';

class BookingProvider extends ChangeNotifier {
  DateTime date = DateTime.now();

  changeDAte(BuildContext context) async {
    date = (await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime.now(),
      lastDate: date.add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: primaryColor,
            ),
          ),
          child: child!,
        );
      },
    ))!;
    notifyListeners();
  }
}
