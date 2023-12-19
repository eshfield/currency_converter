// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrencyDto _$CurrencyDtoFromJson(Map<String, dynamic> json) => CurrencyDto(
      name: json['name'] as String,
      codeFrom: json['codeFrom'] as String,
      codeTo: json['codeTo'] as String,
      units: (json['unit'] as num).toDouble(),
      rate: (json['rate'] as num).toDouble(),
      imagePath: json['image'] as String,
    );

Map<String, dynamic> _$CurrencyDtoToJson(CurrencyDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'codeFrom': instance.codeFrom,
      'codeTo': instance.codeTo,
      'unit': instance.units,
      'rate': instance.rate,
      'image': instance.imagePath,
    };
