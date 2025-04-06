import '../../data/model/models.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  @GET("https://fakestoreapi.com/products")
  Future<List<Product>> products();

  @GET("movie/now_playing?language=en-US&{page}")
  Future<MovieListResponse> getMoviesList(@Path("page") String page);

  @GET("movie/popular?language=en-US&{page}")
  Future<MovieListResponse> getPopularMovies(@Path("page") String page);

  @GET("movie/top_rated?language=en-US&{page}")
  Future<MovieListResponse> getTopRatedMovies(@Path("page") String page);

  @GET("movie/upcoming?language=en-US&{page}")
  Future<MovieListResponse> getUpcomingMovies(@Path("page") String page);

  @GET("search/movie?{query}&include_adult=false&language=en-US&page=1")
  Future<MovieListResponse> getSearchResult(@Query("name") String name);

  @GET("search/movie") // Define the base path
  Future<MovieListResponse> getSearchQuery(
    @Query("query") String query, {
    @Query("include_adult") bool includeAdult = true,
    @Query("language") String language = "en-US",
    @Query("page") int page = 1,
  });

  @GET("movie/{id}") // Define the base path
  Future<MovieDetails> getMovieDetail(
      @Path("id") int id, {
        @Query("language") String language = "en-US",
      });

//
// @GET("folk?limit=150&sort=position&ord=ASC")
// Future<BaseResponse<List<CategoryAi>>> getDiscoverData();
//
// @POST("message")
// Future<BaseResponse<List<Message>>> getMessageResponse(@Body() Map<String, dynamic> body);
//
// @POST("conversations")
// Future<BaseResponse<Conversation>> getConversationId(@Body() Map<String, dynamic> body);
}
