import 'package:freezed_annotation/freezed_annotation.dart';

part 'property_info.freezed.dart';
part 'property_info.g.dart';

enum PropertyType {
  singleFamily,
  multiFamily,
  commercial,
  other,
}

@freezed
class PropertyInfo with _$PropertyInfo {
  const factory PropertyInfo({
    required PropertyType propertyType,
    required double roofSizeSqFt,
    required double monthlyConsumptionKwh,
    String? utilityProvider,
  }) = _PropertyInfo;

  factory PropertyInfo.fromJson(Map<String, dynamic> json) =>
      _$PropertyInfoFromJson(json);
}
