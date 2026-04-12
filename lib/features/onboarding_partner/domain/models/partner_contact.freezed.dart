// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'partner_contact.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PartnerContact _$PartnerContactFromJson(Map<String, dynamic> json) {
  return _PartnerContact.fromJson(json);
}

/// @nodoc
mixin _$PartnerContact {
  String get fullName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String get country => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  String? get company => throw _privateConstructorUsedError;

  /// Serializes this PartnerContact to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PartnerContact
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PartnerContactCopyWith<PartnerContact> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PartnerContactCopyWith<$Res> {
  factory $PartnerContactCopyWith(
    PartnerContact value,
    $Res Function(PartnerContact) then,
  ) = _$PartnerContactCopyWithImpl<$Res, PartnerContact>;
  @useResult
  $Res call({
    String fullName,
    String email,
    String phone,
    String country,
    String city,
    String? company,
  });
}

/// @nodoc
class _$PartnerContactCopyWithImpl<$Res, $Val extends PartnerContact>
    implements $PartnerContactCopyWith<$Res> {
  _$PartnerContactCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PartnerContact
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullName = null,
    Object? email = null,
    Object? phone = null,
    Object? country = null,
    Object? city = null,
    Object? company = freezed,
  }) {
    return _then(
      _value.copyWith(
            fullName: null == fullName
                ? _value.fullName
                : fullName // ignore: cast_nullable_to_non_nullable
                      as String,
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            phone: null == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String,
            country: null == country
                ? _value.country
                : country // ignore: cast_nullable_to_non_nullable
                      as String,
            city: null == city
                ? _value.city
                : city // ignore: cast_nullable_to_non_nullable
                      as String,
            company: freezed == company
                ? _value.company
                : company // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PartnerContactImplCopyWith<$Res>
    implements $PartnerContactCopyWith<$Res> {
  factory _$$PartnerContactImplCopyWith(
    _$PartnerContactImpl value,
    $Res Function(_$PartnerContactImpl) then,
  ) = __$$PartnerContactImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String fullName,
    String email,
    String phone,
    String country,
    String city,
    String? company,
  });
}

/// @nodoc
class __$$PartnerContactImplCopyWithImpl<$Res>
    extends _$PartnerContactCopyWithImpl<$Res, _$PartnerContactImpl>
    implements _$$PartnerContactImplCopyWith<$Res> {
  __$$PartnerContactImplCopyWithImpl(
    _$PartnerContactImpl _value,
    $Res Function(_$PartnerContactImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PartnerContact
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullName = null,
    Object? email = null,
    Object? phone = null,
    Object? country = null,
    Object? city = null,
    Object? company = freezed,
  }) {
    return _then(
      _$PartnerContactImpl(
        fullName: null == fullName
            ? _value.fullName
            : fullName // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        phone: null == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String,
        country: null == country
            ? _value.country
            : country // ignore: cast_nullable_to_non_nullable
                  as String,
        city: null == city
            ? _value.city
            : city // ignore: cast_nullable_to_non_nullable
                  as String,
        company: freezed == company
            ? _value.company
            : company // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PartnerContactImpl implements _PartnerContact {
  const _$PartnerContactImpl({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.country,
    required this.city,
    this.company,
  });

  factory _$PartnerContactImpl.fromJson(Map<String, dynamic> json) =>
      _$$PartnerContactImplFromJson(json);

  @override
  final String fullName;
  @override
  final String email;
  @override
  final String phone;
  @override
  final String country;
  @override
  final String city;
  @override
  final String? company;

  @override
  String toString() {
    return 'PartnerContact(fullName: $fullName, email: $email, phone: $phone, country: $country, city: $city, company: $company)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PartnerContactImpl &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.company, company) || other.company == company));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, fullName, email, phone, country, city, company);

  /// Create a copy of PartnerContact
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PartnerContactImplCopyWith<_$PartnerContactImpl> get copyWith =>
      __$$PartnerContactImplCopyWithImpl<_$PartnerContactImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PartnerContactImplToJson(this);
  }
}

abstract class _PartnerContact implements PartnerContact {
  const factory _PartnerContact({
    required final String fullName,
    required final String email,
    required final String phone,
    required final String country,
    required final String city,
    final String? company,
  }) = _$PartnerContactImpl;

  factory _PartnerContact.fromJson(Map<String, dynamic> json) =
      _$PartnerContactImpl.fromJson;

  @override
  String get fullName;
  @override
  String get email;
  @override
  String get phone;
  @override
  String get country;
  @override
  String get city;
  @override
  String? get company;

  /// Create a copy of PartnerContact
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PartnerContactImplCopyWith<_$PartnerContactImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
