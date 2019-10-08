import 'dart:async';

import 'package:nasa_apod_flutter/model/apod_model.dart';

class HomeBloc {
  final _apods = <ApodModel>[];

  StreamController<List<ApodModel>> _apodListController;

  HomeBloc() {
    _apodListController = StreamController<List<ApodModel>>();
  }

  Stream<List<ApodModel>> get apodStream => _apodListController.stream;

  void addApod(ApodModel apod) {
    // Update local cache
    _apods.add(apod);
    // Send in the updated list
    _apodListController.sink.add(_apods);
  }

  void dispose() {
    _apodListController.sink.close();
  }
}
