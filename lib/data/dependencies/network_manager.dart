import 'package:dio/dio.dart';

const String _baseUrl = "https://incentivecash.minima.global";

class DioClient {
  late Dio dio;

  DioClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        validateStatus: (int? status) {
          int finalStatus = status ?? -1;
          return finalStatus >= 200 && finalStatus < 300;
        },
      ),
    );
  }
}
