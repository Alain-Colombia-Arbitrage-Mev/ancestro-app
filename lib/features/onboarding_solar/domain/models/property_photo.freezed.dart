// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'property_photo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PropertyPhoto _$PropertyPhotoFromJson(Map<String, dynamic> json) {
  return _PropertyPhoto.fromJson(json);
}

/// @nodoc
mixin _$PropertyPhoto {
  String get id => throw _privateConstructorUsedError;
  PhotoCategory get category => throw _privateConstructorUsedError;
  String get filePath => throw _privateConstructorUsedError;
  DateTime get uploadedAt => throw _privateConstructorUsedError;

  /// Serializes this PropertyPhoto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PropertyPhoto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PropertyPhotoCopyWith<PropertyPhoto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PropertyPhotoCopyWith<$Res> {
  factory $PropertyPhotoCopyWith(
    PropertyPhoto value,
    $Res Function(PropertyPhoto) then,
  ) = _$PropertyPhotoCopyWithImpl<$Res, PropertyPhoto>;
  @useResult
  $Res call({
    String id,
    PhotoCategory category,
    String filePath,
    DateTime uploadedAt,
  });
}

/// @nodoc
class _$PropertyPhotoCopyWithImpl<$Res, $Val extends PropertyPhoto>
    implements $PropertyPhotoCopyWith<$Res> {
  _$PropertyPhotoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PropertyPhoto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? category = null,
    Object? filePath = null,
    Object? uploadedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as PhotoCategory,
            filePath: null == filePath
                ? _value.filePath
                : filePath // ignore: cast_nullable_to_non_nullable
                      as String,
            uploadedAt: null == uploadedAt
                ? _value.uploadedAt
                : uploadedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PropertyPhotoImplCopyWith<$Res>
    implements $PropertyPhotoCopyWith<$Res> {
  factory _$$PropertyPhotoImplCopyWith(
    _$PropertyPhotoImpl value,
    $Res Function(_$PropertyPhotoImpl) then,
  ) = __$$PropertyPhotoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    PhotoCategory category,
    String filePath,
    DateTime uploadedAt,
  });
}

/// @nodoc
class __$$PropertyPhotoImplCopyWithImpl<$Res>
    extends _$PropertyPhotoCopyWithImpl<$Res, _$PropertyPhotoImpl>
    implements _$$PropertyPhotoImplCopyWith<$Res> {
  __$$PropertyPhotoImplCopyWithImpl(
    _$PropertyPhotoImpl _value,
    $Res Function(_$PropertyPhotoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PropertyPhoto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? category = null,
    Object? filePath = null,
    Object? uploadedAt = null,
  }) {
    return _then(
      _$PropertyPhotoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as PhotoCategory,
        filePath: null == filePath
            ? _value.filePath
            : filePath // ignore: cast_nullable_to_non_nullable
                  as String,
        uploadedAt: null == uploadedAt
            ? _value.uploadedAt
            : uploadedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PropertyPhotoImpl implements _PropertyPhoto {
  const _$PropertyPhotoImpl({
    required this.id,
    required this.category,
    required this.filePath,
    required this.uploadedAt,
  });

  factory _$PropertyPhotoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PropertyPhotoImplFromJson(json);

  @override
  final String id;
  @override
  final PhotoCategory category;
  @override
  final String filePath;
  @override
  final DateTime uploadedAt;

  @override
  String toString() {
    return 'PropertyPhoto(id: $id, category: $category, filePath: $filePath, uploadedAt: $uploadedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PropertyPhotoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.filePath, filePath) ||
                other.filePath == filePath) &&
            (identical(other.uploadedAt, uploadedAt) ||
                other.uploadedAt == uploadedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, category, filePath, uploadedAt);

  /// Create a copy of PropertyPhoto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PropertyPhotoImplCopyWith<_$PropertyPhotoImpl> get copyWith =>
      __$$PropertyPhotoImplCopyWithImpl<_$PropertyPhotoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PropertyPhotoImplToJson(this);
  }
}

abstract class _PropertyPhoto implements PropertyPhoto {
  const factory _PropertyPhoto({
    required final String id,
    required final PhotoCategory category,
    required final String filePath,
    required final DateTime uploadedAt,
  }) = _$PropertyPhotoImpl;

  factory _PropertyPhoto.fromJson(Map<String, dynamic> json) =
      _$PropertyPhotoImpl.fromJson;

  @override
  String get id;
  @override
  PhotoCategory get category;
  @override
  String get filePath;
  @override
  DateTime get uploadedAt;

  /// Create a copy of PropertyPhoto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PropertyPhotoImplCopyWith<_$PropertyPhotoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
