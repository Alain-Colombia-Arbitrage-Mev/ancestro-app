// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agreement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AgreementImpl _$$AgreementImplFromJson(Map<String, dynamic> json) =>
    _$AgreementImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      accepted: json['accepted'] as bool? ?? false,
    );

Map<String, dynamic> _$$AgreementImplToJson(_$AgreementImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'accepted': instance.accepted,
    };
