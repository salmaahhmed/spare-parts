import 'package:parse_server_sdk/parse_server_sdk.dart';

class ApiResponse {
  ApiResponse(this.success, this.statusCode, this.results)
      : count = results?.length ?? 0,
        result = results?.first;

  final bool success;
  final int statusCode;
  final List<dynamic> results;
  final dynamic result;
  int count;
}

ApiResponse getApiResponse<T extends ParseObject>(ParseResponse response) {
  if (response.statusCode == 200 || response.error == null)
    return ApiResponse(
      response.success,
      response.statusCode,
      response.results,
    );
  else {
    throw getApiError(response.error);
  }
}

BindException getApiError(ParseError response) {
  if (response == null) {
    return null;
  }

  return BindException(response.code, response.message,
      response.isTypeOfException, response.type);
}

class BindException implements Exception {
  BindException(this.code, this.message, this.isTypeOfException, this.type);
  final int code;
  final String message;
  final bool isTypeOfException;
  final String type;
}

Future<T> fetchParseObjectIfNeeded<T extends ParseObject>(T paresObj) async {
  try {
    if (paresObj == null) throw Exception('class Name is required');
    return await paresObj.fromPin(paresObj.objectId) ??
        getApiResponse(await paresObj.getObject(paresObj.objectId)).result;
  } catch (e) {
    return null;
  }
}
