import 'package:path_provider/path_provider.dart';

import '../api/base_api_service.dart';
import '../model/apod_model.dart';
import '../utils/date_utils.dart';
import 'base_repository.dart';

class ApiRepository implements BaseRepository {
  final BaseApiService apiService;

  ApiRepository(this.apiService);

  @override
  Future<ApodModel> getApod(DateTime date) async {
    String dateTime = DateUtils.getDateString(date);
    return apiService.getApod(dateTime);
  }

  @override
  Future downloadImage(ApodModel apod) async {
    final url = apod.hdUrl ?? apod.url;
    return await apiService.downloadImage(url);
  }
}
