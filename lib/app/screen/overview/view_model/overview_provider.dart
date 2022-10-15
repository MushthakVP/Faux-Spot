import 'package:flutter/cupertino.dart';
import 'package:iconify_flutter/icons/ant_design.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/map.dart';
import 'package:iconify_flutter/icons/ri.dart';
import '../model/amenities_model.dart';

class OverViewProvider extends ChangeNotifier {
  //================================ APPBAR IMAGE ================================//

  String appbarImage = "";

  void changeAppbarImage({required String image}) {
    appbarImage = image;
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
