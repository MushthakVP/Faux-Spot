import 'dart:developer';

import 'package:faux_spot/app/screen/home/model/home_model.dart';
import 'package:flutter/material.dart';
import '../../../core/colors.dart';

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

  //================================ CREATE SLOT ======================================

  List<String> morningSlot = [];
  List<String> afternoonSlot = [];
  List<String> eveningSlot = [];

  void slotCreate({required DataList list}) async {
    morningSlot.clear();
    afternoonSlot.clear();
    eveningSlot.clear();
    int morningTimeStart = list.turfTime!.timeMorningStart!;
    int morningTimeEnd = list.turfTime!.timeMorningEnd!;
    int afternoonTimeStart = list.turfTime!.timeAfternoonStart!;
    int afternoonTimeEnd = list.turfTime!.timeAfternoonEnd!;
    int eveningTimeStart = list.turfTime!.timeEveningStart!;
    int eveningTimeEnd = list.turfTime!.timeEveningEnd!;

    for (int i = morningTimeStart; i < morningTimeEnd; i++) {
      morningSlot.add(hourConvert(hour: "$i:00"));
    }
    for (int i = afternoonTimeStart; i < afternoonTimeEnd; i++) {
      afternoonSlot.add(hourConvert(hour: "$i:00"));
    }
    log(afternoonSlot.toString());
    for (int i = eveningTimeStart; i < eveningTimeEnd; i++) {
      eveningSlot.add(hourConvert(hour: "$i:00"));
    }
    notifyListeners();
  }

  //================================ CONVERT TO 12 HOUR ======================================

  String hourConvert({required String hour}) {
    switch (hour) {
      case "5:00":
        return "5:00 - 6:00";
      case "6:00":
        return "6:00 - 7:00";
      case "7:00":
        return "7:00 - 8:00";
      case "8:00":
        return "8:00 - 9:00";
      case "9:00":
        return "9:00 - 10:00";
      case "10:00":
        return "10:00 - 11:00";
      case "11:00":
        return "11:00 - 12:00";
      case "12:00":
        return "12:00 - 1:00";
      case "13:00":
        return "1:00 - 2:00";
      case "14:00":
        return "2:00 - 3:00";
      case "15:00":
        return "3:00 - 4:00";
      case "16:00":
        return "4:00 - 5:00";
      case "17:00":
        return "5:00 - 6:00";
      case "18:00":
        return "6:00 - 7:00";
      case "19:00":
        return "7:00 - 8:00";
      case "20:00":
        return "8:00 - 9:00";
      case "21:00":
        return "9:00 - 10:00";
      case "22:00":
        return "10:00 - 11:00";
      case "23:00":
        return "11:00 - 12:00";
      case "24:00":
        return "12:00 - 1:00";
      default:
        return "1:00 - 2:00";
    }
  }
}
