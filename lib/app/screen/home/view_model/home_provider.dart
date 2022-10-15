import 'package:faux_spot/app/core/images.dart';
import 'package:faux_spot/app/screen/home/model/cateory_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:iconify_flutter/icons/bx.dart';
import 'package:iconify_flutter/icons/emojione_monotone.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/mdi.dart';

class HomeProvider extends ChangeNotifier {
  //============================= SEARCH =================================

  TextEditingController searchController = TextEditingController();

  bool suffixIcon = false;
  void sufixButton({required bool suffixIcon}) {
    this.suffixIcon = suffixIcon;
    notifyListeners();
  }

  //============================= CATEGORY LIST =================================

  List<CategoryModel> categoryList = [
    CategoryModel(
      image: footballImage,
      name: "Football",
      icon: Bx.football,
      width: 150,
    ),
    CategoryModel(
      image: yogaImage,
      name: "Yoga",
      icon: Mdi.yoga,
      width: 120,
    ),
    CategoryModel(
      image: cricketImage,
      name: "Cricket",
      icon: Ic.baseline_sports_cricket,
      width: 140,
    ),
    CategoryModel(
      image: badmintonImage,
      name: "Badminton",
      icon: EmojioneMonotone.badminton,
      width: 170,
    ),
  ];
}
