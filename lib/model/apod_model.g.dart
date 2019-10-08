// GENERATED CODE - DO NOT MODIFY BY HAND

part of apod_model;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ApodModel> _$apodModelSerializer = new _$ApodModelSerializer();

class _$ApodModelSerializer implements StructuredSerializer<ApodModel> {
  @override
  final Iterable<Type> types = const [ApodModel, _$ApodModel];
  @override
  final String wireName = 'ApodModel';

  @override
  Iterable<Object> serialize(Serializers serializers, ApodModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'date',
      serializers.serialize(object.date, specifiedType: const FullType(String)),
      'explanation',
      serializers.serialize(object.explanation,
          specifiedType: const FullType(String)),
      'media_type',
      serializers.serialize(object.mediaType,
          specifiedType: const FullType(String)),
      'service_version',
      serializers.serialize(object.serviceVersion,
          specifiedType: const FullType(String)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'url',
      serializers.serialize(object.url, specifiedType: const FullType(String)),
    ];
    if (object.copyright != null) {
      result
        ..add('copyright')
        ..add(serializers.serialize(object.copyright,
            specifiedType: const FullType(String)));
    }
    if (object.hdUrl != null) {
      result
        ..add('hdurl')
        ..add(serializers.serialize(object.hdUrl,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  ApodModel deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ApodModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'copyright':
          result.copyright = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'date':
          result.date = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'explanation':
          result.explanation = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'hdurl':
          result.hdUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'media_type':
          result.mediaType = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'service_version':
          result.serviceVersion = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'url':
          result.url = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$ApodModel extends ApodModel {
  @override
  final String copyright;
  @override
  final String date;
  @override
  final String explanation;
  @override
  final String hdUrl;
  @override
  final String mediaType;
  @override
  final String serviceVersion;
  @override
  final String title;
  @override
  final String url;

  factory _$ApodModel([void Function(ApodModelBuilder) updates]) =>
      (new ApodModelBuilder()..update(updates)).build();

  _$ApodModel._(
      {this.copyright,
      this.date,
      this.explanation,
      this.hdUrl,
      this.mediaType,
      this.serviceVersion,
      this.title,
      this.url})
      : super._() {
    if (date == null) {
      throw new BuiltValueNullFieldError('ApodModel', 'date');
    }
    if (explanation == null) {
      throw new BuiltValueNullFieldError('ApodModel', 'explanation');
    }
    if (mediaType == null) {
      throw new BuiltValueNullFieldError('ApodModel', 'mediaType');
    }
    if (serviceVersion == null) {
      throw new BuiltValueNullFieldError('ApodModel', 'serviceVersion');
    }
    if (title == null) {
      throw new BuiltValueNullFieldError('ApodModel', 'title');
    }
    if (url == null) {
      throw new BuiltValueNullFieldError('ApodModel', 'url');
    }
  }

  @override
  ApodModel rebuild(void Function(ApodModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ApodModelBuilder toBuilder() => new ApodModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApodModel &&
        copyright == other.copyright &&
        date == other.date &&
        explanation == other.explanation &&
        hdUrl == other.hdUrl &&
        mediaType == other.mediaType &&
        serviceVersion == other.serviceVersion &&
        title == other.title &&
        url == other.url;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc($jc(0, copyright.hashCode), date.hashCode),
                            explanation.hashCode),
                        hdUrl.hashCode),
                    mediaType.hashCode),
                serviceVersion.hashCode),
            title.hashCode),
        url.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ApodModel')
          ..add('copyright', copyright)
          ..add('date', date)
          ..add('explanation', explanation)
          ..add('hdUrl', hdUrl)
          ..add('mediaType', mediaType)
          ..add('serviceVersion', serviceVersion)
          ..add('title', title)
          ..add('url', url))
        .toString();
  }
}

class ApodModelBuilder implements Builder<ApodModel, ApodModelBuilder> {
  _$ApodModel _$v;

  String _copyright;
  String get copyright => _$this._copyright;
  set copyright(String copyright) => _$this._copyright = copyright;

  String _date;
  String get date => _$this._date;
  set date(String date) => _$this._date = date;

  String _explanation;
  String get explanation => _$this._explanation;
  set explanation(String explanation) => _$this._explanation = explanation;

  String _hdUrl;
  String get hdUrl => _$this._hdUrl;
  set hdUrl(String hdUrl) => _$this._hdUrl = hdUrl;

  String _mediaType;
  String get mediaType => _$this._mediaType;
  set mediaType(String mediaType) => _$this._mediaType = mediaType;

  String _serviceVersion;
  String get serviceVersion => _$this._serviceVersion;
  set serviceVersion(String serviceVersion) =>
      _$this._serviceVersion = serviceVersion;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  String _url;
  String get url => _$this._url;
  set url(String url) => _$this._url = url;

  ApodModelBuilder();

  ApodModelBuilder get _$this {
    if (_$v != null) {
      _copyright = _$v.copyright;
      _date = _$v.date;
      _explanation = _$v.explanation;
      _hdUrl = _$v.hdUrl;
      _mediaType = _$v.mediaType;
      _serviceVersion = _$v.serviceVersion;
      _title = _$v.title;
      _url = _$v.url;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ApodModel other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ApodModel;
  }

  @override
  void update(void Function(ApodModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ApodModel build() {
    final _$result = _$v ??
        new _$ApodModel._(
            copyright: copyright,
            date: date,
            explanation: explanation,
            hdUrl: hdUrl,
            mediaType: mediaType,
            serviceVersion: serviceVersion,
            title: title,
            url: url);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
