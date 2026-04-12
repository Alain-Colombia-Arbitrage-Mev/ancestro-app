import 'package:freezed_annotation/freezed_annotation.dart';

part 'agreement.freezed.dart';
part 'agreement.g.dart';

@freezed
class Agreement with _$Agreement {
  const factory Agreement({
    required String id,
    required String title,
    required String content,
    @Default(false) bool accepted,
  }) = _Agreement;

  factory Agreement.fromJson(Map<String, dynamic> json) =>
      _$AgreementFromJson(json);
}
