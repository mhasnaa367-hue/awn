import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['token']='kspod,odfmopsdfmof';
    super.onRequest(options, handler);
  }
}
