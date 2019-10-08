import 'dart:async';

import 'package:nasa_apod_flutter/model/apod_model.dart';
import 'package:nasa_apod_flutter/repository/api_repository.dart';
import 'package:nasa_apod_flutter/repository/base_repository.dart';

class HomeBloc {
  final _apods = <ApodModel>[];

  final BaseRepository _repository;

  StreamController<List<ApodModel>> _apodListController;

  HomeBloc(this._repository) {
    _apodListController = StreamController<List<ApodModel>>();
  }

  Stream<List<ApodModel>> get apodStream => _apodListController.stream;

  void addApod(ApodModel apod) {
    // Update local cache
    _apods.add(apod);
    // Send in the updated list
    _apodListController.sink.add(_apods);
  }

  void _addApods(List<ApodModel> apods) {
    _apods.addAll(apods);
    _apodListController.sink.add(apods);
  }

  void dispose() {
    _apodListController.sink.close();
  }
}
