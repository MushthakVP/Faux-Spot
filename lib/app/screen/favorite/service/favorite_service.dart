import 'package:dio/dio.dart';
import 'package:faux_spot/app/routes/messenger.dart';
import 'package:faux_spot/app/service/endpoints.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../interceptor/interceptor.dart';
import '../../../service/error.dart';
import '../model/wishlist_model.dart';

class FavoriteService {
  final storage = const FlutterSecureStorage();
  Future<FavoriteModel?> fetchFavorite() async {
    String? userId = await storage.read(key: 'id');
    Dio dio = await InterceptorHelper().getApiClient();
    try {
      Response response =
          await dio.get(EndPoints.getWishlist.replaceFirst("{id}", userId!));
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        return FavoriteModel.fromJson(response.data);
      }
    } catch (e) {
      Messenger.pop(msg: handleError(e));
    }
    return null;
  }
}
