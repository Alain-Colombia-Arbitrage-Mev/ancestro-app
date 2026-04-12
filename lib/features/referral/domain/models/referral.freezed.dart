// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'referral.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Referral _$ReferralFromJson(Map<String, dynamic> json) {
  return _Referral.fromJson(json);
}

/// @nodoc
mixin _$Referral {
  String get code => throw _privateConstructorUsedError;
  String get referrerId => throw _privateConstructorUsedError;
  String? get referredEmail => throw _privateConstructorUsedError;
  ReferralStatus get status => throw _privateConstructorUsedError;
  double? get reward => throw _privateConstructorUsedError;

  /// Serializes this Referral to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Referral
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReferralCopyWith<Referral> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReferralCopyWith<$Res> {
  factory $ReferralCopyWith(Referral value, $Res Function(Referral) then) =
      _$ReferralCopyWithImpl<$Res, Referral>;
  @useResult
  $Res call({
    String code,
    String referrerId,
    String? referredEmail,
    ReferralStatus status,
    double? reward,
  });
}

/// @nodoc
class _$ReferralCopyWithImpl<$Res, $Val extends Referral>
    implements $ReferralCopyWith<$Res> {
  _$ReferralCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Referral
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? referrerId = null,
    Object? referredEmail = freezed,
    Object? status = null,
    Object? reward = freezed,
  }) {
    return _then(
      _value.copyWith(
            code: null == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                      as String,
            referrerId: null == referrerId
                ? _value.referrerId
                : referrerId // ignore: cast_nullable_to_non_nullable
                      as String,
            referredEmail: freezed == referredEmail
                ? _value.referredEmail
                : referredEmail // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as ReferralStatus,
            reward: freezed == reward
                ? _value.reward
                : reward // ignore: cast_nullable_to_non_nullable
                      as double?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ReferralImplCopyWith<$Res>
    implements $ReferralCopyWith<$Res> {
  factory _$$ReferralImplCopyWith(
    _$ReferralImpl value,
    $Res Function(_$ReferralImpl) then,
  ) = __$$ReferralImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String code,
    String referrerId,
    String? referredEmail,
    ReferralStatus status,
    double? reward,
  });
}

/// @nodoc
class __$$ReferralImplCopyWithImpl<$Res>
    extends _$ReferralCopyWithImpl<$Res, _$ReferralImpl>
    implements _$$ReferralImplCopyWith<$Res> {
  __$$ReferralImplCopyWithImpl(
    _$ReferralImpl _value,
    $Res Function(_$ReferralImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Referral
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? referrerId = null,
    Object? referredEmail = freezed,
    Object? status = null,
    Object? reward = freezed,
  }) {
    return _then(
      _$ReferralImpl(
        code: null == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String,
        referrerId: null == referrerId
            ? _value.referrerId
            : referrerId // ignore: cast_nullable_to_non_nullable
                  as String,
        referredEmail: freezed == referredEmail
            ? _value.referredEmail
            : referredEmail // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as ReferralStatus,
        reward: freezed == reward
            ? _value.reward
            : reward // ignore: cast_nullable_to_non_nullable
                  as double?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ReferralImpl implements _Referral {
  const _$ReferralImpl({
    required this.code,
    required this.referrerId,
    this.referredEmail,
    required this.status,
    this.reward,
  });

  factory _$ReferralImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReferralImplFromJson(json);

  @override
  final String code;
  @override
  final String referrerId;
  @override
  final String? referredEmail;
  @override
  final ReferralStatus status;
  @override
  final double? reward;

  @override
  String toString() {
    return 'Referral(code: $code, referrerId: $referrerId, referredEmail: $referredEmail, status: $status, reward: $reward)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReferralImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.referrerId, referrerId) ||
                other.referrerId == referrerId) &&
            (identical(other.referredEmail, referredEmail) ||
                other.referredEmail == referredEmail) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.reward, reward) || other.reward == reward));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, code, referrerId, referredEmail, status, reward);

  /// Create a copy of Referral
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReferralImplCopyWith<_$ReferralImpl> get copyWith =>
      __$$ReferralImplCopyWithImpl<_$ReferralImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReferralImplToJson(this);
  }
}

abstract class _Referral implements Referral {
  const factory _Referral({
    required final String code,
    required final String referrerId,
    final String? referredEmail,
    required final ReferralStatus status,
    final double? reward,
  }) = _$ReferralImpl;

  factory _Referral.fromJson(Map<String, dynamic> json) =
      _$ReferralImpl.fromJson;

  @override
  String get code;
  @override
  String get referrerId;
  @override
  String? get referredEmail;
  @override
  ReferralStatus get status;
  @override
  double? get reward;

  /// Create a copy of Referral
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReferralImplCopyWith<_$ReferralImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
