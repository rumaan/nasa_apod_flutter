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
  Future downloadImage(ApodModel apod,
      {Function(int, int) downloadProgress}) async {
    final url = apod.url;
    final fileName = _getFileName(url);
    final dir = await getApplicationDocumentsDirectory();
    final savePath = "${dir.path}/$fileName";
    return await apiService.downloadImage(
      url,
      savePath,
      progress: downloadProgress,
    );
  }

  String _getFileName(String url) {
    int fromIndex = url.lastIndexOf("/") + 1;
    return url.substring(fromIndex);
  }
}
