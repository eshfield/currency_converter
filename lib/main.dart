import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';

import 'data/repositories/api_repository.dart';
import 'domain/cubits/converter_cubit.dart';
import 'router.dart';
import 'theme.dart';

void main() => runApp(const MainApp());

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late final Logger logger;
  late final ApiRepository apiRepository;

  @override
  void initState() {
    super.initState();
    precacheSvgImages();
    logger = Logger();
    apiRepository = ApiRepository();
  }

  Future<void> precacheSvgImages() async {
    final assetManifest = await AssetManifest.loadFromAssetBundle(rootBundle);
    final assets = assetManifest.listAssets();
    final svgPaths = assets.where((path) => path.endsWith('.svg'));
    for (final svgPath in svgPaths) {
      final loader = SvgAssetLoader(svgPath);
      await svg.cache
          .putIfAbsent(loader.cacheKey(null), () => loader.loadBytes(null));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      child: BlocProvider(
        create: (context) {
          return ConverterCubit(
            apiRepository: apiRepository,
            logger: logger,
          );
        },
        child: MaterialApp.router(
          locale: const Locale('ru'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          routerConfig: routerConfig,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: theme,
        ),
      ),
    );
  }
}
