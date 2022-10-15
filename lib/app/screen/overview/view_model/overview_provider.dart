import 'package:flutter/cupertino.dart';

class OverViewProvider extends ChangeNotifier {
  //================================ APPBAR IMAGE ================================//

  String appbarImage = "";

  void changeAppbarImage({required String image}) {
    appbarImage = image;
    notifyListeners();
  }
}
