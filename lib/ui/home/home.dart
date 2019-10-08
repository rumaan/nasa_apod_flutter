import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/apod_model.dart';
import 'apod_list_view.dart';
import 'app_bar.dart';
import 'bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          CustomAppBar(),
          Consumer<HomeBloc>(
            builder: (context, bloc, child) {
              return StreamBuilder<List<ApodModel>>(
                stream: bloc.apodStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return SliverFillRemaining(
                      child: Center(
                        child:
                            Text("Error occurred while retrieving the list."),
                      ),
                    );
                  }
                  if (!snapshot.hasData) {
                    return SliverFillRemaining(
                        child: Center(child: CupertinoActivityIndicator()));
                  }

                  if (snapshot.hasData &&
                      (snapshot.data == null || snapshot.data.isEmpty)) {
                    return SliverFillRemaining(
                        child: Center(child: Text("List is empty!")));
                  }
                  return ApodListView(items: snapshot.data);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  void _onScrollListener() {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent) {
      // load more items
      Provider.of<HomeBloc>(context).loadMore();
    }
  }
}
