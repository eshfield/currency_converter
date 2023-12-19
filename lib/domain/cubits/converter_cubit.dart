import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../../data/repositories/api_repository.dart';
import '../models/currency.dart';

class ConverterCubit extends Cubit<ConverterState> {
  final Logger logger;
  final ApiRepository apiRepository;

  ConverterCubit({
    required this.logger,
    required this.apiRepository,
  }) : super(ConverterLoadInitial()) {
    loadCurrencies();
  }

  Future<void> loadCurrencies() async {
    emit(ConverterLoadInProgress());
    try {
      final currencies = await apiRepository.loadCurrencies();
      final rur = currencies.firstWhere((c) => c.codeTo == 'RUR');
      final usd = currencies.firstWhere((c) => c.codeTo == 'USD');
      final eur = currencies.firstWhere((c) => c.codeTo == 'EUR');
      final filteredCurrencies = currencies.where((c) =>
          ![rur.codeFrom, usd.codeFrom, eur.codeFrom].contains(c.codeTo));
      final orderedCurrencies = [usd, eur, ...filteredCurrencies];
      emit(ConverterLoadSuccess(
        currencies: orderedCurrencies,
        selectedFromCurrency: rur,
        selectedToCurrency: usd,
        units: 100,
        fetchedAt: DateTime.now(),
      ));
    } catch (error) {
      logger.w('loadCurrencies error: $error');
      emit(ConverterLoadFailure());
    }
  }

  void setUnits(String value) {
    final units = double.parse(value);
    emit((state as ConverterLoadSuccess).copyWith(units: units));
  }

  void selectCurrency(Currency currency) {
    emit((state as ConverterLoadSuccess).copyWith(
      selectedToCurrency: currency,
    ));
  }
}

sealed class ConverterState extends Equatable {}

final class ConverterLoadInitial extends ConverterState {
  @override
  List<Object?> get props => [];
}

final class ConverterLoadInProgress extends ConverterState {
  @override
  List<Object?> get props => [];
}

final class ConverterLoadSuccess extends ConverterState {
  final List<Currency> currencies;
  final Currency selectedFromCurrency;
  final Currency selectedToCurrency;
  final double units;
  final DateTime fetchedAt;

  ConverterLoadSuccess({
    required this.currencies,
    required this.selectedFromCurrency,
    required this.selectedToCurrency,
    required this.units,
    required this.fetchedAt,
  });

  @override
  List<Object?> get props => [
        currencies,
        selectedToCurrency,
        units,
        fetchedAt,
      ];

  double get result => finalRate * units;

  double get finalRate {
    return selectedToCurrency.units / selectedToCurrency.rate;
  }

  ConverterLoadSuccess copyWith({
    List<Currency>? currencies,
    Currency? selectedToCurrency,
    double? units,
  }) {
    return ConverterLoadSuccess(
      currencies: currencies ?? this.currencies,
      selectedFromCurrency: selectedFromCurrency,
      selectedToCurrency: selectedToCurrency ?? this.selectedToCurrency,
      units: units ?? this.units,
      fetchedAt: fetchedAt,
    );
  }
}

final class ConverterLoadFailure extends ConverterState {
  @override
  List<Object?> get props => [];
}
