import 'package:dio/dio.dart';

// An interceptor runs before every request.
// For now login/register don't need a token, so we only make sure
// the server knows we are sending JSON.
// Later, when you save the user's accessToken, you can add it here like:
//   options.headers['Authorization'] = 'Bearer $accessToken';
class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Content-Type'] = 'application/json';
    super.onRequest(options, handler);
  }
}
