// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'solar_onboarding_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SolarOnboardingState _$SolarOnboardingStateFromJson(Map<String, dynamic> json) {
  return _SolarOnboardingState.fromJson(json);
}

/// @nodoc
mixin _$SolarOnboardingState {
  int get currentStep => throw _privateConstructorUsedError;
  SystemType get systemType => throw _privateConstructorUsedError;
  BasicInfo? get basicInfo => throw _privateConstructorUsedError;
  PropertyInfo? get propertyInfo => throw _privateConstructorUsedError;
  SolarProposal? get proposal => throw _privateConstructorUsedError;
  CreditStatus get creditStatus => throw _privateConstructorUsedError;
  List<UploadedDocument> get documents => throw _privateConstructorUsedError;
  List<Agreement> get agreements => throw _privateConstructorUsedError;
  List<PropertyPhoto> get propertyPhotos => throw _privateConstructorUsedError;
  InspectionSchedule? get inspection => throw _privateConstructorUsedError;
  bool get completed => throw _privateConstructorUsedError;

  /// Serializes this SolarOnboardingState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SolarOnboardingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SolarOnboardingStateCopyWith<SolarOnboardingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SolarOnboardingStateCopyWith<$Res> {
  factory $SolarOnboardingStateCopyWith(
    SolarOnboardingState value,
    $Res Function(SolarOnboardingState) then,
  ) = _$SolarOnboardingStateCopyWithImpl<$Res, SolarOnboardingState>;
  @useResult
  $Res call({
    int currentStep,
    SystemType systemType,
    BasicInfo? basicInfo,
    PropertyInfo? propertyInfo,
    SolarProposal? proposal,
    CreditStatus creditStatus,
    List<UploadedDocument> documents,
    List<Agreement> agreements,
    List<PropertyPhoto> propertyPhotos,
    InspectionSchedule? inspection,
    bool completed,
  });

  $BasicInfoCopyWith<$Res>? get basicInfo;
  $PropertyInfoCopyWith<$Res>? get propertyInfo;
  $SolarProposalCopyWith<$Res>? get proposal;
  $InspectionScheduleCopyWith<$Res>? get inspection;
}

/// @nodoc
class _$SolarOnboardingStateCopyWithImpl<
  $Res,
  $Val extends SolarOnboardingState
