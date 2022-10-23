
import 'package:dio/dio.dart';
import 'package:faux_spot/app/routes/routes.dart';
import 'package:faux_spot/app/screen/overview/model/booking_response.dart';
import '../../../interceptor/interceptor.dart';
import '../../../service/endpoints.dart';
import '../../../service/error.dart';
import '../../home/view/home_view.dart';
import '../../internet/view/internet_view.dart';

class OverviewService {

  Future<BookingResponse?> getBookingList({required String id}) async {
    bool network = await checking();
    if(network){
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
    }else{
      Routes.pushreplace(screen: const NoInternet(screen: HomeView()));
    }
    return null;
  }
}
