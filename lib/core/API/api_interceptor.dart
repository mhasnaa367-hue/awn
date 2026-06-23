import 'package:dio/dio.dart';

import 'package:awn/core/API/end_point.dart';
import 'package:awn/core/API/token_storage.dart';
import 'package:awn/core/app_navigator.dart';

// An interceptor runs before every request (and on errors).
//
// 1) onRequest  -> attaches the saved access token to every request.
// 2) onError    -> if the server replies 401 (token expired/invalid) we try
//    ONCE to get a fresh token with the saved refresh token, then replay the
//    original request. This is what keeps the user "connected" after the short
//    15-minute access token expires — without it, every authenticated call
//    (logout, documents, profile, upload...) starts failing silently.
class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // For normal requests we send JSON. But when we upload a file the body is
    // a FormData (multipart) — in that case Dio sets the right Content-Type
    // itself (with the special boundary), so we must NOT overwrite it here.
    if (options.data is! FormData) {
      options.headers['Content-Type'] = 'application/json';
    }

    // 👇 THIS is the line that sends the token with every request.
    final token = TokenStorage.token;
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final requestOptions = err.requestOptions;
    final path = requestOptions.path;

    // Don't try to refresh for the auth endpoints themselves, and only react
    // to 401s. (A failed refresh/login should just surface its error.)
    final isAuthCall = path.contains('/auth/login') ||
        path.contains('/auth/register') ||
        path.contains('/auth/refresh');
    final alreadyRetried = requestOptions.extra['retried'] == true;

    if (err.response?.statusCode == 401 && !isAuthCall && !alreadyRetried) {
      final refreshToken = TokenStorage.refreshToken;
      if (refreshToken != null && refreshToken.isNotEmpty) {
        try {
          // Use a bare Dio (no interceptors) to avoid recursion.
          final refreshDio = Dio(BaseOptions(baseUrl: EndPoint.baseUrl));
          final resp = await refreshDio.post(
            EndPoint.refresh,
            data: {ApiKey.refreshToken: refreshToken},
          );

          final data = (resp.data is Map ? resp.data[ApiKey.data] : null) ?? {};
          final newAccess = data[ApiKey.accessToken]?.toString() ?? '';
          final newRefresh = data[ApiKey.refreshToken]?.toString() ?? '';

          if (newAccess.isNotEmpty) {
            await TokenStorage.save(newAccess, newRefresh);

            // Replay the original request with the fresh token, marking it so
            // we never loop on a second 401.
            requestOptions.headers['Authorization'] = 'Bearer $newAccess';
            requestOptions.extra['retried'] = true;

            final retryDio = Dio(BaseOptions(baseUrl: EndPoint.baseUrl));
            final cloned = await retryDio.fetch(requestOptions);
            return handler.resolve(cloned);
          }
        } catch (_) {
          // Refresh failed -> the session is dead. Clear it and (if the user
          // is already inside the app) bounce them to the login screen.
          await TokenStorage.clear();
          forceLogoutToLogin();
        }
      }
    }

    handler.next(err);
  }
}
