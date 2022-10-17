import 'package:flutter/material.dart';

class BookingProvider extends ChangeNotifier {
  DateTime date = DateTime.now();

  changeDAte(BuildContext context) async {
    date = (await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: date,
      lastDate: date.add(const Duration(days: 365)),
    ))!;

    notifyListeners();
  }

  // DateTime startDate = date.subtract(const Duration(days: 14));
  // DateTime endDate = date.add(const Duration(days: 7));
}
