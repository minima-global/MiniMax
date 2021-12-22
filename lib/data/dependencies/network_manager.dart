import 'package:dio/dio.dart';

class DioClient {
  late Dio dio;

  DioClient() {
    dio = Dio(
      BaseOptions(
        validateStatus: (int? status) {
          int finalStatus = status ?? -1;
          return finalStatus >= 200 && finalStatus < 300;
        },
      ),
    );
  }
}
