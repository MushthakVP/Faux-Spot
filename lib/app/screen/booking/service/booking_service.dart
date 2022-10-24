import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:faux_spot/app/service/endpoints.dart';
import '../../../interceptor/interceptor.dart';

class BookingService {
  void bookingMethod({required Map<String, dynamic> data}) async {
    Dio dio = await InterceptorHelper().getApiClient();
    Response response = await dio.post(EndPoints.bookTurf, data: data);
    if (response.statusCode == 200) {
      log(data.toString());
      log(response.data.toString());
    }
  }
}
