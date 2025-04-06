import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:movieshub/config/config.dart';

import '../../utils/widgets/app_loader.dart';

class SearchControllerApp extends BaseController{
  final SearchController searchController = SearchController();
  final query = "".obs;
  final Connectivity _connectivity = Connectivity();
  var connection = true.obs;
  final listMoviesSearch = RxList<MovieResult>();
  final focusNode = FocusNode();


  @override
  void onReady() {
    super.onReady();
    // FocusScope.of(Get.context!).focusedChild();
    checkConnectivity();
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



  Future<void> getSearchResult(String query) async {
    try {
      callApi(apiClient.getSearchQuery(query)).then((value) {
        if (value?.results.isEmpty ?? false) {
          debugPrint('getMoviesList failed  ${value?.total_results}');

          return;
        }
        listMoviesSearch.clear();
        listMoviesSearch.addAll(value?.results ?? []);

      });
    } catch (e) {

      debugPrint('getDiscoverData  ::  $e');
    }
  }

}