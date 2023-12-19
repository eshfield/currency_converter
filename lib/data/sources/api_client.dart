import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../dtos/currency_dto.dart';

part 'api_client.g.dart';

class Api {
  static const baseUrl = 'https://xn----8sbf4aihhoz6fi8a.xn--p1ai/';
  static const currencies = 'er/er.php';
}

@RestApi(baseUrl: Api.baseUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio) = _ApiClient;

  @GET(Api.currencies)
  Future<List<CurrencyDto>> getCurrencies();
}
