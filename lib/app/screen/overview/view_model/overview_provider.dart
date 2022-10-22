import 'dart:developer';
import 'package:faux_spot/app/routes/messenger.dart';
import 'package:faux_spot/app/screen/home/model/home_model.dart';
import 'package:faux_spot/app/screen/overview/service/overview_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:iconify_flutter/icons/ant_design.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/map.dart';
import 'package:iconify_flutter/icons/ri.dart';
import '../model/amenities_model.dart';
import '../model/booking_response.dart';

class OverViewProvider extends ChangeNotifier {
  //================================ APPBAR IMAGE ================================//

  String appbarImage = "";

  void changeAppbarImage({required String image}) {
    appbarImage = image;
    notifyListeners();
  }

  //================================ GET BOOKING DATA ================================//

  List<BookingList> bookingList = [];
  bool isLoading = false;

  void getBookingData({required DataList list}) async {
    bookingList.clear();
    isLoading = true;
    notifyListeners();
    BookingResponse? response = await OverviewService().getBookingList(id: list.id!);
    if(response != null){
      if(response.status!){
        bookingList.addAll(response.data!);
        log("success brooking ");
        log(bookingList.length.toString());
      }else{
        Messenger.pop(msg: response.message!);
      }
    }else{
      Messenger.pop(msg: response!.message!);
    }
    isLoading = false;
    notifyListeners();
  }

  //================================ AMENITIES LIST ================================//

  List<Amenities> amenitiesList = [
    Amenities(name: "Parking", icon: AntDesign.car_outline),
    Amenities(name: "Gallery", icon: Ic.round_stadium),
    Amenities(name: "Water", icon: Ri.water_flash_fill),
    Amenities(name: "Dressing", icon: Ri.shirt_fill),
    Amenities(name: "Washroom", icon: Map.toilet),
    Amenities(name: "Cafeteria", icon: Ic.baseline_local_cafe),
  ];
}
