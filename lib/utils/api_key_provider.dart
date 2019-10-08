import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

const API_FILE_NAME = "assets/api_key.json";

Future<String> getApiKey() async {
  final jsonString = await rootBundle.loadString(API_FILE_NAME);
  final json = jsonDecode(jsonString);
  return json['key'] as String;
}
