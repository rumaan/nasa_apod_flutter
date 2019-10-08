import 'package:flutter/material.dart';
import 'package:nasa_apod_flutter/api/api_client_provider.dart';
import 'package:nasa_apod_flutter/ui/home/home.dart';

void main() {
  ApiClientProvider.initializeClient();
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
      home: HomePage(),
    );
  }
}
