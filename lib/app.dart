
import 'app_controller.dart';
import 'base/message_helper.dart';
import 'config/config.dart';


class MoviesApp extends StatefulWidget {
  MoviesApp({super.key});

  final controller = Get.put(AppController());
  @override
  State<MoviesApp> createState() => _ConceptAiState();
}

class _ConceptAiState extends State<MoviesApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Movies Hub',
      scaffoldMessengerKey: Get.find<MessageHelper>().messengerKey,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      getPages: AppRoute.pages,
      initialRoute: AppRoute.initial,
      unknownRoute: GetPage(
        name: '/notFound',
        page: () => Scaffold(body: Center(child: Text('notFound'.tr))),
      ),
      builder: (context, widget) => MediaQuery(
        data: context.mediaQuery.copyWith(textScaleFactor: context.mediaQuery.size.width / 375),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: widget ?? Container(),
        ),
      ),
      locale: const Locale('en'),
      supportedLocales: const [
        Locale('en'),
        Locale('hi'),
      ],
    );
  }
}
