import '../../domain/models/currency.dart';
import '../dtos/currency_dto.dart';

extension CurrencyDtoToDomain on CurrencyDto {
  Currency toDomain() {
    return Currency(
      name: name,
      codeFrom: codeFrom,
      codeTo: codeTo,
      units: units,
      rate: rate,
      imagePath: imagePath,
    );
  }
}
