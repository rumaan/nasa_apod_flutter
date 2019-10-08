library apod_model;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:nasa_apod_flutter/model/serializers.dart';

part 'apod_model.g.dart';

abstract class ApodModel implements Built<ApodModel, ApodModelBuilder> {
  @nullable
  String get copyright;
  String get date;
  String get explanation;

  @BuiltValueField(wireName: "hdurl")
  String get hdUrl;

  @BuiltValueField(wireName: "media_type")
  String get mediaType;

  @BuiltValueField(wireName: "service_version")
  String get serviceVersion;
  String get title;
  String get url;

  ApodModel._();

  factory ApodModel([updates(ApodModelBuilder b)]) = _$ApodModel;

  static Serializer<ApodModel> get serializer => _$apodModelSerializer;

  static Map<String, dynamic> toJson(ApodModel apodModel) {
    return standardSerializers.serializeWith(ApodModel.serializer, apodModel);
  }

  static ApodModel fromJson(Map<String, dynamic> json) {
    return standardSerializers.deserializeWith(serializer, json);
  }
}
