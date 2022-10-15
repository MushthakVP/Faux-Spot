import 'dart:developer';

import 'package:faux_spot/app/core/images.dart';
import 'package:faux_spot/app/screen/home/model/cateory_model.dart';
import 'package:faux_spot/app/screen/home/service/location.dart';
import 'package:flutter/cupertino.dart';
import 'package:iconify_flutter/icons/bx.dart';
import 'package:iconify_flutter/icons/emojione_monotone.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:provider/provider.dart';
import '../model/home_model.dart';

class HomeProvider extends ChangeNotifier {
  //============================= SEARCH =================================

  TextEditingController searchController = TextEditingController();

  bool suffixIcon = false;
  void suffixButton({required bool suffixIcon, required BuildContext context}) {
    if (!suffixIcon) {
      searchList.clear();
      searchController.clear();
      FocusScope.of(context).unfocus();
    }
    this.suffixIcon = suffixIcon;
    notifyListeners();
  }

  List<DataList> searchList = [];
  bool initSearching = false;

  void searchFilter(
      {required BuildContext context, required String query}) async {
    initSearching = true;
    notifyListeners();
    List<DataList> list = context.read<GetUserLocation>().turfList;

    if (query.isEmpty) {
      searchList = list;
    } else {
      searchList = list
          .where(
            (element) => element.turfName!.toLowerCase().contains(
                  query.toLowerCase().trim(),
                ),
          )
          .toList();
    }
    log(searchList.length.toString());
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
