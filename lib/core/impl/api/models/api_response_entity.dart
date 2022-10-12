import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response_entity.freezed.dart';
part 'api_response_entity.g.dart';

@freezed
class APIJsonResponse with _$APIJsonResponse {
  const factory APIJsonResponse({
    data,
    @Default('') String message,
    @Default(false) bool error,
    @Default(false) bool unauthorized,
    @Default(-1) int statusCode,
  }) = _APIJsonResponse;
  const APIJsonResponse._();

  factory APIJsonResponse.fromJson(Map<String, Object?> json) =>
      _$APIJsonResponseFromJson(json);
}
