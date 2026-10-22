import '../exceptions/api_exception.dart';

String readableError(Object error) {
  if (error is ApiException) return error.message;
  return error.toString().replaceFirst('Exception: ', '');
}
