import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nasa_apod_flutter/ui/home/apod_list_item.dart';
import 'package:provider/provider.dart';
import '../../model/apod_model.dart';
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
      backgroundColor: Colors.black,
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              backgroundColor: Colors.black,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text("DISCOVER",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold)),
                background: Image.asset(
                  "assets/images/earth.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ];
        },
        body: Consumer<HomeBloc>(
          builder: (context, bloc, child) {
            return StreamBuilder<List<ApodModel>>(
              stream: bloc.apodStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                      child: Text(
                    "Error while loading the data",
                    style: TextStyle(color: Colors.white),
                  ));
                }
                if (!snapshot.hasData) {
                  return Center(child: CupertinoActivityIndicator());
                }

                if (snapshot.hasData &&
                    (snapshot.data == null || snapshot.data.isEmpty)) {
                  return Center(child: Text("List is empty!"));
                }
                return ListView.builder(
                    itemCount: snapshot.data.length + 1,
                    itemBuilder: (context, index) {
                      if (index == snapshot.data.length) {
                        return _buildLoading();
                      }
                      return ApodListItem(
                        item: snapshot.data[index],
                      );
                    });
              },
            );
          },
        ),
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
