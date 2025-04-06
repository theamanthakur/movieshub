// import 'package:cpa_ai/data/preference/local_database.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'base/message_helper.dart';
import 'data/network/network_module.dart';
import 'data/preference/app_pref.dart';

/// init all dependencies
Future<void> initDependencies() async {
  // await Get.put(DataPersistence(), permanent: true).init();
  Get
    ..put(AppPref(await SharedPreferences.getInstance()), permanent: true)
    ..put(MessageHelper(), permanent: true)
    ..lazyPut(NetworkModule.prepareDio, fenix: true)
    ..lazyPut(NetworkModule.getApiClient, fenix: true);
}