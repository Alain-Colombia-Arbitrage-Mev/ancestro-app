// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'uploaded_document.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UploadedDocument _$UploadedDocumentFromJson(Map<String, dynamic> json) {
  return _UploadedDocument.fromJson(json);
}

/// @nodoc
mixin _$UploadedDocument {
  String get id => throw _privateConstructorUsedError;
  DocumentType get type => throw _privateConstructorUsedError;
  String get filePath => throw _privateConstructorUsedError;
  DateTime get uploadedAt => throw _privateConstructorUsedError;

  /// Serializes this UploadedDocument to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UploadedDocument
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UploadedDocumentCopyWith<UploadedDocument> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UploadedDocumentCopyWith<$Res> {
  factory $UploadedDocumentCopyWith(
    UploadedDocument value,
    $Res Function(UploadedDocument) then,
  ) = _$UploadedDocumentCopyWithImpl<$Res, UploadedDocument>;
  @useResult
  $Res call({
    String id,
    DocumentType type,
    String filePath,
    DateTime uploadedAt,
  });
}

/// @nodoc
class _$UploadedDocumentCopyWithImpl<$Res, $Val extends UploadedDocument>
    implements $UploadedDocumentCopyWith<$Res> {
  _$UploadedDocumentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UploadedDocument
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? filePath = null,
    Object? uploadedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as DocumentType,
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
abstract class _$$UploadedDocumentImplCopyWith<$Res>
    implements $UploadedDocumentCopyWith<$Res> {
  factory _$$UploadedDocumentImplCopyWith(
    _$UploadedDocumentImpl value,
    $Res Function(_$UploadedDocumentImpl) then,
  ) = __$$UploadedDocumentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    DocumentType type,
    String filePath,
    DateTime uploadedAt,
  });
}

/// @nodoc
class __$$UploadedDocumentImplCopyWithImpl<$Res>
    extends _$UploadedDocumentCopyWithImpl<$Res, _$UploadedDocumentImpl>
    implements _$$UploadedDocumentImplCopyWith<$Res> {
  __$$UploadedDocumentImplCopyWithImpl(
    _$UploadedDocumentImpl _value,
    $Res Function(_$UploadedDocumentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UploadedDocument
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? filePath = null,
    Object? uploadedAt = null,
  }) {
    return _then(
      _$UploadedDocumentImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as DocumentType,
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
class _$UploadedDocumentImpl implements _UploadedDocument {
  const _$UploadedDocumentImpl({
    required this.id,
    required this.type,
    required this.filePath,
    required this.uploadedAt,
  });

  factory _$UploadedDocumentImpl.fromJson(Map<String, dynamic> json) =>
      _$$UploadedDocumentImplFromJson(json);

  @override
  final String id;
  @override
  final DocumentType type;
  @override
  final String filePath;
  @override
  final DateTime uploadedAt;

  @override
  String toString() {
    return 'UploadedDocument(id: $id, type: $type, filePath: $filePath, uploadedAt: $uploadedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UploadedDocumentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.filePath, filePath) ||
                other.filePath == filePath) &&
            (identical(other.uploadedAt, uploadedAt) ||
                other.uploadedAt == uploadedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, type, filePath, uploadedAt);

  /// Create a copy of UploadedDocument
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UploadedDocumentImplCopyWith<_$UploadedDocumentImpl> get copyWith =>
      __$$UploadedDocumentImplCopyWithImpl<_$UploadedDocumentImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UploadedDocumentImplToJson(this);
  }
}

abstract class _UploadedDocument implements UploadedDocument {
  const factory _UploadedDocument({
    required final String id,
    required final DocumentType type,
    required final String filePath,
    required final DateTime uploadedAt,
  }) = _$UploadedDocumentImpl;

  factory _UploadedDocument.fromJson(Map<String, dynamic> json) =
      _$UploadedDocumentImpl.fromJson;

  @override
  String get id;
  @override
  DocumentType get type;
  @override
  String get filePath;
  @override
  DateTime get uploadedAt;

  /// Create a copy of UploadedDocument
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UploadedDocumentImplCopyWith<_$UploadedDocumentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
