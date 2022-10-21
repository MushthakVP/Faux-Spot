import 'package:dio/dio.dart';

String handleError(e) {
  String defaultApiError = 'Something went wrong!';
  String networkError = 'No connection';

  if (e is DioError) {
    if (e.response == null) {
      return networkError;
    } else if (e.type == DioErrorType.connectTimeout ||
        e.type == DioErrorType.receiveTimeout ||
        e.type == DioErrorType.sendTimeout) {
      return networkError;
    } else if (e.type == DioErrorType.response) {
      if (e.response!.statusCode == 401) {
        return e.response?.data["message"];
      } else {
        return defaultApiError;
      }
    }
  }
  return defaultApiError;
}

const String apiKey =
    "pk.eyJ1IjoibXVzaHRoYWsiLCJhIjoiY2w5OXU0amMzMGduYzN2bzZ5emoyYzQwYiJ9.7aGijhiDoQ4srpQiV3fW5g";
