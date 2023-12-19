import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../styles.dart';
import 'exchanger_currency_section.dart';

class Exchanger extends StatelessWidget {
  const Exchanger({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ExchangerCurrencySection(
              color: Styles.currencySectionFromColor,
              label: l10n.currencyFromLabel,
              sectionType: SectionType.from,
            ),
            SizedBox(height: 14.h),
            ExchangerCurrencySection(
              color: Styles.currencySectionToColor,
              label: l10n.currencyToLabel,
              sectionType: SectionType.to,
            ),
          ],
        ),
        SvgPicture.asset(
          'assets/images/exchange.svg',
          width: 50.w,
          height: 50.h,
        ),
      ],
    );
  }
}
