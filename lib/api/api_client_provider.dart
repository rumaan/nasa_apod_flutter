import 'package:dio/dio.dart';
import 'package:nasa_apod_flutter/utils/api_key_provider.dart';

const BASE_API_URL = "https://api.nasa.gov/planetary";

class ApiClientProvider {
  static const _api_query_param = "api_key";

  static Dio _client = Dio(BaseOptions(baseUrl: BASE_API_URL));

  Dio get client => _client;

  static Future initializeClient() async {
    final apiKey = await getApiKey();
    _client
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (requestOptions) {
            requestOptions.queryParameters.addAll({_api_query_param: apiKey});
            return requestOptions;
          },
        ),
      );
  }
}
