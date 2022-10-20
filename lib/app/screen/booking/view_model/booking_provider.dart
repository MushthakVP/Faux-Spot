import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:faux_spot/app/core/colors.dart';
import 'package:faux_spot/app/routes/messenger.dart';
import 'package:faux_spot/app/screen/booking/model/select_model.dart';
import 'package:faux_spot/app/screen/home/model/home_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class BookingProvider extends ChangeNotifier {
  final storage = const FlutterSecureStorage();

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

  List<int> multiList = [];

  void findMultiSelectCount() {
    multiList.clear();
    for (int i = 0; i <= 17; i++) {
      if (selectedList[i].selected) {
        multiList.add(i);
      }
    }
    log(multiList.toString());
  }

  void addBooking({required DataList list}) async {
    findMultiSelectCount();
    String? userId = await storage.read(key: "id");
    if (multiList.isEmpty) {
      Messenger.pop(msg: "Select Slot", color: redColor);
      return;
    }

    String url = "https://fauxspot.herokuapp.com/account/add-booking";
    Map<String, dynamic> data = {
      "booking_status": true,
      "user_id": userId,
      "turf_index": multiList,
      "turf_id": list.id,
      "booking_price": list.turfTime!.timeAfternoon!,
      "booking_date": date.toIso8601String(),
    };
    try {
      Response response = await Dio().post(url, data: data);
      if (response.statusCode == 200) {
        log("message");
        Messenger.pop(msg: "success");
      }
    } catch (e) {
      if (e is DioError) {
        log(e.response!.data["message"].toString());
      }
      log(e.toString());
    }
  }
}
