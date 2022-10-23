import 'package:dio/dio.dart';
import 'package:faux_spot/app/service/endpoints.dart';
import '../../../interceptor/interceptor.dart';

class BookingService {
  void bookingMethod() async {
    Dio dio = await InterceptorHelper().getApiClient();
    Response response = await dio.post(EndPoints.bookTurf);
    if (response.statusCode == 200) {
      print(response.data);
    }
  } 
}
