// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'partner_onboarding_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PartnerOnboardingState _$PartnerOnboardingStateFromJson(
  Map<String, dynamic> json,
) {
  return _PartnerOnboardingState.fromJson(json);
}

/// @nodoc
mixin _$PartnerOnboardingState {
  int get currentStep => throw _privateConstructorUsedError;
  PartnerType? get partnerType => throw _privateConstructorUsedError;
  PartnerContact? get contact => throw _privateConstructorUsedError;
  Map<String, dynamic> get details => throw _privateConstructorUsedError;
  bool get completed => throw _privateConstructorUsedError;

  /// Serializes this PartnerOnboardingState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PartnerOnboardingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PartnerOnboardingStateCopyWith<PartnerOnboardingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PartnerOnboardingStateCopyWith<$Res> {
  factory $PartnerOnboardingStateCopyWith(
    PartnerOnboardingState value,
    $Res Function(PartnerOnboardingState) then,
  ) = _$PartnerOnboardingStateCopyWithImpl<$Res, PartnerOnboardingState>;
  @useResult
  $Res call({
    int currentStep,
    PartnerType? partnerType,
    PartnerContact? contact,
    Map<String, dynamic> details,
    bool completed,
  });

  $PartnerContactCopyWith<$Res>? get contact;
}

/// @nodoc
class _$PartnerOnboardingStateCopyWithImpl<
  $Res,
  $Val extends PartnerOnboardingState
>
    implements $PartnerOnboardingStateCopyWith<$Res> {
  _$PartnerOnboardingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PartnerOnboardingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentStep = null,
    Object? partnerType = freezed,
    Object? contact = freezed,
    Object? details = null,
    Object? completed = null,
  }) {
    return _then(
      _value.copyWith(
            currentStep: null == currentStep
                ? _value.currentStep
                : currentStep // ignore: cast_nullable_to_non_nullable
                      as int,
            partnerType: freezed == partnerType
                ? _value.partnerType
                : partnerType // ignore: cast_nullable_to_non_nullable
                      as PartnerType?,
            contact: freezed == contact
                ? _value.contact
                : contact // ignore: cast_nullable_to_non_nullable
                      as PartnerContact?,
            details: null == details
                ? _value.details
                : details // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
            completed: null == completed
                ? _value.completed
                : completed // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of PartnerOnboardingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PartnerContactCopyWith<$Res>? get contact {
    if (_value.contact == null) {
      return null;
    }

    return $PartnerContactCopyWith<$Res>(_value.contact!, (value) {
      return _then(_value.copyWith(contact: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PartnerOnboardingStateImplCopyWith<$Res>
    implements $PartnerOnboardingStateCopyWith<$Res> {
  factory _$$PartnerOnboardingStateImplCopyWith(
    _$PartnerOnboardingStateImpl value,
    $Res Function(_$PartnerOnboardingStateImpl) then,
  ) = __$$PartnerOnboardingStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int currentStep,
    PartnerType? partnerType,
    PartnerContact? contact,
    Map<String, dynamic> details,
    bool completed,
  });

  @override
  $PartnerContactCopyWith<$Res>? get contact;
}

/// @nodoc
class __$$PartnerOnboardingStateImplCopyWithImpl<$Res>
    extends
        _$PartnerOnboardingStateCopyWithImpl<$Res, _$PartnerOnboardingStateImpl>
    implements _$$PartnerOnboardingStateImplCopyWith<$Res> {
  __$$PartnerOnboardingStateImplCopyWithImpl(
    _$PartnerOnboardingStateImpl _value,
    $Res Function(_$PartnerOnboardingStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PartnerOnboardingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentStep = null,
    Object? partnerType = freezed,
    Object? contact = freezed,
    Object? details = null,
    Object? completed = null,
  }) {
    return _then(
      _$PartnerOnboardingStateImpl(
        currentStep: null == currentStep
            ? _value.currentStep
            : currentStep // ignore: cast_nullable_to_non_nullable
                  as int,
        partnerType: freezed == partnerType
            ? _value.partnerType
            : partnerType // ignore: cast_nullable_to_non_nullable
                  as PartnerType?,
        contact: freezed == contact
            ? _value.contact
            : contact // ignore: cast_nullable_to_non_nullable
                  as PartnerContact?,
        details: null == details
            ? _value._details
            : details // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        completed: null == completed
            ? _value.completed
            : completed // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PartnerOnboardingStateImpl implements _PartnerOnboardingState {
  const _$PartnerOnboardingStateImpl({
    this.currentStep = 0,
    this.partnerType,
    this.contact,
    final Map<String, dynamic> details = const {},
    this.completed = false,
  }) : _details = details;

  factory _$PartnerOnboardingStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$PartnerOnboardingStateImplFromJson(json);

  @override
  @JsonKey()
  final int currentStep;
  @override
  final PartnerType? partnerType;
  @override
  final PartnerContact? contact;
  final Map<String, dynamic> _details;
  @override
  @JsonKey()
  Map<String, dynamic> get details {
    if (_details is EqualUnmodifiableMapView) return _details;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_details);
  }

  @override
  @JsonKey()
  final bool completed;

  @override
  String toString() {
    return 'PartnerOnboardingState(currentStep: $currentStep, partnerType: $partnerType, contact: $contact, details: $details, completed: $completed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PartnerOnboardingStateImpl &&
            (identical(other.currentStep, currentStep) ||
                other.currentStep == currentStep) &&
            (identical(other.partnerType, partnerType) ||
                other.partnerType == partnerType) &&
            (identical(other.contact, contact) || other.contact == contact) &&
            const DeepCollectionEquality().equals(other._details, _details) &&
            (identical(other.completed, completed) ||
                other.completed == completed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    currentStep,
    partnerType,
    contact,
    const DeepCollectionEquality().hash(_details),
    completed,
  );

  /// Create a copy of PartnerOnboardingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PartnerOnboardingStateImplCopyWith<_$PartnerOnboardingStateImpl>
  get copyWith =>
      __$$PartnerOnboardingStateImplCopyWithImpl<_$PartnerOnboardingStateImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PartnerOnboardingStateImplToJson(this);
  }
}

abstract class _PartnerOnboardingState implements PartnerOnboardingState {
  const factory _PartnerOnboardingState({
    final int currentStep,
    final PartnerType? partnerType,
    final PartnerContact? contact,
    final Map<String, dynamic> details,
    final bool completed,
  }) = _$PartnerOnboardingStateImpl;

  factory _PartnerOnboardingState.fromJson(Map<String, dynamic> json) =
      _$PartnerOnboardingStateImpl.fromJson;

  @override
  int get currentStep;
  @override
  PartnerType? get partnerType;
  @override
  PartnerContact? get contact;
  @override
  Map<String, dynamic> get details;
  @override
  bool get completed;

  /// Create a copy of PartnerOnboardingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PartnerOnboardingStateImplCopyWith<_$PartnerOnboardingStateImpl>
  get copyWith => throw _privateConstructorUsedError;
}
