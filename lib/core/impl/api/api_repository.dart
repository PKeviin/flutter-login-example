import '../../enums/response_type_enum.dart';
import 'models/api_response_entity.dart';

abstract class ApiRepository {
  Future<APIJsonResponse> post({
    required String route,
    Map<String, dynamic>? body,
    ResponseDataTypeEnum dataType = ResponseDataTypeEnum.json,
  });
  Future<APIJsonResponse> put({
    required String route,
    Map<String, dynamic>? body,
    ResponseDataTypeEnum dataType = ResponseDataTypeEnum.json,
  });
  Future<APIJsonResponse> get({
    required String route,
    required ResponseDataTypeEnum dataType,
    Map<String, dynamic>? queryParams,
  });
}
