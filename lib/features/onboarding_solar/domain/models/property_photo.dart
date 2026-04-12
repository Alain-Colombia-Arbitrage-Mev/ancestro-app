import 'package:freezed_annotation/freezed_annotation.dart';

part 'property_photo.freezed.dart';
part 'property_photo.g.dart';

enum PhotoCategory {
  roofFront,
  roofBack,
  electricalPanel,
  meter,
}

@freezed
class PropertyPhoto with _$PropertyPhoto {
  const factory PropertyPhoto({
    required String id,
    required PhotoCategory category,
    required String filePath,
    required DateTime uploadedAt,
  }) = _PropertyPhoto;

  factory PropertyPhoto.fromJson(Map<String, dynamic> json) =>
      _$PropertyPhotoFromJson(json);
}
