import 'dart:io';
import 'package:dio/dio.dart';
import '../../config/config.dart';
import '../../utils/widgets/app_loader.dart';

class HomeController extends BaseController{

  final listMoviesNow = RxList<MovieResult>();
  final listMoviesTop = RxList<MovieResult>();
  final listMoviesUp = RxList<MovieResult>();
  final listMoviesPop = RxList<MovieResult>();


  final bannerImages = RxList<String>();
  final listMovieType = RxList<String>();
  final listDailyNotes = RxList<String>();
  final dio = Dio();
  final tokenManager = TokenManager();
  final textGenerated = false.obs;
  final taskAnswer = ''.obs;
  List<String> movieGenres = [
    'Action',
    'Comedy',
    'Horror',
    'Sci-Fi',
    'Drama',
    'Thriller',
    'Fantasy',
    'Romance',
    'Western',
    'Mystery',
  ];

  var selectedMovie = "".obs;

  @override
  void onInit() {
    super.onInit();
    listMovieType.addAll(movieGenres);
    // initYoutubePlayer('IKrdUpBkaZw');
  }

  // Future<void> requestPermissions() async {
  //   if (Platform.isAndroid) {
  //     await Permission.storage.request();
  //   }
  // }


  @override
  Future<void> onReady() async {
    var listImages = [Assets.images.bn1.path, Assets.images.bn2.path,
      Assets.images.bn3.path, Assets.images.bn4.path];
    bannerImages.addAll(listImages);

    var listNotes = ['Chapter 1','Energy and Power','World War 2','दो बैलों की कथा',];
    listDailyNotes.addAll(listNotes);
    await getMoviesList();
    await getTopRatedMovies();
    await getPopularMovies();
    await getUpcomingMovies();
    taskAnswer.value = 'Newton’s First Law of Motion, also known as the Law of Inertia, is a fundamental principle that describes the behaviour of objects in the absence of external influences. The term “Law of Inertia” emphasizes the concept of inertia, which refers to the property of massive objects to resist changes in their state of motion. This idea stems from the observation that objects naturally maintain their current state of rest or motion, resisting any changes unless acted upon by an external force. By naming the first law of motion the “Law of Inertia,” Newton highlighted this inherent property of objects and laid the groundwork for understanding how forces can cause changes in motion. Newton’s first law of motion states that objects persist in their current state of motion unless compelled to do otherwise by an external force. Whether an object is at rest or in uniform motion, it will continue in that state unless a net external force acts upon it. One crucial insight provided by Newton’s First Law is that the object will maintain a constant velocity in the absence of a net force resulting from unbalanced forces acting on an object. If the object is already in motion, it will continue moving at the same speed and direction. Likewise, if the object is at rest, it will remain stationary. However, introducing an additional external force will cause the object’s velocity to change, responding to the magnitude and direction of the force applied. Understanding Newton’s First Law of Motion sets the stage for a deeper exploration of the subsequent laws that govern the complexities of motion. By comprehending this fundamental principle, we gain crucial insights into how objects behave independently and how external forces influence their motion. The first law of motion provides a strong foundation for further understanding the dynamics and behaviour of objects in the physical world.';
    selectedMovie.value = listMovieType[0];
    super.onReady();
  }


  Future<void> getMoviesList() async {
    try {
      showAppLoader(loaderTopPadding: 0);
      callApi(apiClient.getMoviesList('1')).then((value) {
        if (value?.results.isEmpty ?? false) {
          debugPrint('getMoviesList failed  ${value?.total_results}');
          dismissAppLoader();
          return;
        }

        listMoviesNow.addAll(value?.results ?? []);
        dismissAppLoader();
      });
    } catch (e) {
      dismissAppLoader();
      debugPrint('getDiscoverData  ::  $e');
    }
  }

  Future<void> getPopularMovies() async {
    try {
      showAppLoader(loaderTopPadding: 0);
      callApi(apiClient.getPopularMovies('3')).then((value) {
        if (value?.results.isEmpty ?? false) {
          debugPrint('getMoviesList failed  ${value?.total_results}');
          dismissAppLoader();
          return;
        }

        listMoviesPop.addAll(value?.results ?? []);
        dismissAppLoader();
      });
    } catch (e) {
      dismissAppLoader();
      debugPrint('getDiscoverData  ::  $e');
    }
  }

  Future<void> getTopRatedMovies() async {
    try {
      showAppLoader(loaderTopPadding: 0);
      callApi(apiClient.getTopRatedMovies('1')).then((value) {
        if (value?.results.isEmpty ?? false) {
          debugPrint('getMoviesList failed  ${value?.total_results}');
          dismissAppLoader();
          return;
        }

        listMoviesTop.addAll(value?.results ?? []);
        dismissAppLoader();
      });
    } catch (e) {
      dismissAppLoader();
      debugPrint('getDiscoverData  ::  $e');
    }
  }

  Future<void> getUpcomingMovies() async {
    try {
      showAppLoader(loaderTopPadding: 0);
      callApi(apiClient.getUpcomingMovies('2')).then((value) {
        if (value?.results.isEmpty ?? false) {
          debugPrint('getMoviesList failed  ${value?.total_results}');
          dismissAppLoader();
          return;
        }

        listMoviesUp.addAll(value?.results ?? []);
        dismissAppLoader();
      });
    } catch (e) {
      dismissAppLoader();
      debugPrint('getDiscoverData  ::  $e');
    }
  }

}