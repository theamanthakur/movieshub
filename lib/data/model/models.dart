import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

typedef Json = Map<String, dynamic>;

@JsonSerializable(genericArgumentFactories: true)
class BaseResponse<T> {
  @JsonKey(name: 'status')
  bool? status;

  @JsonKey(name: 'message')
  String? message;

  @JsonKey(name: 'data')
  T? data;

  BaseResponse({this.status, this.message, this.data});

  factory BaseResponse.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$BaseResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$BaseResponseToJson(this, toJsonT);
}


@JsonSerializable()
class MovieListResponse {
  final int page;
  final List<MovieResult> results;
  final int total_pages;
  final int total_results;

  MovieListResponse({
    required this.page,
    required this.results,
    required this.total_pages,
    required this.total_results,
  });

  factory MovieListResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MovieListResponseToJson(this);
}

@JsonSerializable()
class MovieResult {
  final bool adult;
  final String? backdrop_path;
  final List<int> genre_ids;
  final int id;
  final String original_language;
  final String original_title;
  final String overview;
  final double popularity;
  final String? poster_path;
  final String? release_date;
  final String title;
  final bool video;
  final double vote_average;
  final int vote_count;

  MovieResult({
    required this.adult,
    this.backdrop_path,
    required this.genre_ids,
    required this.id,
    required this.original_language,
    required this.original_title,
    required this.overview,
    required this.popularity,
    this.poster_path,
    this.release_date,
    required this.title,
    required this.video,
    required this.vote_average,
    required this.vote_count,
  });

  factory MovieResult.fromJson(Map<String, dynamic> json) =>
      _$MovieResultFromJson(json);

  Map<String, dynamic> toJson() => _$MovieResultToJson(this);

}



  @JsonSerializable()
class Product {
  int? id;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;
  Rating? rating;

  Product({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

@JsonSerializable()
class Rating {
  double? rate;
  int? count;

  Rating({
    this.rate,
    this.count,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => _$RatingFromJson(json);

  Map<String, dynamic> toJson() => _$RatingToJson(this);
}


@JsonSerializable()
class UserData {
  String? id;
  String? name;
  String? email;
  String? type;
  String? gender;
  String? pronoun;
  String? banner;
  String? avatar;
  String? bio;
  bool? isCreator;
  bool? isVerified;

  UserData({
    this.id,
    this.name,
    this.email,
    this.type,
    this.gender,
    this.pronoun,
    this.banner,
    this.avatar,
    this.bio,
    this.isCreator,
    this.isVerified,
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}


@JsonSerializable()
class UserInfo {
  final String? id;
  final String? deviceId;

  UserInfo({
    required this.id,
    required this.deviceId,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}

@JsonSerializable()
class OnboardingData {
  String? image;
  String? image_dark;
  String? title;
  String? description;
  String? id;

  OnboardingData({
    this.id,
    this.image_dark,
    this.image,
    this.title,
    this.description,
  });

  factory OnboardingData.fromJson(Map<String, dynamic> json) =>
      _$OnboardingDataFromJson(json);

  Map<String, dynamic> toJson() => _$OnboardingDataToJson(this);

  //to debug print response in model

  @override
  String toString() {
    return 'OnboardingData{id: $id, image: $image, image_dark: $image_dark title: $title, description: $description}';
  }
}

@JsonSerializable()
class SearchResponse {
  int page;
  List<MovieResult> results;
  int total_pages;
  int total_results;

  SearchResponse({
    required this.page,
    required this.results,
    required this.total_pages,
    required this.total_results,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchResponseToJson(this);

}


@JsonSerializable()
class MovieDetails {
  bool adult;
  String? backdrop_path;
  dynamic belongs_to_collection;
  int budget;
  List<Genre> genres;
  String homepage;
  int id;
  String? imdb_id;
  List<String> origin_country;
  String original_language;
  String original_title;
  String overview;
  double popularity;
  String? poster_path;
  List<ProductionCompany> production_companies;
  List<ProductionCountry> production_countries;
  String? release_date;
  int revenue;
  int runtime;
  List<SpokenLanguage> spoken_languages;
  String status;
  String tagline;
  String title;
  bool video;
  double vote_average;
  int vote_count;

  MovieDetails({
    required this.adult,
    this.backdrop_path,
    this.belongs_to_collection,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    this.imdb_id,
    required this.origin_country,
    required this.original_language,
    required this.original_title,
    required this.overview,
    required this.popularity,
    this.poster_path,
    required this.production_companies,
    required this.production_countries,
    this.release_date,
    required this.revenue,
    required this.runtime,
    required this.spoken_languages,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.vote_average,
    required this.vote_count,
  });

  factory MovieDetails.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailsToJson(this);
}


@JsonSerializable()
class Genre {
  int id;
  String name;

  Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);

  Map<String, dynamic> toJson() => _$GenreToJson(this);
}


@JsonSerializable()
class ProductionCompany {
  int id;
  String? logo_path;
  String name;
  String origin_country;

  ProductionCompany({
    required this.id,
    this.logo_path,
    required this.name,
    required this.origin_country,
  });

  factory ProductionCompany.fromJson(Map<String, dynamic> json) => _$ProductionCompanyFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCompanyToJson(this);
}

@JsonSerializable()
class ProductionCountry {
  String iso_3166_1;
  String name;

  ProductionCountry({
    required this.iso_3166_1,
    required this.name,
  });

  factory ProductionCountry.fromJson(Map<String, dynamic> json) => _$ProductionCountryFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCountryToJson(this);
}

@JsonSerializable()
class SpokenLanguage {
  String english_name;
  String iso_639_1;
  String name;

  SpokenLanguage({
    required this.english_name,
    required this.iso_639_1,
    required this.name,
  });

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) => _$SpokenLanguageFromJson(json);

  Map<String, dynamic> toJson() => _$SpokenLanguageToJson(this);
}


@JsonSerializable()
class Notice {
  final String title;
  final String subtitle;
  final String fileUrl;
  final DateTime dateTime;
  final String targetClasses;

  Notice({
    required this.title,
    required this.subtitle,
    required this.fileUrl,
    required this.dateTime,
    required this.targetClasses,
  });

  factory Notice.fromJson(Map<String, dynamic> json) => _$NoticeFromJson(json);

  Map<String, dynamic> toJson() => _$NoticeToJson(this);
}



