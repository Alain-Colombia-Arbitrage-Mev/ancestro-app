// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'agreement.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Agreement _$AgreementFromJson(Map<String, dynamic> json) {
  return _Agreement.fromJson(json);
}

/// @nodoc
mixin _$Agreement {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  bool get accepted => throw _privateConstructorUsedError;

  /// Serializes this Agreement to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Agreement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AgreementCopyWith<Agreement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AgreementCopyWith<$Res> {
  factory $AgreementCopyWith(Agreement value, $Res Function(Agreement) then) =
      _$AgreementCopyWithImpl<$Res, Agreement>;
  @useResult
  $Res call({String id, String title, String content, bool accepted});
}

/// @nodoc
class _$AgreementCopyWithImpl<$Res, $Val extends Agreement>
    implements $AgreementCopyWith<$Res> {
  _$AgreementCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Agreement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? content = null,
    Object? accepted = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String,
            accepted: null == accepted
                ? _value.accepted
                : accepted // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AgreementImplCopyWith<$Res>
    implements $AgreementCopyWith<$Res> {
  factory _$$AgreementImplCopyWith(
    _$AgreementImpl value,
    $Res Function(_$AgreementImpl) then,
  ) = __$$AgreementImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String title, String content, bool accepted});
}

/// @nodoc
class __$$AgreementImplCopyWithImpl<$Res>
    extends _$AgreementCopyWithImpl<$Res, _$AgreementImpl>
    implements _$$AgreementImplCopyWith<$Res> {
  __$$AgreementImplCopyWithImpl(
    _$AgreementImpl _value,
    $Res Function(_$AgreementImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Agreement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? content = null,
    Object? accepted = null,
  }) {
    return _then(
      _$AgreementImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
        accepted: null == accepted
            ? _value.accepted
            : accepted // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AgreementImpl implements _Agreement {
  const _$AgreementImpl({
    required this.id,
    required this.title,
    required this.content,
    this.accepted = false,
  });

  factory _$AgreementImpl.fromJson(Map<String, dynamic> json) =>
      _$$AgreementImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String content;
  @override
  @JsonKey()
  final bool accepted;

  @override
  String toString() {
    return 'Agreement(id: $id, title: $title, content: $content, accepted: $accepted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AgreementImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.accepted, accepted) ||
                other.accepted == accepted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, content, accepted);

  /// Create a copy of Agreement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AgreementImplCopyWith<_$AgreementImpl> get copyWith =>
      __$$AgreementImplCopyWithImpl<_$AgreementImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AgreementImplToJson(this);
  }
}

abstract class _Agreement implements Agreement {
  const factory _Agreement({
    required final String id,
    required final String title,
    required final String content,
    final bool accepted,
  }) = _$AgreementImpl;

  factory _Agreement.fromJson(Map<String, dynamic> json) =
      _$AgreementImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get content;
  @override
  bool get accepted;

  /// Create a copy of Agreement
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AgreementImplCopyWith<_$AgreementImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
