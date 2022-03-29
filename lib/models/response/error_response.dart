import 'package:dio/dio.dart';

class ErrorResponse implements Exception {
  int errorCode; //Error code
  String errorMessage = ""; //Error message

  ErrorResponse({this.errorCode, this.errorMessage});

  // ErrorResponse.fromJson(Map<String, dynamic> json)
  //     : errorCode = json['errorCode'],
  //       errorMessage = json['errorMessage'];
  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
        errorCode: json['errorCode'],
        errorMessage : json['errorMessage']
    );
  }

  Map<String, dynamic> toJson() => {
    'errorCode': errorCode,
    'errorMessage': errorMessage
  };

  ErrorResponse.withError({DioError error}) {
    _handleError(error);
  }

  _handleError(DioError error) {
    switch (error.type) {
      case DioErrorType.CANCEL:
        errorMessage = "Request was cancelled";
        break;
      case DioErrorType.CONNECT_TIMEOUT:
        errorMessage = "Connection timeout";
        break;
      case DioErrorType.DEFAULT:
        errorMessage = "Connection failed due to internet connection";
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        errorMessage = "Receive timeout in connection";
        break;
      case DioErrorType.RESPONSE:
        errorMessage =
            "Received invalid status code: ${error.response.statusCode}";
        break;
      case DioErrorType.SEND_TIMEOUT:
        errorMessage = "Receive timeout in send request";
        break;
    }
    return errorMessage;
  }
}
