import 'dart:developer';
import 'dart:io';

import '../../config/config.dart';
import '../../data/network/api_client.dart';
import '../../data/network/petty_dio_logger.dart';
import 'package:dio/dio.dart';
import 'auth_interceptor.dart';


// live
// const String baseURL = 'https://fakestoreapi.com/';
const String baseURL = 'https://api.themoviedb.org/3/';


abstract class NetworkModule {
  static Dio prepareDio() {
    var dio = Dio();

    var appPref = Get.find<AppPref>();

    var inDebugMode = kDebugMode;
    var isTokenPrinted = false;

    dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions option, RequestInterceptorHandler handler) async {
      var customHeaders = {
        'accept': 'application/json',
      };
      option.headers.addAll(customHeaders);

      if (inDebugMode && !isTokenPrinted) {
        debugPrint('api call header  ::: ${option.headers} and $customHeaders');
        // isTokenPrinted = true;
      }
      handler.next(option);
    }));

    dio.interceptors.add(AuthInterceptor());

    if (!kReleaseMode) {
      var logger = PrettyDioLogger(maxWidth: 450);
      dio.interceptors.add(logger);
    }

    return dio;
  }

  static ApiClient getApiClient() => ApiClient(Get.find<Dio>(), baseUrl: baseURL);
}
