// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'property_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PropertyInfo _$PropertyInfoFromJson(Map<String, dynamic> json) {
  return _PropertyInfo.fromJson(json);
}

/// @nodoc
mixin _$PropertyInfo {
  PropertyType get propertyType => throw _privateConstructorUsedError;
  double get roofSizeSqFt => throw _privateConstructorUsedError;
  double get monthlyConsumptionKwh => throw _privateConstructorUsedError;
  String? get utilityProvider => throw _privateConstructorUsedError;

  /// Serializes this PropertyInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PropertyInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PropertyInfoCopyWith<PropertyInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PropertyInfoCopyWith<$Res> {
  factory $PropertyInfoCopyWith(
    PropertyInfo value,
    $Res Function(PropertyInfo) then,
  ) = _$PropertyInfoCopyWithImpl<$Res, PropertyInfo>;
  @useResult
  $Res call({
    PropertyType propertyType,
    double roofSizeSqFt,
    double monthlyConsumptionKwh,
    String? utilityProvider,
  });
}

/// @nodoc
class _$PropertyInfoCopyWithImpl<$Res, $Val extends PropertyInfo>
    implements $PropertyInfoCopyWith<$Res> {
  _$PropertyInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PropertyInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? propertyType = null,
    Object? roofSizeSqFt = null,
    Object? monthlyConsumptionKwh = null,
    Object? utilityProvider = freezed,
  }) {
    return _then(
      _value.copyWith(
            propertyType: null == propertyType
                ? _value.propertyType
                : propertyType // ignore: cast_nullable_to_non_nullable
                      as PropertyType,
            roofSizeSqFt: null == roofSizeSqFt
                ? _value.roofSizeSqFt
                : roofSizeSqFt // ignore: cast_nullable_to_non_nullable
                      as double,
            monthlyConsumptionKwh: null == monthlyConsumptionKwh
                ? _value.monthlyConsumptionKwh
                : monthlyConsumptionKwh // ignore: cast_nullable_to_non_nullable
                      as double,
            utilityProvider: freezed == utilityProvider
                ? _value.utilityProvider
                : utilityProvider // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PropertyInfoImplCopyWith<$Res>
    implements $PropertyInfoCopyWith<$Res> {
  factory _$$PropertyInfoImplCopyWith(
    _$PropertyInfoImpl value,
    $Res Function(_$PropertyInfoImpl) then,
  ) = __$$PropertyInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    PropertyType propertyType,
    double roofSizeSqFt,
    double monthlyConsumptionKwh,
    String? utilityProvider,
  });
}

/// @nodoc
class __$$PropertyInfoImplCopyWithImpl<$Res>
    extends _$PropertyInfoCopyWithImpl<$Res, _$PropertyInfoImpl>
    implements _$$PropertyInfoImplCopyWith<$Res> {
  __$$PropertyInfoImplCopyWithImpl(
    _$PropertyInfoImpl _value,
    $Res Function(_$PropertyInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PropertyInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? propertyType = null,
    Object? roofSizeSqFt = null,
    Object? monthlyConsumptionKwh = null,
    Object? utilityProvider = freezed,
  }) {
    return _then(
      _$PropertyInfoImpl(
        propertyType: null == propertyType
            ? _value.propertyType
            : propertyType // ignore: cast_nullable_to_non_nullable
                  as PropertyType,
        roofSizeSqFt: null == roofSizeSqFt
            ? _value.roofSizeSqFt
            : roofSizeSqFt // ignore: cast_nullable_to_non_nullable
                  as double,
        monthlyConsumptionKwh: null == monthlyConsumptionKwh
            ? _value.monthlyConsumptionKwh
            : monthlyConsumptionKwh // ignore: cast_nullable_to_non_nullable
                  as double,
        utilityProvider: freezed == utilityProvider
            ? _value.utilityProvider
            : utilityProvider // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PropertyInfoImpl implements _PropertyInfo {
  const _$PropertyInfoImpl({
    required this.propertyType,
    required this.roofSizeSqFt,
    required this.monthlyConsumptionKwh,
    this.utilityProvider,
  });

  factory _$PropertyInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PropertyInfoImplFromJson(json);

  @override
  final PropertyType propertyType;
  @override
  final double roofSizeSqFt;
  @override
  final double monthlyConsumptionKwh;
  @override
  final String? utilityProvider;

  @override
  String toString() {
    return 'PropertyInfo(propertyType: $propertyType, roofSizeSqFt: $roofSizeSqFt, monthlyConsumptionKwh: $monthlyConsumptionKwh, utilityProvider: $utilityProvider)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PropertyInfoImpl &&
            (identical(other.propertyType, propertyType) ||
                other.propertyType == propertyType) &&
            (identical(other.roofSizeSqFt, roofSizeSqFt) ||
                other.roofSizeSqFt == roofSizeSqFt) &&
            (identical(other.monthlyConsumptionKwh, monthlyConsumptionKwh) ||
                other.monthlyConsumptionKwh == monthlyConsumptionKwh) &&
            (identical(other.utilityProvider, utilityProvider) ||
                other.utilityProvider == utilityProvider));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    propertyType,
    roofSizeSqFt,
    monthlyConsumptionKwh,
    utilityProvider,
  );

  /// Create a copy of PropertyInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PropertyInfoImplCopyWith<_$PropertyInfoImpl> get copyWith =>
      __$$PropertyInfoImplCopyWithImpl<_$PropertyInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PropertyInfoImplToJson(this);
  }
}

abstract class _PropertyInfo implements PropertyInfo {
  const factory _PropertyInfo({
    required final PropertyType propertyType,
    required final double roofSizeSqFt,
    required final double monthlyConsumptionKwh,
    final String? utilityProvider,
  }) = _$PropertyInfoImpl;

  factory _PropertyInfo.fromJson(Map<String, dynamic> json) =
      _$PropertyInfoImpl.fromJson;

  @override
  PropertyType get propertyType;
  @override
  double get roofSizeSqFt;
  @override
  double get monthlyConsumptionKwh;
  @override
  String? get utilityProvider;

  /// Create a copy of PropertyInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PropertyInfoImplCopyWith<_$PropertyInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
