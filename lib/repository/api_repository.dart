import 'package:nasa_apod_flutter/api/base_api_service.dart';
import 'package:nasa_apod_flutter/model/apod_model.dart';
import 'package:nasa_apod_flutter/repository/base_repository.dart';
import 'package:nasa_apod_flutter/utils/date_utils.dart';

class ApiRepository implements BaseRepository {
  final BaseApiService apiService;

  ApiRepository(this.apiService);

  @override
  Future<ApodModel> getApod(DateTime date) async {
    String dateTime = DateUtils.getDateString(date);
    return apiService.getApod(dateTime);
  }
}
