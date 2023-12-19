import 'package:flutter/material.dart';

class RoutePlaceholder extends StatelessWidget {
  final String label;

  const RoutePlaceholder({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(label));
  }
}
