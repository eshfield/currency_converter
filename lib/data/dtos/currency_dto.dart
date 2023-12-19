import 'package:json_annotation/json_annotation.dart';

part 'currency_dto.g.dart';

@JsonSerializable()
class CurrencyDto {
  final String name;
  final String codeFrom;
  final String codeTo;

  @JsonKey(name: 'unit')
  final double units;
  
  final double rate;

  @JsonKey(name: 'image')
  final String imagePath;

  CurrencyDto({
    required this.name,
    required this.codeFrom,
    required this.codeTo,
    required this.units,
    required this.rate,
    required this.imagePath,
  });

  factory CurrencyDto.fromJson(Map<String, dynamic> json) =>
      _$CurrencyDtoFromJson(json);
}
