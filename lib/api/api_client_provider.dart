import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

import '../utils/api_key_provider.dart';

const BASE_API_URL = "https://api.nasa.gov/planetary";

class ApiClientProvider {
  static const _api_query_param = "api_key";

  static Dio _client = Dio(BaseOptions(baseUrl: BASE_API_URL));

  Dio get client => _client;

  static Future initializeClient() async {
    final apiKey = await getApiKey();
    _client
      ..interceptors.addAll(
        [
          LogInterceptor(
            error: true,
            request: true,
            requestHeader: true,
            requestBody:  true,
            responseHeader: true,
            responseBody: true,
          ),
          InterceptorsWrapper(
            onRequest: (requestOptions) {
              requestOptions.queryParameters.addAll({_api_query_param: apiKey});
              return requestOptions;
            },
          ),
          DioCacheManager(CacheConfig(baseUrl: BASE_API_URL)).interceptor,
        ],
      );
  }
}
