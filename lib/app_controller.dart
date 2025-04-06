import 'dart:io';
import 'package:android_id/android_id.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'config/config.dart';

class AppController extends BaseController{

  var isLogin = false;
  var isPrefOpen = false;
  final tokenManager = TokenManager();
  var internetConnection = false.obs;
  final dio = Dio();
  final Connectivity _connectivity = Connectivity();

  @override
  Future<void> onInit() async {
    super.onInit();

    SystemChannels.textInput.invokeMethod('TextInput.hide');

  }

  @override
  void onReady() {
    super.onReady();

    Future.wait(
      [
        checkConnectivity(),
        _getDeviceInfo(),
      ],
    ).then((value) async {
      if (AppGlobal.deviceId.isNotEmpty) {
        await tokenManager.saveAccessToken('eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiMGYyMzE4ZTRiMmY2Y2IxNTAyN2FlYTdiZjIxOWQ4MSIsIm5iZiI6MTc0Mzc0NTk2OC4yMywic3ViIjoiNjdlZjczYjBlZGU4ZDgyZjNiYWQwMzU1Iiwic2NvcGVzIjpbImFwaV9yZWFkIl0sInZlcnNpb24iOjF9.7ZD_oS60-QcVs8k67VR28K2IZCkyEUK8GDknA9yy6S0');
        //  We can call APIs where device id is needed for so many reasons
      }
    });
  }

  Future<void> checkConnectivity() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    internetConnection.value = connectivityResult != ConnectivityResult.none;
    if (!internetConnection.value) {}
  }

  Future<void> _getDeviceInfo() async {
    final deviceInfoPlugin = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final info = await deviceInfoPlugin.androidInfo;
      AppGlobal.androidApiVersion = info.version.sdkInt;
      AppGlobal.deviceName = '${info.brand} ${info.model}';
      AppGlobal.deviceOsVersion = info.version.release;
      AppGlobal.deviceId = (await const AndroidId().getId()) ?? '';

      info.data.addAll({'systemName': 'Android'});
      info.data.remove('systemFeatures');
      AppGlobal.deviceInfo.addAll(info.data);

    } else if (Platform.isIOS) {
      final info = await deviceInfoPlugin.iosInfo;
      AppGlobal.deviceId = info.identifierForVendor ?? '';
      AppGlobal.deviceName = info.utsname.machine;
      AppGlobal.deviceOsVersion = info.systemVersion;

      AppGlobal.deviceInfo.addAll(info.data);
      debugPrint(' device id in ios before ::  ${AppGlobal.deviceId}');
    }
  }

  void navigateScreen() {
    String nextRoute;
    if (checkFirstOpen()) {
      nextRoute = AppRoute.login;
    } else {
      nextRoute = appPref.isPrefOpen ? AppRoute.login : AppRoute.login;
    }

    Get.offAllNamed(nextRoute);
  }

  bool checkFirstOpen() {
    final isOpen = appPref.isFirstOpen;
    return isOpen;
  }
}