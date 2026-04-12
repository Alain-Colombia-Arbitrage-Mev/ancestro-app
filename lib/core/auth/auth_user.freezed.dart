// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AuthUser _$AuthUserFromJson(Map<String, dynamic> json) {
  return _AuthUser.fromJson(json);
}

/// @nodoc
mixin _$AuthUser {
  String get id => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  UserRole get role => throw _privateConstructorUsedError;
  PartnerType? get partnerType => throw _privateConstructorUsedError;
  String? get referredBy => throw _privateConstructorUsedError;
  bool get onboardingComplete => throw _privateConstructorUsedError;

  /// Serializes this AuthUser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AuthUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthUserCopyWith<AuthUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthUserCopyWith<$Res> {
  factory $AuthUserCopyWith(AuthUser value, $Res Function(AuthUser) then) =
      _$AuthUserCopyWithImpl<$Res, AuthUser>;
  @useResult
  $Res call({
    String id,
    String email,
    String? phone,
    UserRole role,
    PartnerType? partnerType,
    String? referredBy,
    bool onboardingComplete,
  });
}

/// @nodoc
class _$AuthUserCopyWithImpl<$Res, $Val extends AuthUser>
    implements $AuthUserCopyWith<$Res> {
  _$AuthUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? phone = freezed,
    Object? role = null,
    Object? partnerType = freezed,
    Object? referredBy = freezed,
    Object? onboardingComplete = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            phone: freezed == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String?,
            role: null == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as UserRole,
            partnerType: freezed == partnerType
                ? _value.partnerType
                : partnerType // ignore: cast_nullable_to_non_nullable
                      as PartnerType?,
            referredBy: freezed == referredBy
                ? _value.referredBy
                : referredBy // ignore: cast_nullable_to_non_nullable
                      as String?,
            onboardingComplete: null == onboardingComplete
                ? _value.onboardingComplete
                : onboardingComplete // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AuthUserImplCopyWith<$Res>
    implements $AuthUserCopyWith<$Res> {
  factory _$$AuthUserImplCopyWith(
    _$AuthUserImpl value,
    $Res Function(_$AuthUserImpl) then,
  ) = __$$AuthUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String email,
    String? phone,
    UserRole role,
    PartnerType? partnerType,
    String? referredBy,
    bool onboardingComplete,
  });
}

/// @nodoc
class __$$AuthUserImplCopyWithImpl<$Res>
    extends _$AuthUserCopyWithImpl<$Res, _$AuthUserImpl>
    implements _$$AuthUserImplCopyWith<$Res> {
  __$$AuthUserImplCopyWithImpl(
    _$AuthUserImpl _value,
    $Res Function(_$AuthUserImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? phone = freezed,
    Object? role = null,
    Object? partnerType = freezed,
    Object? referredBy = freezed,
    Object? onboardingComplete = null,
  }) {
    return _then(
      _$AuthUserImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        phone: freezed == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String?,
        role: null == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as UserRole,
        partnerType: freezed == partnerType
            ? _value.partnerType
            : partnerType // ignore: cast_nullable_to_non_nullable
                  as PartnerType?,
        referredBy: freezed == referredBy
            ? _value.referredBy
            : referredBy // ignore: cast_nullable_to_non_nullable
                  as String?,
        onboardingComplete: null == onboardingComplete
            ? _value.onboardingComplete
            : onboardingComplete // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthUserImpl implements _AuthUser {
  const _$AuthUserImpl({
    required this.id,
    required this.email,
    this.phone,
    required this.role,
    this.partnerType,
    this.referredBy,
    this.onboardingComplete = false,
  });

  factory _$AuthUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthUserImplFromJson(json);

  @override
  final String id;
  @override
  final String email;
  @override
  final String? phone;
  @override
  final UserRole role;
  @override
  final PartnerType? partnerType;
  @override
  final String? referredBy;
  @override
  @JsonKey()
  final bool onboardingComplete;

  @override
  String toString() {
    return 'AuthUser(id: $id, email: $email, phone: $phone, role: $role, partnerType: $partnerType, referredBy: $referredBy, onboardingComplete: $onboardingComplete)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthUserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.partnerType, partnerType) ||
                other.partnerType == partnerType) &&
            (identical(other.referredBy, referredBy) ||
                other.referredBy == referredBy) &&
            (identical(other.onboardingComplete, onboardingComplete) ||
                other.onboardingComplete == onboardingComplete));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    email,
    phone,
    role,
    partnerType,
    referredBy,
    onboardingComplete,
  );

  /// Create a copy of AuthUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthUserImplCopyWith<_$AuthUserImpl> get copyWith =>
      __$$AuthUserImplCopyWithImpl<_$AuthUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthUserImplToJson(this);
  }
}

abstract class _AuthUser implements AuthUser {
  const factory _AuthUser({
    required final String id,
    required final String email,
    final String? phone,
    required final UserRole role,
    final PartnerType? partnerType,
    final String? referredBy,
    final bool onboardingComplete,
  }) = _$AuthUserImpl;

  factory _AuthUser.fromJson(Map<String, dynamic> json) =
      _$AuthUserImpl.fromJson;

  @override
  String get id;
  @override
  String get email;
  @override
  String? get phone;
  @override
  UserRole get role;
  @override
  PartnerType? get partnerType;
  @override
  String? get referredBy;
  @override
  bool get onboardingComplete;

  /// Create a copy of AuthUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthUserImplCopyWith<_$AuthUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
