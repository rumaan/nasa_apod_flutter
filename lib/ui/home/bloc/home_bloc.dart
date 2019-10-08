import 'dart:async';

import 'package:nasa_apod_flutter/api/api_service.dart';
import 'package:nasa_apod_flutter/model/apod_model.dart';
import 'package:nasa_apod_flutter/repository/base_repository.dart';

class HomeBloc {
  static const _MAX_COUNT = 10;

  final _apods = <ApodModel>[];

  final BaseRepository _repository;

  StreamController<List<ApodModel>> _apodListController;

  DateTime _currentDate;

  HomeBloc(this._repository) {
    _apodListController = StreamController<List<ApodModel>>.broadcast();
    _currentDate = DateTime.now();
    _getApods(_currentDate, _MAX_COUNT);
  }

  Stream<List<ApodModel>> get apodStream => _apodListController.stream;

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
        } on FailedToFetchApodException catch (e) {
          _addError(e);
        }
      }
    }
  }

  void _addError(FailedToFetchApodException e) {
    _apodListController.sink.addError(e);
  }

  void _addApod(ApodModel apod) {
    if (!_apods.contains(apod)) {
      // Update local cache
      _apods.add(apod);
      // Send in the updated list
      _apodListController.sink.add(_apods);
    }
  }

  void loadMore() {
    _getApods(_currentDate, _MAX_COUNT);
  }

  void _addApods(List<ApodModel> apods) {
    _apods.addAll(apods);
    _apodListController.sink.add(apods);
  }

  void dispose() {
    _apodListController.sink.close();
  }
}
