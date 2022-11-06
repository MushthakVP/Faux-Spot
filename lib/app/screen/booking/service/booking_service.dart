import 'package:dio/dio.dart';
import 'package:faux_spot/app/service/endpoints.dart';
import 'package:faux_spot/app/service/error.dart';
import '../../../interceptor/interceptor.dart';

class BookingService {
  Future<List<dynamic>?> bookingMethod({required Map<String, dynamic> data}) async {
    try {
      Dio dio = await InterceptorHelper().getApiClient();
      Response response = await dio.post(EndPoints.bookTurf, data: data);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return [true, "Booking Successful"];
      }
    } catch (e) {
      return [false, handleError(e)];
    }
    return [false, "Something went wrong"];
  }
}
