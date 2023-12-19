import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../domain/models/currency.dart';
import '../mappers/currency_mapper.dart';
import '../sources/api_client.dart';

class ApiRepository {
  late final ApiClient apiClient;

  ApiRepository() {
    final dio = Dio();
    dio.options = BaseOptions(connectTimeout: const Duration(seconds: 30));
    dio.interceptors.add(PrettyDioLogger());
    apiClient = ApiClient(dio);
  }

  Future<List<Currency>> loadCurrencies() async {
    final currencyDtos = await apiClient.getCurrencies();
    return currencyDtos.map((dto) => dto.toDomain()).toList();
  }
}
