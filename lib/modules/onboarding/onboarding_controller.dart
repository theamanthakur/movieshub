import 'package:connectivity_plus/connectivity_plus.dart';

import '../../config/config.dart';

class OnboardingController extends BaseController {
  final onboarding = RxList<OnboardingData>();

  final selectedIndex = 0.obs;
  var connection = true.obs;
  final isConnected = false.obs;
  final noInternet = false.obs;
  final tokenManager = TokenManager();
  final Connectivity _connectivity = Connectivity();
  var tncUrl = '';
  var privacyUrl = '';

  List<OnboardingData> dummyOnboardingData = [
    OnboardingData(
      id: "1a2b3c4d",
      image: 'https://www.originalfilmart.com/cdn/shop/products/titanic_1997_quad_original_film_art_a.webp?v=1674239104',
      image_dark: 'assets/images/movie_rating_1_dark.png',
      title: 'Discover Your Next Favorite Movie',
      description: 'Explore a vast library of movies and find your perfect match based on ratings and reviews.',
    ),
    OnboardingData(
      id: "5e6f7g8h",
      image: 'https://i.etsystatic.com/9516233/r/il/a46baf/619885908/il_570xN.619885908_85aw.jpg',
      image_dark: 'assets/images/movie_rating_2_dark.png',
      title: 'Rate and Review Your Watched Movies',
      description: 'Share your thoughts and opinions on movies you’ve seen, and help others find great films.',
    ),
    OnboardingData(
      id: "9i0j1k2l",
      image: 'https://images-cdn.ubuy.co.in/6630923e911a0522296da4b8-tangled-movie-poster-24inx36in.jpg',
      image_dark: 'assets/images/movie_rating_3_dark.png',
      title: 'Connect with Movie Enthusiasts',
      description: 'Join a community of movie lovers, follow friends, and discover trending films together.',
    ),
    OnboardingData(
      id: "3m4n5o6p",
      image: 'https://i.ebayimg.com/images/g/-qAAAOSwAkJm-uhP/s-l1200.png',
      image_dark: 'assets/images/movie_rating_4_dark.png',
      title: 'Personalized Recommendations Just For You',
      description: 'Get tailored movie suggestions based on your viewing history and preferences.',
    ),

  ];

  void setFirstOpen() {
    appPref.isFirstOpen = false;
  }

  void setOnboardingComplete() {
    appPref.isOnboardingOpen = true;
  }

  @override
  void onInit() {
    super.onInit();
    checkConnectivity();
    tncUrl = appPref.tncLink;
    privacyUrl = appPref.privacyLink;
    onboarding.addAll(dummyOnboardingData);

  }


  Future<void> checkConnectivity() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    connection.value = connectivityResult != ConnectivityResult.none;
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    if (connection.value) {
    } else {}
  }

  void _updateConnectionStatus(List<ConnectivityResult> connectivityResults) {
    if (connectivityResults.isNotEmpty) {
      connection.value = connectivityResults.first != ConnectivityResult.none;
    } else {
      connection.value = false;
    }
  }

}

