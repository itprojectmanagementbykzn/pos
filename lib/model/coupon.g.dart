// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Coupon _$$_CouponFromJson(Map<String, dynamic> json) => _$_Coupon(
      documentID: json['documentID'] as String?,
      code: json['code'] as String,
      discountContent: json['discountContent'] as String,
      startDate: (json['startDate'] as Timestamp).toDate(),
      expireDate: (json['expireDate'] as Timestamp).toDate(),
      percentage: json['percentage'] as int,
    );

Map<String, dynamic> _$$_CouponToJson(_$_Coupon instance) => <String, dynamic>{
      'documentID': instance.documentID,
      'code': instance.code,
      'discountContent': instance.discountContent,
      'startDate': instance.startDate,
      'expireDate': instance.expireDate,
      'percentage': instance.percentage,
    };
