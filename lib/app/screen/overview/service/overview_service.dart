import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:faux_spot/app/screen/overview/model/booking_response.dart';
import '../../../interceptor/interceptor.dart';
import '../../../service/endpoints.dart';
import '../../../service/error.dart';

class OverviewService {
  Future<BookingResponse?> getBookingList({required String id}) async {
    log(id);
    try {
      Dio dio = await InterceptorHelper().getApiClient();
      Response response =
          await dio.get(EndPoints.bookingDetail.replaceFirst("{id}", id.trim()));
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return BookingResponse.fromJson(response.data);
      }
    } catch (e) {
      BookingResponse(status: false, message: handleError(e));
    }
    return null;
  }
}
