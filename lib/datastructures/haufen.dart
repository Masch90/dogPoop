library haufen;

import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:doggy_poop_diary/datastructures/serializers.dart';

part 'haufen.g.dart';

abstract class Haufen implements Built<Haufen, HaufenBuilder> {
  Haufen._();

  factory Haufen([updates(HaufenBuilder b)]) = _$Haufen;

  @BuiltValueField(wireName: 'id')
  String get id;
  @BuiltValueField(wireName: 'date')
  int get date;
  @BuiltValueField(wireName: 'rating')
  int get rating;
  @BuiltValueField(wireName: 'segment')
  String get segment;
  String toJson() {
    return json.encode(serializers.serializeWith(Haufen.serializer, this));
  }

  static Haufen fromJson(String jsonString) {
    return serializers.deserializeWith(
        Haufen.serializer, json.decode(jsonString));
  }

  static Serializer<Haufen> get serializer => _$haufenSerializer;
}