import 'package:freezed_annotation/freezed_annotation.dart';

part 'uploaded_document.freezed.dart';
part 'uploaded_document.g.dart';

enum DocumentType {
  financialProof,
  idFront,
  idBack,
}

@freezed
class UploadedDocument with _$UploadedDocument {
  const factory UploadedDocument({
    required String id,
    required DocumentType type,
    required String filePath,
    required DateTime uploadedAt,
  }) = _UploadedDocument;

  factory UploadedDocument.fromJson(Map<String, dynamic> json) =>
      _$UploadedDocumentFromJson(json);
}
