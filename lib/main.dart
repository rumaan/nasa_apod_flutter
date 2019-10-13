import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'api/api_client_provider.dart';
import 'api/api_service.dart';
import 'repository/api_repository.dart';
import 'ui/home/bloc/home_bloc.dart';
import 'ui/home/home.dart';

void main() async {
  await ApiClientProvider.initializeClient();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<HomeBloc>(
      builder: (context) => HomeBloc(ApiRepository(ApodApi())),
      dispose: (context, bloc) => bloc.dispose(),
      child: MaterialApp(
        title: 'NASA APOD Flutter',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: ThemeData.dark().textTheme,
        ),
        home: HomePage(),
      ),
    );
  }
}
