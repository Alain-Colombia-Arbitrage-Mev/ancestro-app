// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'referral.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReferralImpl _$$ReferralImplFromJson(Map<String, dynamic> json) =>
    _$ReferralImpl(
      code: json['code'] as String,
      referrerId: json['referrerId'] as String,
      referredEmail: json['referredEmail'] as String?,
      status: $enumDecode(_$ReferralStatusEnumMap, json['status']),
      reward: (json['reward'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$ReferralImplToJson(_$ReferralImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'referrerId': instance.referrerId,
      'referredEmail': instance.referredEmail,
      'status': _$ReferralStatusEnumMap[instance.status]!,
      'reward': instance.reward,
    };

const _$ReferralStatusEnumMap = {
  ReferralStatus.pending: 'pending',
  ReferralStatus.registered: 'registered',
  ReferralStatus.completed: 'completed',
};
