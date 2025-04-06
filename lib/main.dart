import 'package:flutter/material.dart';

import 'app.dart';
import 'config/config.dart';
import 'init_dependencies.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  // await ConnectivityService().initialize();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColor.transparent
  ));

  if (!kDebugMode) {
    debugPrint = (message, {wrapWidth}) {};
  }

  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // print('platform of device :::   ${DefaultFirebaseOptions.currentPlatform}');
  //
  // FcmApi().initNotification();


  // enable app must in portrait mode
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await initDependencies();

  runApp(MoviesApp());
}
