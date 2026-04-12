import 'package:freezed_annotation/freezed_annotation.dart';

part 'basic_info.freezed.dart';
part 'basic_info.g.dart';

@freezed
class BasicInfo with _$BasicInfo {
  const factory BasicInfo({
    required String fullName,
    required String phone,
    required String address,
    String? city,
    String? state,
    String? zipCode,
  }) = _BasicInfo;

  factory BasicInfo.fromJson(Map<String, dynamic> json) =>
      _$BasicInfoFromJson(json);
}
