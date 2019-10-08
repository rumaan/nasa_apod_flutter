import 'package:dio/dio.dart';

import '../model/apod_model.dart';
import 'api_client_provider.dart';
import 'base_api_service.dart';

class ApodApi extends ApiClientProvider implements BaseApiService {
  static const _APOD_ENDPOINT = "/apod";

  @override
  Future<ApodModel> getApod(String dateTime) async {
    final response = await client.get(
      _APOD_ENDPOINT,
      queryParameters: {"date": dateTime},
    );
    if (response.statusCode != 200) {
      throw FailedToFetchApodException(response);
    } else {
      final apod = ApodModel.fromJson(response.data);
      return apod;
    }
  }
}

class FailedToFetchApodException implements Exception {
  final Response response;

  FailedToFetchApodException(this.response);
  @override
  String toString() {
    return "Failed to fetch apod from the server. $response";
  }
}
