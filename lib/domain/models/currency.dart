class Currency {
  final String name;
  final String codeFrom;
  final String codeTo;
  final double units;
  final double rate;
  final String imagePath;

  Currency({
    required this.name,
    required this.codeFrom,
    required this.codeTo,
    required this.units,
    required this.rate,
    required this.imagePath,
  });
}
