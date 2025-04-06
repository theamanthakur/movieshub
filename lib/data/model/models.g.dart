// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse<T> _$BaseResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    BaseResponse<T>(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: _$nullableGenericFromJson(json['data'], fromJsonT),
    );

Map<String, dynamic> _$BaseResponseToJson<T>(
  BaseResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': _$nullableGenericToJson(instance.data, toJsonT),
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);

MovieListResponse _$MovieListResponseFromJson(Map<String, dynamic> json) =>
    MovieListResponse(
      page: (json['page'] as num).toInt(),
      results: (json['results'] as List<dynamic>)
          .map((e) => MovieResult.fromJson(e as Map<String, dynamic>))
          .toList(),
      total_pages: (json['total_pages'] as num).toInt(),
      total_results: (json['total_results'] as num).toInt(),
    );

Map<String, dynamic> _$MovieListResponseToJson(MovieListResponse instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results,
      'total_pages': instance.total_pages,
      'total_results': instance.total_results,
    };

MovieResult _$MovieResultFromJson(Map<String, dynamic> json) => MovieResult(
      adult: json['adult'] as bool,
      backdrop_path: json['backdrop_path'] as String?,
      genre_ids: (json['genre_ids'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      id: (json['id'] as num).toInt(),
      original_language: json['original_language'] as String,
      original_title: json['original_title'] as String,
      overview: json['overview'] as String,
      popularity: (json['popularity'] as num).toDouble(),
      poster_path: json['poster_path'] as String?,
      release_date: json['release_date'] as String?,
      title: json['title'] as String,
      video: json['video'] as bool,
      vote_average: (json['vote_average'] as num).toDouble(),
      vote_count: (json['vote_count'] as num).toInt(),
    );

Map<String, dynamic> _$MovieResultToJson(MovieResult instance) =>
    <String, dynamic>{
      'adult': instance.adult,
      'backdrop_path': instance.backdrop_path,
      'genre_ids': instance.genre_ids,
      'id': instance.id,
      'original_language': instance.original_language,
      'original_title': instance.original_title,
      'overview': instance.overview,
      'popularity': instance.popularity,
      'poster_path': instance.poster_path,
      'release_date': instance.release_date,
      'title': instance.title,
      'video': instance.video,
      'vote_average': instance.vote_average,
      'vote_count': instance.vote_count,
    };

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      description: json['description'] as String?,
      category: json['category'] as String?,
      image: json['image'] as String?,
      rating: json['rating'] == null
          ? null
          : Rating.fromJson(json['rating'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'price': instance.price,
      'description': instance.description,
      'category': instance.category,
      'image': instance.image,
      'rating': instance.rating,
    };

Rating _$RatingFromJson(Map<String, dynamic> json) => Rating(
      rate: (json['rate'] as num?)?.toDouble(),
      count: (json['count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RatingToJson(Rating instance) => <String, dynamic>{
      'rate': instance.rate,
      'count': instance.count,
    };

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      id: json['id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      type: json['type'] as String?,
      gender: json['gender'] as String?,
      pronoun: json['pronoun'] as String?,
      banner: json['banner'] as String?,
      avatar: json['avatar'] as String?,
      bio: json['bio'] as String?,
      isCreator: json['isCreator'] as bool?,
      isVerified: json['isVerified'] as bool?,
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'type': instance.type,
      'gender': instance.gender,
      'pronoun': instance.pronoun,
      'banner': instance.banner,
      'avatar': instance.avatar,
      'bio': instance.bio,
      'isCreator': instance.isCreator,
      'isVerified': instance.isVerified,
    };

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      id: json['id'] as String?,
      deviceId: json['deviceId'] as String?,
    );

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'id': instance.id,
      'deviceId': instance.deviceId,
    };

OnboardingData _$OnboardingDataFromJson(Map<String, dynamic> json) =>
    OnboardingData(
      id: json['id'] as String?,
      image_dark: json['image_dark'] as String?,
      image: json['image'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$OnboardingDataToJson(OnboardingData instance) =>
    <String, dynamic>{
      'image': instance.image,
      'image_dark': instance.image_dark,
      'title': instance.title,
      'description': instance.description,
      'id': instance.id,
    };

SearchResponse _$SearchResponseFromJson(Map<String, dynamic> json) =>
    SearchResponse(
      page: (json['page'] as num).toInt(),
      results: (json['results'] as List<dynamic>)
          .map((e) => MovieResult.fromJson(e as Map<String, dynamic>))
          .toList(),
      total_pages: (json['total_pages'] as num).toInt(),
      total_results: (json['total_results'] as num).toInt(),
    );

Map<String, dynamic> _$SearchResponseToJson(SearchResponse instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results,
      'total_pages': instance.total_pages,
      'total_results': instance.total_results,
    };

MovieDetails _$MovieDetailsFromJson(Map<String, dynamic> json) => MovieDetails(
      adult: json['adult'] as bool,
      backdrop_path: json['backdrop_path'] as String?,
      belongs_to_collection: json['belongs_to_collection'],
      budget: (json['budget'] as num).toInt(),
      genres: (json['genres'] as List<dynamic>)
          .map((e) => Genre.fromJson(e as Map<String, dynamic>))
          .toList(),
      homepage: json['homepage'] as String,
      id: (json['id'] as num).toInt(),
      imdb_id: json['imdb_id'] as String?,
      origin_country: (json['origin_country'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      original_language: json['original_language'] as String,
      original_title: json['original_title'] as String,
      overview: json['overview'] as String,
      popularity: (json['popularity'] as num).toDouble(),
      poster_path: json['poster_path'] as String?,
      production_companies: (json['production_companies'] as List<dynamic>)
          .map((e) => ProductionCompany.fromJson(e as Map<String, dynamic>))
          .toList(),
      production_countries: (json['production_countries'] as List<dynamic>)
          .map((e) => ProductionCountry.fromJson(e as Map<String, dynamic>))
          .toList(),
      release_date: json['release_date'] as String?,
      revenue: (json['revenue'] as num).toInt(),
      runtime: (json['runtime'] as num).toInt(),
      spoken_languages: (json['spoken_languages'] as List<dynamic>)
          .map((e) => SpokenLanguage.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String,
      tagline: json['tagline'] as String,
      title: json['title'] as String,
      video: json['video'] as bool,
      vote_average: (json['vote_average'] as num).toDouble(),
      vote_count: (json['vote_count'] as num).toInt(),
    );

Map<String, dynamic> _$MovieDetailsToJson(MovieDetails instance) =>
    <String, dynamic>{
      'adult': instance.adult,
      'backdrop_path': instance.backdrop_path,
      'belongs_to_collection': instance.belongs_to_collection,
      'budget': instance.budget,
      'genres': instance.genres,
      'homepage': instance.homepage,
      'id': instance.id,
      'imdb_id': instance.imdb_id,
      'origin_country': instance.origin_country,
      'original_language': instance.original_language,
      'original_title': instance.original_title,
      'overview': instance.overview,
      'popularity': instance.popularity,
      'poster_path': instance.poster_path,
      'production_companies': instance.production_companies,
      'production_countries': instance.production_countries,
      'release_date': instance.release_date,
      'revenue': instance.revenue,
      'runtime': instance.runtime,
      'spoken_languages': instance.spoken_languages,
      'status': instance.status,
      'tagline': instance.tagline,
      'title': instance.title,
      'video': instance.video,
      'vote_average': instance.vote_average,
      'vote_count': instance.vote_count,
    };

Genre _$GenreFromJson(Map<String, dynamic> json) => Genre(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$GenreToJson(Genre instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

ProductionCompany _$ProductionCompanyFromJson(Map<String, dynamic> json) =>
    ProductionCompany(
      id: (json['id'] as num).toInt(),
      logo_path: json['logo_path'] as String?,
      name: json['name'] as String,
      origin_country: json['origin_country'] as String,
    );

Map<String, dynamic> _$ProductionCompanyToJson(ProductionCompany instance) =>
    <String, dynamic>{
      'id': instance.id,
      'logo_path': instance.logo_path,
      'name': instance.name,
      'origin_country': instance.origin_country,
    };

ProductionCountry _$ProductionCountryFromJson(Map<String, dynamic> json) =>
    ProductionCountry(
      iso_3166_1: json['iso_3166_1'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$ProductionCountryToJson(ProductionCountry instance) =>
    <String, dynamic>{
      'iso_3166_1': instance.iso_3166_1,
      'name': instance.name,
    };

SpokenLanguage _$SpokenLanguageFromJson(Map<String, dynamic> json) =>
    SpokenLanguage(
      english_name: json['english_name'] as String,
      iso_639_1: json['iso_639_1'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$SpokenLanguageToJson(SpokenLanguage instance) =>
    <String, dynamic>{
      'english_name': instance.english_name,
      'iso_639_1': instance.iso_639_1,
      'name': instance.name,
    };
