import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';

import '../config/config.dart';
import '../data/network/api_client.dart';
import '../data/preference/app_pref.dart';
import '../utils/widgets/app_loader.dart';
import 'message_helper.dart';

typedef CanHandleException = Future<bool> Function(DioError error);

class BaseController extends GetxController {
  MessageHelper get messageHelper => Get.find<MessageHelper>();

  AppPref get appPref => Get.find<AppPref>();

  ApiClient get apiClient => Get.find<ApiClient>();

  final streams = <StreamSubscription?>[];

  void hideMessage() => messageHelper.hide();

  void showError(String message, {Duration? duration}) => messageHelper.showError(message, duration: duration);

  void showInfo(String message, {Duration? duration}) => messageHelper.showInfo(message, duration: duration);

  void showWarn(String message, {Duration? duration}) => messageHelper.showWarn(message, duration: duration);

  void showSuccess(String message, {Duration? duration}) => messageHelper.showSuccess(message, duration: duration);

  @override
  void onClose() {
    for (final item in streams) {
      item?.cancel();
    }
    super.onClose();
  }

  Future<T?> callApi<T>(
    Future<T> request, {
    bool showLoader = false,
    double? loaderTopPadding,
    CanHandleException? canHandleException,
    bool rethrowError = false,
  }) async {
    try {
      if (showLoader) showAppLoader(loaderTopPadding: loaderTopPadding);
      final response = await request;
      if (showLoader) dismissAppLoader();
      return response;
    } on DioError catch (dioError) {
      if (showLoader) dismissAppLoader();

      if (canHandleException != null) {
        final result = await canHandleException(dioError);
        if (!result) {
          onResponseError(dioError);
        }
      } else {
        onResponseError(dioError);
      }
    } catch (error) {
      if (showLoader) dismissAppLoader();
      if (rethrowError) rethrow;
      debugPrint('callApi :: Error -> $error');
    }
    return null;
  }

  void onResponseError(DioError error) {
    debugPrint('onResponseError:onError ${error.toString()} || ${error.response?.statusCode}');

    if (error.type == DioErrorType.unknown && error.error is SocketException) {
      // warningDialog('widget_warningDialog_text_noInternet'.tr);
      return;
    }

    switch (error.response?.statusCode) {
      case 400:
      case 401:
      case 403:
      case 404:
      case 405:
      case 408:
      case 423:
      case 426:
      case 429:
        final errorKey = error.response?.data?['error'] as String? ?? '';
        final errorMessage = error.response?.data?['errorMessage'] as String?;
        // if (errorKey == 'token_expired') {
        //   warningDialog('widget_warningDialog_text_sessionExpiresLoginAgain'.tr);
        //   CommonFun.doLogout();
        // } else if (errorKey == 'too_many_attempts_settings') {
        //   warningDialog(errorMessage ?? errorKey.tr).then((value) => CommonFun.doLogout());
        // } else {
        //   final withContactCustomer = errorKey == 'invalid_credentials' || errorKey == 'too_many_attempts';
        //   warningDialog(errorMessage ?? errorKey.tr, withContactCustomer: withContactCustomer);
        // }
        break;
      case 422:
        final errors = error.response?.data?['errors'] as Map?;
        // if (errors != null) {
        //   final list = <dynamic>[];
        //   for (final element in errors.values ?? []) {
        //     list.addAll(element as List<dynamic>);
        //   }
        //   warningDialog(list.join('\n'));
        // } else {
        //   final errorKey = error.response?.data?['error'] as String? ?? '';
        //   final errorMessage = error.response?.data?['errorMessage'] as String?;
        //   warningDialog(errorMessage ?? errorKey.tr);
        // }
        break;
      case 500:
        final msg = error.response?.data?['message'] as String?;
        showError(msg ?? 'widget_warningDialog_text_internalServerError'.tr);
        break;
      case 406:
      case 409:
        break;
      default:
        // warningDialog('Something went wrong...');
        break;
    }
  }
}
