import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nasa_apod_flutter/api/api_service.dart';
import 'package:nasa_apod_flutter/model/apod_model.dart';
import 'package:nasa_apod_flutter/repository/api_repository.dart';
import 'package:nasa_apod_flutter/ui/home/app_bar.dart';
import 'package:nasa_apod_flutter/ui/home/bloc/home_bloc.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'apod_list_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final bloc = HomeBloc(ApiRepository(ApodApi()));

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final jsonString = await rootBundle.loadString("assets/test.json");
          final json = jsonDecode(jsonString);
          final ApodModel apod = ApodModel.fromJson(json);
          bloc.addApod(apod);
        },
        child: Icon(Icons.add),
      ),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          CustomAppBar(),
          StreamBuilder<List<ApodModel>>(
            stream: bloc.apodStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return SliverFillRemaining(
                  child: Center(
                      child: Text("Error occurred while retrieving the list.")),
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
          ),
        ],
      ),
    );
  }
}
