import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:nasa_apod_flutter/utils/exception_handler.dart';

import '../model/apod_model.dart';
import 'api_client_provider.dart';
import 'apod_exception.dart';
import 'base_api_service.dart';

class ApodApi extends ApiClientProvider implements BaseApiService {
  static const _APOD_ENDPOINT = "/apod";

  @override
  Future<ApodModel> getApod(String dateTime) async {
    try {
      final response = await client.get(_APOD_ENDPOINT,
          queryParameters: {"date": dateTime},
          options: buildCacheOptions(Duration(days: 14)));
      final apod = ApodModel.fromJson(response.data);
      return apod;
    } catch (exception) {
      throw ApodException(message: ExceptionHandler.parseException(exception));
    }
  }
}

