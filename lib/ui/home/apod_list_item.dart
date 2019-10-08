import 'package:flutter/material.dart';
import 'package:nasa_apod_flutter/model/apod_model.dart';

class ApodListItem extends StatelessWidget {
  final ApodModel item;

  const ApodListItem({Key key, @required this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(child: Text(item.toString()));
  }
}
