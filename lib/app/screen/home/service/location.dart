import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:faux_spot/app/routes/messenger.dart';
import 'package:faux_spot/app/screen/home/model/whishlist.dart';
import 'package:faux_spot/app/service/endpoints.dart';
import 'package:faux_spot/app/service/error.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:location/location.dart';
import '../../../interceptor/interceotor.dart';
import '../../../routes/routes.dart';
import '../model/home_model.dart';
import '../model/location_model.dart';
import '../view/home_view.dart';

class GetUserLocation extends ChangeNotifier {

  final storage = const FlutterSecureStorage();

  //=========================== GET NEAREST LOCATION ===============================

  GetUserLocation() {
    _location = Location();
  }

  String? userLocation;
  String? userDistrict;
  String? userMunicipality;
  bool isLoading = false;

  Location? _location;
  Location? get location => _location;
  getUserLocation({bool? checkScreen}) async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location!.serviceEnabled();

    if (!serviceEnabled) {
      serviceEnabled = await location!.requestService();
      if (!serviceEnabled) {}
    }
    permissionGranted = await location!.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location!.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {}
    }

    turfListLoading = true;
    isLoading = true;
    notifyListeners();
    if (checkScreen != null) {
      log("======================");
      Routes.pushRemoveUntil(screen: const HomeView());
    }
    getWishlist();

    try {
      isLoading = true;
      LocationData locationData = await location!.getLocation();

      double latitude = locationData.latitude!;
      double longitude = locationData.longitude!;
      Response response = await Dio().get(
          "https://api.mapbox.com/geocoding/v5/mapbox.places/$longitude,$latitude.json?types=locality%2Cdistrict&limit=1&access_token=$apiKey");
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        final userData = LocationResponse.fromJson(response.data);
        userMunicipality =
            userData.features!.first.context!.first.text.toString();
        userDistrict = userData.features!.first.context![1].text.toString();
        String placeLocation =
            userData.features!.first.placeName!.split(",").first;
        String municipality = userData.features!.first.placeName!.split(",")[1];
        getHomeData(userDistrict!);
        userLocation = "$placeLocation, $municipality";
        isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      Messenger.pop(msg: handleError(e));
    }
  }

  //=========================== GET NEAREST LOCATION TURF ===============================

  bool turfListLoading = false;

  List<DataList> turfList = [];

  void getHomeData(String municipality) async {
    turfList.clear();
    try {
      Dio dio = await InterceptorHelper().getApiClient();
      log("===============================================");
      Response response = await dio.get(
          EndPoints.nearestTurf.replaceFirst('{spot}', municipality.trim()));
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        HomeResponse data = HomeResponse.fromJson(response.data);
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

  //=========================== GET WISHLIST ===============================

  List<HomeWishlist> homeWishlist = [];

  bool whishlistLoading = false;

  void getWishlist() async {
    whishlistLoading = true;
    notifyListeners();
    String? id =  await storage.read(key: "id");
    try {
       Dio dio = await InterceptorHelper().getApiClient();
    Response response = await dio.get(EndPoints.getWishlist.replaceFirst("{id}", id!));
    if(response.statusCode! >= 200 && response.statusCode! <= 299){
      HomeWishlist data = HomeWishlist.fromJson(response.data);
      homeWishlist.add(data);
      whishlistLoading = false;
      notifyListeners();
    }
    } catch (e) {
      Messenger.pop(msg: handleError(e));
         whishlistLoading = false;
      notifyListeners();
    }
   
  }
}
