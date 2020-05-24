class ErrorResponse implements Exception {

  int code;
  String message;

  ErrorResponse({this.code, this.message});

  @override
  String toString() {
    return "code = $code, message = $message";
  }

}