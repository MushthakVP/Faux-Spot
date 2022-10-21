
import 'package:dio/dio.dart';
import 'package:faux_spot/app/core/colors.dart';
import 'package:faux_spot/app/routes/messenger.dart';
import 'package:faux_spot/app/screen/home/model/home_model.dart';
import 'package:faux_spot/app/service/endpoints.dart';
import 'package:faux_spot/app/service/error.dart';
import '../../../interceptor/interceotor.dart';

class HomeService {
  void addWishlist(HomeResponse data) async {
    try {
      Dio dio = await InterceptorHelper().getApiClient();
      Response response =
          await dio.post(EndPoints.addWishlist, data: data.toJson());
          if(response.statusCode! >= 200 && response.statusCode! <=299 ){
            Messenger.pop(msg: "Submitted" , color: greenColor);
          }
    } catch (e) {
      Messenger.pop(msg: handleError(e));
    }
  }
}
