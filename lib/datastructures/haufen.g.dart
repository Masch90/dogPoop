// GENERATED CODE - DO NOT MODIFY BY HAND

part of haufen;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Haufen> _$haufenSerializer = new _$HaufenSerializer();

class _$HaufenSerializer implements StructuredSerializer<Haufen> {
  @override
  final Iterable<Type> types = const [Haufen, _$Haufen];
  @override
  final String wireName = 'Haufen';

  @override
  Iterable<Object> serialize(Serializers serializers, Haufen object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'comment',
      serializers.serialize(object.comment,
          specifiedType: const FullType(String)),
      'date',
      serializers.serialize(object.date, specifiedType: const FullType(int)),
      'rating',
      serializers.serialize(object.rating, specifiedType: const FullType(int)),
      'segment',
      serializers.serialize(object.segment, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  Haufen deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new HaufenBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'comment':
          result.comment = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'date':
          result.date = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'rating':
          result.rating = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'segment':
          result.segment = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$Haufen extends Haufen {
  @override
  final String comment;
  @override
  final int date;
  @override
  final int rating;
  @override
  final int segment;

  factory _$Haufen([void Function(HaufenBuilder) updates]) =>
      (new HaufenBuilder()..update(updates)).build();

  _$Haufen._({this.comment, this.date, this.rating, this.segment}) : super._() {
    if (comment == null) {
      throw new BuiltValueNullFieldError('Haufen', 'comment');
    }
    if (date == null) {
      throw new BuiltValueNullFieldError('Haufen', 'date');
    }
    if (rating == null) {
      throw new BuiltValueNullFieldError('Haufen', 'rating');
    }
    if (segment == null) {
      throw new BuiltValueNullFieldError('Haufen', 'segment');
    }
  }

  @override
  Haufen rebuild(void Function(HaufenBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HaufenBuilder toBuilder() => new HaufenBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Haufen &&
        comment == other.comment &&
        date == other.date &&
        rating == other.rating &&
        segment == other.segment;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, comment.hashCode), date.hashCode), rating.hashCode),
        segment.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Haufen')
          ..add('comment', comment)
          ..add('date', date)
          ..add('rating', rating)
          ..add('segment', segment))
        .toString();
  }
}

class HaufenBuilder implements Builder<Haufen, HaufenBuilder> {
  _$Haufen _$v;

  String _comment;
  String get comment => _$this._comment;
  set comment(String comment) => _$this._comment = comment;

  int _date;
  int get date => _$this._date;
  set date(int date) => _$this._date = date;

  int _rating;
  int get rating => _$this._rating;
  set rating(int rating) => _$this._rating = rating;

  int _segment;
  int get segment => _$this._segment;
  set segment(int segment) => _$this._segment = segment;

  HaufenBuilder();

  HaufenBuilder get _$this {
    if (_$v != null) {
      _comment = _$v.comment;
      _date = _$v.date;
      _rating = _$v.rating;
      _segment = _$v.segment;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Haufen other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Haufen;
  }

  @override
  void update(void Function(HaufenBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Haufen build() {
    final _$result = _$v ??
        new _$Haufen._(
            comment: comment, date: date, rating: rating, segment: segment);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
