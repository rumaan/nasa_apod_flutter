import 'dart:async';

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
    _currentDate = DateTime.now();
    _getApods(_currentDate, _MAX_COUNT);
  }

  Stream<List<ApodModel>> get apodStream => _apodListController.stream;

  Stream<double> get downloadProgress => _downloadProgress.stream;

  void dispose() {
    _apodListController.close();
    _downloadProgress.close();
  }

  void download(ApodModel apod) async {
    await _repository.downloadImage(
      apod,
      downloadProgress: (recieved, total) {
        final progress = _computeProgress(recieved, total);
        print("Progress: $progress");
        _downloadProgress.sink.add(progress);
      },
    );
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

  double _computeProgress(int recieved, int total) {
    final progress = recieved / total;
    return progress;
  }

  void _getApods(DateTime date, int count) async {
    for (var i = 0; i < count; i++) {
      // Save requests for apods which we already have
      var element = _apods.where((e) => e.date == date.toString());
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
}
