import 'package:dio/dio.dart';
import '../../config/config.dart';
import 'api_client.dart';

class AuthInterceptor extends QueuedInterceptor {
  AppPref get appPref => Get.find<AppPref>();
  final refreshDio = Dio();

  // var dio = Dio();
  // final semaphore = LocalSemaphore(1);

  final tokenManager = TokenManager();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    var accessToken = (await tokenManager.readAccessToken()) ?? '';
    debugPrint('access token before adding  ::  $accessToken');
    options.headers['Authorization'] = 'Bearer $accessToken';
    handler.next(options);
  }
}
