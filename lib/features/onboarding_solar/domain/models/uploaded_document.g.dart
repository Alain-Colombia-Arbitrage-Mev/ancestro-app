// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'uploaded_document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UploadedDocumentImpl _$$UploadedDocumentImplFromJson(
  Map<String, dynamic> json,
) => _$UploadedDocumentImpl(
  id: json['id'] as String,
  type: $enumDecode(_$DocumentTypeEnumMap, json['type']),
  filePath: json['filePath'] as String,
  uploadedAt: DateTime.parse(json['uploadedAt'] as String),
);

Map<String, dynamic> _$$UploadedDocumentImplToJson(
  _$UploadedDocumentImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': _$DocumentTypeEnumMap[instance.type]!,
  'filePath': instance.filePath,
  'uploadedAt': instance.uploadedAt.toIso8601String(),
};

const _$DocumentTypeEnumMap = {
  DocumentType.financialProof: 'financialProof',
  DocumentType.idFront: 'idFront',
  DocumentType.idBack: 'idBack',
};
