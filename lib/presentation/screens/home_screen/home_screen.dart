import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart' as path;

import '../../../router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          final location = path.join(Routes.home.path, Routes.converter.path);
          context.go(location);
        },
        child: const Text('Открыть «Конвертер валют онлайн»'),
      ),
    );
  }
}
