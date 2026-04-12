// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'basic_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BasicInfo _$BasicInfoFromJson(Map<String, dynamic> json) {
  return _BasicInfo.fromJson(json);
}

/// @nodoc
mixin _$BasicInfo {
  String get fullName => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get state => throw _privateConstructorUsedError;
  String? get zipCode => throw _privateConstructorUsedError;

  /// Serializes this BasicInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BasicInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BasicInfoCopyWith<BasicInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BasicInfoCopyWith<$Res> {
  factory $BasicInfoCopyWith(BasicInfo value, $Res Function(BasicInfo) then) =
      _$BasicInfoCopyWithImpl<$Res, BasicInfo>;
  @useResult
  $Res call({
    String fullName,
    String phone,
    String address,
    String? city,
    String? state,
    String? zipCode,
  });
}

/// @nodoc
class _$BasicInfoCopyWithImpl<$Res, $Val extends BasicInfo>
    implements $BasicInfoCopyWith<$Res> {
  _$BasicInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BasicInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullName = null,
    Object? phone = null,
    Object? address = null,
    Object? city = freezed,
    Object? state = freezed,
    Object? zipCode = freezed,
  }) {
    return _then(
      _value.copyWith(
            fullName: null == fullName
                ? _value.fullName
                : fullName // ignore: cast_nullable_to_non_nullable
                      as String,
            phone: null == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String,
            address: null == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String,
            city: freezed == city
                ? _value.city
                : city // ignore: cast_nullable_to_non_nullable
                      as String?,
            state: freezed == state
                ? _value.state
                : state // ignore: cast_nullable_to_non_nullable
                      as String?,
            zipCode: freezed == zipCode
                ? _value.zipCode
                : zipCode // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BasicInfoImplCopyWith<$Res>
    implements $BasicInfoCopyWith<$Res> {
  factory _$$BasicInfoImplCopyWith(
    _$BasicInfoImpl value,
    $Res Function(_$BasicInfoImpl) then,
  ) = __$$BasicInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String fullName,
    String phone,
    String address,
    String? city,
    String? state,
    String? zipCode,
  });
}

/// @nodoc
class __$$BasicInfoImplCopyWithImpl<$Res>
    extends _$BasicInfoCopyWithImpl<$Res, _$BasicInfoImpl>
    implements _$$BasicInfoImplCopyWith<$Res> {
  __$$BasicInfoImplCopyWithImpl(
    _$BasicInfoImpl _value,
    $Res Function(_$BasicInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BasicInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullName = null,
    Object? phone = null,
    Object? address = null,
    Object? city = freezed,
    Object? state = freezed,
    Object? zipCode = freezed,
  }) {
    return _then(
      _$BasicInfoImpl(
        fullName: null == fullName
            ? _value.fullName
            : fullName // ignore: cast_nullable_to_non_nullable
                  as String,
        phone: null == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String,
        address: null == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String,
        city: freezed == city
            ? _value.city
            : city // ignore: cast_nullable_to_non_nullable
                  as String?,
        state: freezed == state
            ? _value.state
            : state // ignore: cast_nullable_to_non_nullable
                  as String?,
        zipCode: freezed == zipCode
            ? _value.zipCode
            : zipCode // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BasicInfoImpl implements _BasicInfo {
  const _$BasicInfoImpl({
    required this.fullName,
    required this.phone,
    required this.address,
    this.city,
    this.state,
    this.zipCode,
  });

  factory _$BasicInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$BasicInfoImplFromJson(json);

  @override
  final String fullName;
  @override
  final String phone;
  @override
  final String address;
  @override
  final String? city;
  @override
  final String? state;
  @override
  final String? zipCode;

  @override
  String toString() {
    return 'BasicInfo(fullName: $fullName, phone: $phone, address: $address, city: $city, state: $state, zipCode: $zipCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BasicInfoImpl &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.zipCode, zipCode) || other.zipCode == zipCode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, fullName, phone, address, city, state, zipCode);

  /// Create a copy of BasicInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BasicInfoImplCopyWith<_$BasicInfoImpl> get copyWith =>
      __$$BasicInfoImplCopyWithImpl<_$BasicInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BasicInfoImplToJson(this);
  }
}

abstract class _BasicInfo implements BasicInfo {
  const factory _BasicInfo({
    required final String fullName,
    required final String phone,
    required final String address,
    final String? city,
    final String? state,
    final String? zipCode,
  }) = _$BasicInfoImpl;

  factory _BasicInfo.fromJson(Map<String, dynamic> json) =
      _$BasicInfoImpl.fromJson;

  @override
  String get fullName;
  @override
  String get phone;
  @override
  String get address;
  @override
  String? get city;
  @override
  String? get state;
  @override
  String? get zipCode;

  /// Create a copy of BasicInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BasicInfoImplCopyWith<_$BasicInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
