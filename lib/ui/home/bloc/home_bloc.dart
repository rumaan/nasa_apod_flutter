import 'dart:async';

import 'package:image_downloader/image_downloader.dart';

import '../../../api/apod_exception.dart';
import '../../../model/apod_model.dart';
import '../../../repository/base_repository.dart';

class HomeBloc {
  static const _MAX_COUNT = 10;

  final _apods = <ApodModel>[];

  final BaseRepository _repository;

  StreamController<List<ApodModel>> _apodListController;

  DateTime _currentDate;

  final _downloadProgress = StreamController<double>.broadcast();

  HomeBloc(this._repository) {
    _apodListController = StreamController<List<ApodModel>>.broadcast();
    // TODO: change this later
    _currentDate = DateTime.now().subtract(Duration(days: 1));
    _getApods(_currentDate, _MAX_COUNT);
  }

  Stream<List<ApodModel>> get apodStream => _apodListController.stream;

  Stream<double> get downloadProgress => _downloadProgress.stream;

  void dispose() {
    _apodListController.close();
    _downloadProgress.close();
  }

  void download(ApodModel apod) async {
    // set up download progress callback
    ImageDownloader.callback(onProgressUpdate: (id, progress) {
      _downloadProgress.sink.add(_computeProgress(progress));
    });
    await _repository.downloadImage(apod);
  }

  void loadMore() {
    _getApods(_currentDate, _MAX_COUNT);
  }

  void _addApod(ApodModel apod) {
    if (!_apods.contains(apod)) {
      // Update local cache
      _apods.add(apod);
      // Send in the updated list
      _apodListController.sink.add(_apods);
    }
  }

  void _addApods(List<ApodModel> apods) {
    _apods.addAll(apods);
    _apodListController.sink.add(apods);
  }

  void _addError(ApodException e) {
    _apodListController.sink.addError(e);
  }

  double _computeProgress(int progress) {
    return progress / 100.0;
  }

  void _getApods(DateTime date, int count) async {
    for (var i = 0; i < count; i++) {
      // Save requests for apods which we already have
      var element = _apods.where((e) => e.date == date.toString()).toList();
      if (element == null || element.isEmpty) {
        try {
          final apod = await _repository.getApod(date);
          _addApod(apod);
          date = date.subtract(Duration(days: 1));
          _currentDate = date;
        } on ApodException catch (e) {
          _addError(e);
        }
      }
    }
  }

  void cancelDownload() async {
    await ImageDownloader.cancel();
  }
}
