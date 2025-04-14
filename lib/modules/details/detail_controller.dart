import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:movieshub/config/config.dart';
import 'package:share_plus/share_plus.dart';

class DetailController extends BaseController {
  var movieImage = ''.obs;
  var id = 0.obs;
  var title = ''.obs;
  var subtitle = ''.obs;
  var imdb = '280'.obs;
  var rating = 4.5.obs;
  var overview = ''.obs;
  var company = ''.obs;
  var based = ''.obs;
  var connection = true.obs;
  final Connectivity _connectivity = Connectivity();

  dynamic argumentData = Get.arguments;

  List<String> movieGenres = [
    'Action',
    'Comedy',
    'Drama',
    'Sci-Fi',
    'Thriller',
    'Romance',
  ];

  String formattedPosition = '';

  @override
  void onInit() {
    super.onInit();
    checkConnectivity();
    id.value = argumentData['id'] ?? '';
  }

  Future<void> checkConnectivity() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    connection.value = connectivityResult != ConnectivityResult.none;
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    if (connection.value) {
      getMovieDetail(id.value);
    } else {}
  }

  void _updateConnectionStatus(List<ConnectivityResult> connectivityResults) {
    if (connectivityResults.isNotEmpty) {
      connection.value = connectivityResults.first != ConnectivityResult.none;
    } else {
      connection.value = false;
    }
  }

  Future<void> getMovieDetail(int id) async {
    try {
      callApi(apiClient.getMovieDetail(id)).then((value) {
        if (value == null) {
          debugPrint('getMoviesList failed  $value');
          return;
        }

        movieImage.value =
            value.poster_path ?? '/mfT3ok9Z38f0lOw7KbcaMsVFBaq.jpg';
        title.value = value.title ?? '';
        subtitle.value = value.overview;
        overview.value = value.overview ?? '';
        rating.value = (value.vote_average ?? 0) / 2;
        imdb.value = value.vote_average.toString() ?? '0';
        company.value = value.production_companies[0].name;
        based.value = 'This company is based in ${value.production_companies[0].origin_country}';
        debugPrint('data api. :  ${title.value}, ${imdb.value}, ${overview.value}, ${rating.value}');
      });
    } catch (e) {
      debugPrint('getDiscoverData  ::  $e');
    }
  }

  void shareCourse() {
    String text =
        'Check out this amazing study course for students! It\'s a great resource for learning and improving your skills. Download the app now from the following link:\n\nhttps://play.google.com/store/apps/details?id=com.quitify.app';
    Share.share(text);
  }
}

// here im writing for just dummy, today question were asked in flutter related to bloc