>
    implements $SolarOnboardingStateCopyWith<$Res> {
  _$SolarOnboardingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SolarOnboardingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentStep = null,
    Object? systemType = null,
    Object? basicInfo = freezed,
    Object? propertyInfo = freezed,
    Object? proposal = freezed,
    Object? creditStatus = null,
    Object? documents = null,
    Object? agreements = null,
    Object? propertyPhotos = null,
    Object? inspection = freezed,
    Object? completed = null,
  }) {
    return _then(
      _value.copyWith(
            currentStep: null == currentStep
                ? _value.currentStep
                : currentStep // ignore: cast_nullable_to_non_nullable
                      as int,
            systemType: null == systemType
                ? _value.systemType
                : systemType // ignore: cast_nullable_to_non_nullable
                      as SystemType,
            basicInfo: freezed == basicInfo
                ? _value.basicInfo
                : basicInfo // ignore: cast_nullable_to_non_nullable
                      as BasicInfo?,
            propertyInfo: freezed == propertyInfo
                ? _value.propertyInfo
                : propertyInfo // ignore: cast_nullable_to_non_nullable
                      as PropertyInfo?,
            proposal: freezed == proposal
                ? _value.proposal
                : proposal // ignore: cast_nullable_to_non_nullable
                      as SolarProposal?,
            creditStatus: null == creditStatus
                ? _value.creditStatus
                : creditStatus // ignore: cast_nullable_to_non_nullable
                      as CreditStatus,
            documents: null == documents
                ? _value.documents
                : documents // ignore: cast_nullable_to_non_nullable
                      as List<UploadedDocument>,
            agreements: null == agreements
                ? _value.agreements
                : agreements // ignore: cast_nullable_to_non_nullable
                      as List<Agreement>,
            propertyPhotos: null == propertyPhotos
                ? _value.propertyPhotos
                : propertyPhotos // ignore: cast_nullable_to_non_nullable
                      as List<PropertyPhoto>,
            inspection: freezed == inspection
                ? _value.inspection
                : inspection // ignore: cast_nullable_to_non_nullable
                      as InspectionSchedule?,
            completed: null == completed
                ? _value.completed
                : completed // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of SolarOnboardingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BasicInfoCopyWith<$Res>? get basicInfo {
    if (_value.basicInfo == null) {
      return null;
    }

    return $BasicInfoCopyWith<$Res>(_value.basicInfo!, (value) {
      return _then(_value.copyWith(basicInfo: value) as $Val);
    });
  }

  /// Create a copy of SolarOnboardingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PropertyInfoCopyWith<$Res>? get propertyInfo {
    if (_value.propertyInfo == null) {
      return null;
    }

    return $PropertyInfoCopyWith<$Res>(_value.propertyInfo!, (value) {
      return _then(_value.copyWith(propertyInfo: value) as $Val);
    });
  }

  /// Create a copy of SolarOnboardingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SolarProposalCopyWith<$Res>? get proposal {
    if (_value.proposal == null) {
      return null;
    }

    return $SolarProposalCopyWith<$Res>(_value.proposal!, (value) {
      return _then(_value.copyWith(proposal: value) as $Val);
    });
  }

  /// Create a copy of SolarOnboardingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $InspectionScheduleCopyWith<$Res>? get inspection {
    if (_value.inspection == null) {
      return null;
    }

    return $InspectionScheduleCopyWith<$Res>(_value.inspection!, (value) {
      return _then(_value.copyWith(inspection: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SolarOnboardingStateImplCopyWith<$Res>
    implements $SolarOnboardingStateCopyWith<$Res> {
  factory _$$SolarOnboardingStateImplCopyWith(
    _$SolarOnboardingStateImpl value,
    $Res Function(_$SolarOnboardingStateImpl) then,
  ) = __$$SolarOnboardingStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int currentStep,
    SystemType systemType,
    BasicInfo? basicInfo,
    PropertyInfo? propertyInfo,
    SolarProposal? proposal,
    CreditStatus creditStatus,
    List<UploadedDocument> documents,
    List<Agreement> agreements,
    List<PropertyPhoto> propertyPhotos,
    InspectionSchedule? inspection,
    bool completed,
  });

  @override
  $BasicInfoCopyWith<$Res>? get basicInfo;
  @override
  $PropertyInfoCopyWith<$Res>? get propertyInfo;
  @override
  $SolarProposalCopyWith<$Res>? get proposal;
  @override
  $InspectionScheduleCopyWith<$Res>? get inspection;
}

/// @nodoc
class __$$SolarOnboardingStateImplCopyWithImpl<$Res>
    extends _$SolarOnboardingStateCopyWithImpl<$Res, _$SolarOnboardingStateImpl>
    implements _$$SolarOnboardingStateImplCopyWith<$Res> {
  __$$SolarOnboardingStateImplCopyWithImpl(
    _$SolarOnboardingStateImpl _value,
    $Res Function(_$SolarOnboardingStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SolarOnboardingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentStep = null,
    Object? systemType = null,
    Object? basicInfo = freezed,
    Object? propertyInfo = freezed,
    Object? proposal = freezed,
    Object? creditStatus = null,
    Object? documents = null,
    Object? agreements = null,
    Object? propertyPhotos = null,
    Object? inspection = freezed,
    Object? completed = null,
  }) {
    return _then(
      _$SolarOnboardingStateImpl(
        currentStep: null == currentStep
            ? _value.currentStep
            : currentStep // ignore: cast_nullable_to_non_nullable
                  as int,
        systemType: null == systemType
            ? _value.systemType
            : systemType // ignore: cast_nullable_to_non_nullable
                  as SystemType,
        basicInfo: freezed == basicInfo
            ? _value.basicInfo
            : basicInfo // ignore: cast_nullable_to_non_nullable
                  as BasicInfo?,
        propertyInfo: freezed == propertyInfo
            ? _value.propertyInfo
            : propertyInfo // ignore: cast_nullable_to_non_nullable
                  as PropertyInfo?,
        proposal: freezed == proposal
            ? _value.proposal
            : proposal // ignore: cast_nullable_to_non_nullable
                  as SolarProposal?,
        creditStatus: null == creditStatus
            ? _value.creditStatus
            : creditStatus // ignore: cast_nullable_to_non_nullable
                  as CreditStatus,
        documents: null == documents
            ? _value._documents
            : documents // ignore: cast_nullable_to_non_nullable
                  as List<UploadedDocument>,
        agreements: null == agreements
            ? _value._agreements
            : agreements // ignore: cast_nullable_to_non_nullable
                  as List<Agreement>,
        propertyPhotos: null == propertyPhotos
            ? _value._propertyPhotos
            : propertyPhotos // ignore: cast_nullable_to_non_nullable
                  as List<PropertyPhoto>,
        inspection: freezed == inspection
            ? _value.inspection
            : inspection // ignore: cast_nullable_to_non_nullable
                  as InspectionSchedule?,
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
class _$SolarOnboardingStateImpl implements _SolarOnboardingState {
  const _$SolarOnboardingStateImpl({
    this.currentStep = 0,
    this.systemType = SystemType.solar,
    this.basicInfo,
    this.propertyInfo,
    this.proposal,
    this.creditStatus = CreditStatus.pending,
    final List<UploadedDocument> documents = const [],
    final List<Agreement> agreements = const [],
    final List<PropertyPhoto> propertyPhotos = const [],
    this.inspection,
    this.completed = false,
  }) : _documents = documents,
       _agreements = agreements,
       _propertyPhotos = propertyPhotos;

  factory _$SolarOnboardingStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$SolarOnboardingStateImplFromJson(json);

  @override
  @JsonKey()
  final int currentStep;
  @override
  @JsonKey()
  final SystemType systemType;
  @override
  final BasicInfo? basicInfo;
  @override
  final PropertyInfo? propertyInfo;
  @override
  final SolarProposal? proposal;
  @override
  @JsonKey()
  final CreditStatus creditStatus;
  final List<UploadedDocument> _documents;
  @override
  @JsonKey()
  List<UploadedDocument> get documents {
    if (_documents is EqualUnmodifiableListView) return _documents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_documents);
  }

  final List<Agreement> _agreements;
  @override
  @JsonKey()
  List<Agreement> get agreements {
    if (_agreements is EqualUnmodifiableListView) return _agreements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_agreements);
  }

  final List<PropertyPhoto> _propertyPhotos;
  @override
  @JsonKey()
  List<PropertyPhoto> get propertyPhotos {
    if (_propertyPhotos is EqualUnmodifiableListView) return _propertyPhotos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_propertyPhotos);
  }

  @override
  final InspectionSchedule? inspection;
  @override
  @JsonKey()
  final bool completed;

  @override
  String toString() {
    return 'SolarOnboardingState(currentStep: $currentStep, systemType: $systemType, basicInfo: $basicInfo, propertyInfo: $propertyInfo, proposal: $proposal, creditStatus: $creditStatus, documents: $documents, agreements: $agreements, propertyPhotos: $propertyPhotos, inspection: $inspection, completed: $completed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SolarOnboardingStateImpl &&
            (identical(other.currentStep, currentStep) ||
                other.currentStep == currentStep) &&
            (identical(other.systemType, systemType) ||
                other.systemType == systemType) &&
            (identical(other.basicInfo, basicInfo) ||
                other.basicInfo == basicInfo) &&
            (identical(other.propertyInfo, propertyInfo) ||
                other.propertyInfo == propertyInfo) &&
            (identical(other.proposal, proposal) ||
                other.proposal == proposal) &&
            (identical(other.creditStatus, creditStatus) ||
                other.creditStatus == creditStatus) &&
            const DeepCollectionEquality().equals(
              other._documents,
              _documents,
            ) &&
            const DeepCollectionEquality().equals(
              other._agreements,
              _agreements,
            ) &&
            const DeepCollectionEquality().equals(
              other._propertyPhotos,
              _propertyPhotos,
            ) &&
            (identical(other.inspection, inspection) ||
                other.inspection == inspection) &&
            (identical(other.completed, completed) ||
                other.completed == completed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    currentStep,
    systemType,
    basicInfo,
    propertyInfo,
    proposal,
    creditStatus,
    const DeepCollectionEquality().hash(_documents),
    const DeepCollectionEquality().hash(_agreements),
    const DeepCollectionEquality().hash(_propertyPhotos),
    inspection,
    completed,
  );

  /// Create a copy of SolarOnboardingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SolarOnboardingStateImplCopyWith<_$SolarOnboardingStateImpl>
  get copyWith =>
      __$$SolarOnboardingStateImplCopyWithImpl<_$SolarOnboardingStateImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SolarOnboardingStateImplToJson(this);
  }
}

abstract class _SolarOnboardingState implements SolarOnboardingState {
  const factory _SolarOnboardingState({
    final int currentStep,
    final SystemType systemType,
    final BasicInfo? basicInfo,
    final PropertyInfo? propertyInfo,
    final SolarProposal? proposal,
    final CreditStatus creditStatus,
    final List<UploadedDocument> documents,
    final List<Agreement> agreements,
    final List<PropertyPhoto> propertyPhotos,
    final InspectionSchedule? inspection,
    final bool completed,
  }) = _$SolarOnboardingStateImpl;

  factory _SolarOnboardingState.fromJson(Map<String, dynamic> json) =
      _$SolarOnboardingStateImpl.fromJson;

  @override
  int get currentStep;
  @override
  SystemType get systemType;
  @override
  BasicInfo? get basicInfo;
  @override
  PropertyInfo? get propertyInfo;
  @override
  SolarProposal? get proposal;
  @override
  CreditStatus get creditStatus;
  @override
  List<UploadedDocument> get documents;
  @override
  List<Agreement> get agreements;
  @override
  List<PropertyPhoto> get propertyPhotos;
  @override
  InspectionSchedule? get inspection;
  @override
  bool get completed;

  /// Create a copy of SolarOnboardingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SolarOnboardingStateImplCopyWith<_$SolarOnboardingStateImpl>
  get copyWith => throw _privateConstructorUsedError;
}
