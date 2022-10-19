import 'dart:developer';
import 'package:faux_spot/app/core/images.dart';
import 'package:faux_spot/app/screen/home/model/cateory_model.dart';
import 'package:faux_spot/app/screen/home/service/home_service.dart';
import 'package:faux_spot/app/screen/home/service/location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:iconify_flutter/icons/bx.dart';
import 'package:iconify_flutter/icons/emojione_monotone.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:provider/provider.dart';
import '../model/home_model.dart';

class HomeProvider extends ChangeNotifier {
  final storage = const FlutterSecureStorage();
  PageController scrollController = PageController();

  //============================= BOTTOM BAR =================================

  int index = 0;
  changeBottomIndex({required int index}) {
    this.index = index;
    notifyListeners();
  }

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

  //============================= ADDED FAVORITE =================================

  void addToFavorite(DataList data) async {
    String? userId = await storage.read(key: "id");
    log(userId.toString());
    HomeResponse response = HomeResponse(
      userId: userId,
      data: [
        DataList(
          id: data.id,
          turfName: data.turfName,
          turfPlace: data.turfPlace,
          turfCreatorId: data.turfCreatorId,
          turfDistrict: data.turfDistrict,
          turfMunicipality: data.turfMunicipality,
          turfAmenities: TurfAmenities(
            turfCafeteria: data.turfAmenities!.turfCafeteria,
            turfDressing: data.turfAmenities!.turfDressing,
            turfParking: data.turfAmenities!.turfParking,
            turfGallery: data.turfAmenities!.turfGallery,
            turfWashroom: data.turfAmenities!.turfWashroom,
            turfWater: data.turfAmenities!.turfWater,
          ),
          turfCategory: TurfCategory(
            turfBadminton: data.turfCategory!.turfBadminton,
            turfCricket: data.turfCategory!.turfCricket,
            turfFootball: data.turfCategory!.turfFootball,
            turfYoga: data.turfCategory!.turfYoga,
          ),
          turfImages: TurfImages(
            turfImages1: data.turfImages!.turfImages1,
            turfImages2: data.turfImages!.turfImages2,
            turfImages3: data.turfImages!.turfImages3,
          ),
          turfInfo: TurfInfo(
            turfIsAvailable: data.turfInfo!.turfIsAvailable,
            turfMap: data.turfInfo!.turfMap,
            turfRating: data.turfInfo!.turfRating,
          ),
          turfTime: TurfTime(
            timeAfternoon: data.turfTime!.timeAfternoon,
            timeEvening: data.turfTime!.timeEvening,
            timeMorning: data.turfTime!.timeMorning,
          ),
          turfType: TurfType(
            turfSevens: data.turfType!.turfSevens,
            turfSixes: data.turfType!.turfSixes,
          ),
        ),
      ],
    );
    HomeService().addWishlist(response);
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
