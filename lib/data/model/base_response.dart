import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

@JsonSerializable()
class RootResponse {
  @JsonKey(name: 'status')
  bool? status;
  @JsonKey(name: 'message')
  String? message;

  RootResponse({this.status, this.message});

  factory RootResponse.fromJson(Map<String, dynamic> json) => _$RootResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RootResponseToJson(this);
}

@JsonSerializable(genericArgumentFactories: true)
class AppResponse<T> {
  @JsonKey(name: 'status')
  bool? status;

  @JsonKey(name: 'message')
  String? message;

  @JsonKey(name: 'data')
  T? data;

  AppResponse({this.status, this.message, this.data});

  factory AppResponse.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) => _$AppResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) => _$AppResponseToJson(this, toJsonT);
}

@JsonSerializable(genericArgumentFactories: true)
class AppResponses<T> {
  @JsonKey(name: 'status')
  bool? status;

  @JsonKey(name: 'message')
  String? message;

  @JsonKey(name: 'data')
  List<T>? data;

  AppResponses({this.status, this.message, this.data});

  factory AppResponses.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) => _$AppResponsesFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) => _$AppResponsesToJson(this, toJsonT);
}
