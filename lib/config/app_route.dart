import 'package:movieshub/modules/details/detail_screen.dart';
import 'package:movieshub/modules/onboarding/onboarding_screen.dart';
import 'package:movieshub/modules/search/search_screen.dart';

import '../modules/home/home_screen.dart';
import '../modules/home/scanner_screen.dart';
import '../modules/login/login_screen.dart';
import 'config.dart';


abstract class AppRoute {
  static String get initial {
    final appPref = Get.find<AppPref>();
    if (appPref.isOnboardingOpen) {
      return appPref.isUserLogin ? home : login;
    } else {
      return onboarding;
    }
  }

  // home
  static const home = '/home';

  static const login = '/login';
  static const scanner = '/scanner';
  static const search = '/search';

  static const conversations = '/conversations';
  static const chat = '/chat';
  static const details = '/details';
  static const onboarding = '/onboarding';


  static final pages = <GetPage>[
    GetPage(name: home, page: HomeScreen.new),
    //
    // // // login
    GetPage(name: login, page: LoginScreen.new),
    GetPage(name: onboarding, page: OnboardingScreen.new),
    GetPage(name: scanner, page: BarcodeScannerScreen.new),
    GetPage(name: search, page: SearchScreen.new),
    GetPage(name: details, page: DetailScreen.new),


  ];
}
