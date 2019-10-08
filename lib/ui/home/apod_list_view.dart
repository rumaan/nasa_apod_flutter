import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/apod_model.dart';
import 'apod_list_item.dart';

class ApodListView extends StatelessWidget {
  final List<ApodModel> items;

  const ApodListView({Key key, @required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index == items.length) {
            return _buildLoading();
          }
          return ApodListItem(item: items[index]);
        },
        childCount: items.length + 1,
      ),
    );
  }

  Widget _buildLoading() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Center(
        child: CupertinoActivityIndicator(
          radius: 12,
        ),
      ),
    );
  }
}
