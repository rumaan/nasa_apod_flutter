import 'package:nasa_apod_flutter/model/apod_model.dart';

abstract class BaseApiService {
  // TODO: Mock these with tests later
  Future<ApodModel> getApod(String date);
}
