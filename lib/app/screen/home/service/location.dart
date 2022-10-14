import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:faux_spot/app/routes/messenger.dart';
import 'package:faux_spot/app/service/endpoints.dart';
import 'package:faux_spot/app/service/error.dart';
import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';
import '../../../interceptor/interceotor.dart';
import '../../../routes/routes.dart';
import '../model/home_model.dart';
import '../model/location_model.dart';
import '../view/home_view.dart';

class GetUserLoction extends ChangeNotifier {
  GetUserLoction() {
    _location = Location();
  }

  String? userLocation;
  String? userDistrict;
  String? userMuncipality;
  bool isLoaidng = false;

  Location? _location;
  Location? get location => _location;
  getUserLocation({bool? checkScreen}) async {
    turfListLoading = true;
    isLoaidng = true;
    notifyListeners();
    bool serviceEnabled;
    PermissionStatus permissionGrantend;

    serviceEnabled = await location!.serviceEnabled();

    if (!serviceEnabled) {
      serviceEnabled = await location!.requestService();
      if (!serviceEnabled) {}
    }
    permissionGrantend = await location!.hasPermission();
    if (permissionGrantend == PermissionStatus.denied) {
      permissionGrantend = await location!.requestPermission();
      if (permissionGrantend != PermissionStatus.granted) {}
    }

    try {
      isLoaidng = true;
      LocationData locationData = await location!.getLocation();

      double latitude = locationData.latitude!;
      double longitude = locationData.longitude!;
      Response response = await Dio().get(
          "https://api.mapbox.com/geocoding/v5/mapbox.places/$longitude,$latitude.json?types=locality%2Cdistrict&limit=1&access_token=${EndPoints.apiKey}");
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        final userData = LocationRespones.fromJson(response.data);
        userMuncipality =
            userData.features!.first.context!.first.text.toString();
        userDistrict = userData.features!.first.context![1].text.toString();
        String placeLocation =
            userData.features!.first.placeName!.split(",").first;
        String muncipality = userData.features!.first.placeName!.split(",")[1];
        getHomeData(muncipality);
        userLocation = "$placeLocation, $muncipality";
        isLoaidng = false;
        notifyListeners();
        if (checkScreen != null) {
          Routes.pushRemoveUntil(screen: const HomeView());
        }
      }
    } catch (e) {
      isLoaidng = false;
      notifyListeners();
      Messenger.pop(msg: handleError(e));
    }
  }

  //=========================== GET NEAREST LOCATION DATA ===============================

  bool turfListLoading = false;

  List<DataList> turfList = [];

  void getHomeData(String muncipality) async {
    log(EndPoints.nearestTurf.replaceFirst('{spot}', muncipality.trim()));
    try {
      Dio dio = await InterceptorHelper().getApiClient();
      Response response = await dio.get(
          EndPoints.nearestTurf.replaceFirst('{spot}', muncipality.trim()));
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        HomeRespones data = HomeRespones.fromJson(response.data);
        turfList.addAll(data.data!);
        turfListLoading = false;
        notifyListeners();
      }
    } catch (e) {
      turfListLoading = false;
      notifyListeners();
      Messenger.pop(msg: handleError(e));
    }
  }
}
