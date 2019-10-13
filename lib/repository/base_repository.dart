import 'package:nasa_apod_flutter/model/apod_model.dart';

abstract class BaseRepository {
  // TODO: Mock these with tests later
  Future<ApodModel> getApod(DateTime date);

  Future downloadImage(ApodModel apod);
}
