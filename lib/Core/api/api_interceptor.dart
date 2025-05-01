import 'package:dio/dio.dart';
import 'package:monumental_habits/main.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Authorization'] = 'Bearer ${token!.getString("token")}';
    options.headers['Accept'] = 'application/json';
    super.onRequest(options, handler);
  }

  const ApiInterceptor();
}
