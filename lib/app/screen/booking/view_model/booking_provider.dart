import 'package:dio/dio.dart';
import 'package:faux_spot/app/core/colors.dart';
import 'package:faux_spot/app/routes/messenger.dart';
import 'package:faux_spot/app/screen/booking/model/select_model.dart';
import 'package:flutter/material.dart';

class BookingProvider extends ChangeNotifier {
  //=============================== DATE TIME ===============================

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
    addValueInList();
    notifyListeners();
  }

  void addValueInList() {
    selectedList.clear();
    for (int i = 0; i <= 17; i++) {
      selectedList.add(SelectedModel(booked: false, selected: false));
    }
    notifyListeners();
  }

  //=============================== SELECTED LIST ===============================

  void multiSelect(
      {required int index, required bool value, required bool booked}) {
    if (!booked) {
      selectedList.removeAt(index);
      selectedList.insert(index, SelectedModel(booked: false, selected: value));
      notifyListeners();
    } else {
      Messenger.pop(msg: "Already Booked", color: redColor);
    }
  }

  //=============================== BOOKING ===============================

  void addBooking() async {
    String url = "https://fauxspot.herokuapp.com/turf/booking";
    Map<String, dynamic> data = {
      "isBooked": true,
      "user_id": "987488222444444"
    };
    Response response = await Dio().post(url, data: data);
    if (response.statusCode == 200) {
      Messenger.pop(msg: "success");
    }
  }
}
