import 'package:flutter/material.dart';
import 'package:nasa_apod_flutter/api/api_client_provider.dart';
import 'package:nasa_apod_flutter/api/api_service.dart';
import 'package:nasa_apod_flutter/repository/api_repository.dart';
import 'package:nasa_apod_flutter/ui/home/bloc/home_bloc.dart';
import 'package:nasa_apod_flutter/ui/home/home.dart';
import 'package:provider/provider.dart';

void main() async {
  await ApiClientProvider.initializeClient();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: ThemeData.dark().textTheme,
      ),
      home: Provider<HomeBloc>(
        builder: (context) => HomeBloc(ApiRepository(ApodApi())),
        dispose: (context, bloc) => bloc.dispose(),
        child: HomePage(),
      ),
    );
  }
}
