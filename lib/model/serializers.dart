library serializer;

import 'package:built_value/serializer.dart';
import 'package:nasa_apod_flutter/model/apod_model.dart';
import 'package:built_value/standard_json_plugin.dart';

part 'serializers.g.dart';

@SerializersFor(const [ApodModel])
final Serializers serializers = _$serializers;

final Serializers standardSerializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
