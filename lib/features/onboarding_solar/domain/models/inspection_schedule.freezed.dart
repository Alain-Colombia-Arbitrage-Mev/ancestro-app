// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inspection_schedule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

InspectionSchedule _$InspectionScheduleFromJson(Map<String, dynamic> json) {
  return _InspectionSchedule.fromJson(json);
}

/// @nodoc
mixin _$InspectionSchedule {
  DateTime get date => throw _privateConstructorUsedError;
  String get timeSlot => throw _privateConstructorUsedError;
  String? get inspectorName => throw _privateConstructorUsedError;
  String? get inspectorPhoto => throw _privateConstructorUsedError;
  String? get inspectorPhone => throw _privateConstructorUsedError;

  /// Serializes this InspectionSchedule to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InspectionSchedule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InspectionScheduleCopyWith<InspectionSchedule> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InspectionScheduleCopyWith<$Res> {
  factory $InspectionScheduleCopyWith(
    InspectionSchedule value,
    $Res Function(InspectionSchedule) then,
  ) = _$InspectionScheduleCopyWithImpl<$Res, InspectionSchedule>;
  @useResult
  $Res call({
    DateTime date,
    String timeSlot,
    String? inspectorName,
    String? inspectorPhoto,
    String? inspectorPhone,
  });
}

/// @nodoc
class _$InspectionScheduleCopyWithImpl<$Res, $Val extends InspectionSchedule>
    implements $InspectionScheduleCopyWith<$Res> {
  _$InspectionScheduleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InspectionSchedule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? timeSlot = null,
    Object? inspectorName = freezed,
    Object? inspectorPhoto = freezed,
    Object? inspectorPhone = freezed,
  }) {
    return _then(
      _value.copyWith(
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            timeSlot: null == timeSlot
                ? _value.timeSlot
                : timeSlot // ignore: cast_nullable_to_non_nullable
                      as String,
            inspectorName: freezed == inspectorName
                ? _value.inspectorName
                : inspectorName // ignore: cast_nullable_to_non_nullable
                      as String?,
            inspectorPhoto: freezed == inspectorPhoto
                ? _value.inspectorPhoto
                : inspectorPhoto // ignore: cast_nullable_to_non_nullable
                      as String?,
            inspectorPhone: freezed == inspectorPhone
                ? _value.inspectorPhone
                : inspectorPhone // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$InspectionScheduleImplCopyWith<$Res>
    implements $InspectionScheduleCopyWith<$Res> {
  factory _$$InspectionScheduleImplCopyWith(
    _$InspectionScheduleImpl value,
    $Res Function(_$InspectionScheduleImpl) then,
  ) = __$$InspectionScheduleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    DateTime date,
    String timeSlot,
    String? inspectorName,
    String? inspectorPhoto,
    String? inspectorPhone,
  });
}

/// @nodoc
class __$$InspectionScheduleImplCopyWithImpl<$Res>
    extends _$InspectionScheduleCopyWithImpl<$Res, _$InspectionScheduleImpl>
    implements _$$InspectionScheduleImplCopyWith<$Res> {
  __$$InspectionScheduleImplCopyWithImpl(
    _$InspectionScheduleImpl _value,
    $Res Function(_$InspectionScheduleImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InspectionSchedule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? timeSlot = null,
    Object? inspectorName = freezed,
    Object? inspectorPhoto = freezed,
    Object? inspectorPhone = freezed,
  }) {
    return _then(
      _$InspectionScheduleImpl(
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        timeSlot: null == timeSlot
            ? _value.timeSlot
            : timeSlot // ignore: cast_nullable_to_non_nullable
                  as String,
        inspectorName: freezed == inspectorName
            ? _value.inspectorName
            : inspectorName // ignore: cast_nullable_to_non_nullable
                  as String?,
        inspectorPhoto: freezed == inspectorPhoto
            ? _value.inspectorPhoto
            : inspectorPhoto // ignore: cast_nullable_to_non_nullable
                  as String?,
        inspectorPhone: freezed == inspectorPhone
            ? _value.inspectorPhone
            : inspectorPhone // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$InspectionScheduleImpl implements _InspectionSchedule {
  const _$InspectionScheduleImpl({
    required this.date,
    required this.timeSlot,
    this.inspectorName,
    this.inspectorPhoto,
    this.inspectorPhone,
  });

  factory _$InspectionScheduleImpl.fromJson(Map<String, dynamic> json) =>
      _$$InspectionScheduleImplFromJson(json);

  @override
  final DateTime date;
  @override
  final String timeSlot;
  @override
  final String? inspectorName;
  @override
  final String? inspectorPhoto;
  @override
  final String? inspectorPhone;

  @override
  String toString() {
    return 'InspectionSchedule(date: $date, timeSlot: $timeSlot, inspectorName: $inspectorName, inspectorPhoto: $inspectorPhoto, inspectorPhone: $inspectorPhone)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InspectionScheduleImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.timeSlot, timeSlot) ||
                other.timeSlot == timeSlot) &&
            (identical(other.inspectorName, inspectorName) ||
                other.inspectorName == inspectorName) &&
            (identical(other.inspectorPhoto, inspectorPhoto) ||
                other.inspectorPhoto == inspectorPhoto) &&
            (identical(other.inspectorPhone, inspectorPhone) ||
                other.inspectorPhone == inspectorPhone));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    date,
    timeSlot,
    inspectorName,
    inspectorPhoto,
    inspectorPhone,
  );

  /// Create a copy of InspectionSchedule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InspectionScheduleImplCopyWith<_$InspectionScheduleImpl> get copyWith =>
      __$$InspectionScheduleImplCopyWithImpl<_$InspectionScheduleImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$InspectionScheduleImplToJson(this);
  }
}

abstract class _InspectionSchedule implements InspectionSchedule {
  const factory _InspectionSchedule({
    required final DateTime date,
    required final String timeSlot,
    final String? inspectorName,
    final String? inspectorPhoto,
    final String? inspectorPhone,
  }) = _$InspectionScheduleImpl;

  factory _InspectionSchedule.fromJson(Map<String, dynamic> json) =
      _$InspectionScheduleImpl.fromJson;

  @override
  DateTime get date;
  @override
  String get timeSlot;
  @override
  String? get inspectorName;
  @override
  String? get inspectorPhoto;
  @override
  String? get inspectorPhone;

  /// Create a copy of InspectionSchedule
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InspectionScheduleImplCopyWith<_$InspectionScheduleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
