import 'package:faux_spot/app/screen/favorite/service/favorite_service.dart';
import 'package:flutter/cupertino.dart';
import '../model/wishlist_model.dart';

class FavoriteProvider extends ChangeNotifier {

  FavoriteProvider(){
    fetchData();
  }

  //================================ FETCH DATA ======================================

  List<FavoriteData> favoriteList = [];

  bool isLoading = false;

  void fetchData() async {
    favoriteList.clear();
    isLoading = true;
    notifyListeners();
    FavoriteModel? response = await FavoriteService().fetchFavorite();
    if (response != null) {
      favoriteList.addAll(response.data!);
      isLoading = false;
      notifyListeners();
    }
  }
}
