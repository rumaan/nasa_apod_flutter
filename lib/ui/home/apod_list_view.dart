import 'package:flutter/material.dart';
import 'package:nasa_apod_flutter/model/apod_model.dart';
import 'package:nasa_apod_flutter/ui/home/apod_list_item.dart';

class ApodListView extends StatelessWidget {
  final List<ApodModel> items;

  const ApodListView({Key key, @required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return ApodListItem(item: items[index]);
        },
        childCount: items.length,
      ),
    );
  }
}
