import 'package:cached_network_image/cached_network_image.dart';
import 'package:currency_converter/domain/models/currency.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../../domain/cubits/converter_cubit.dart';
import '../../../styles.dart';
import 'bottom_sheet.dart';

enum SectionType {
  from,
  to,
}

class ExchangerCurrencySection extends StatefulWidget {
  final Color color;
  final String label;
  final SectionType sectionType;

  const ExchangerCurrencySection({
    super.key,
    required this.color,
    required this.label,
    required this.sectionType,
  });

  @override
  State<ExchangerCurrencySection> createState() =>
      _ExchangerCurrencySectionState();
}

class _ExchangerCurrencySectionState extends State<ExchangerCurrencySection> {
  final controller = TextEditingController(text: '100');
  late Currency currency;
  late Widget rateInfo;
  late void Function(String) inputUnitsOnChanged;
  late VoidCallback? inputCurrencyOnTap;
  late Widget inputCurrencyArrow;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConverterCubit, ConverterState>(
      builder: (context, converterState) {
        final state = converterState as ConverterLoadSuccess;
        final locale = Localizations.localeOf(context);
        final formatter = NumberFormat.decimalPattern(locale.languageCode)
          ..maximumFractionDigits = 4;
        if (widget.sectionType == SectionType.from) {
          currency = state.selectedFromCurrency;
          rateInfo = Text(
            '${currency.units.round()} ${currency.codeTo} = ${formatter.format(state.finalRate)} ${state.selectedToCurrency.codeTo}',
            style: Styles.currencySectionRate,
          );
          inputUnitsOnChanged = (value) {
            if (value.isEmpty) return;
            context.read<ConverterCubit>().setUnits(value);
          };
          inputCurrencyOnTap = null;
          inputCurrencyArrow = SizedBox(
            width: 16.w,
            height: 16.h,
          );
        } else {
          currency = state.selectedToCurrency;
          rateInfo = Text(
            '${currency.units.round()} ${currency.codeTo} = ${formatter.format(currency.rate)} ${currency.codeFrom}',
            style: Styles.currencySectionRate,
          );
          inputUnitsOnChanged = (_) {};
          inputCurrencyOnTap = () => showCurrencyBottomSheet(context);
          inputCurrencyArrow = SvgPicture.asset(
            'assets/images/arrow_down.svg',
            width: 16.w,
            height: 16.h,
          );
          controller.text = formatter.format(state.result);
        }

        return Container(
          height: 139.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.r)),
            color: widget.color,
          ),
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.label, style: Styles.currencySectionLabel),
              SizedBox(height: 10.h),
              inputFields(),
              SizedBox(height: 12.h),
              rateInfo,
            ],
          ),
        );
      },
    );
  }

  Widget inputFields() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
              constraints: BoxConstraints.tight(Size.fromHeight(50.h)),
              contentPadding: EdgeInsets.fromLTRB(16.r, 14.r, 16.r, 10.r),
              filled: true,
              fillColor: Colors.white,
            ),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d{0,2})')),
            ],
            keyboardType: TextInputType.number,
            onChanged: inputUnitsOnChanged,
            style: Styles.currencySectionInput,
          ),
        ),
        SizedBox(width: 8.w),
        Material(
          borderRadius: BorderRadius.circular(12.r),
          color: Colors.white,
          child: InkWell(
            borderRadius: BorderRadius.circular(12.r),
            onTap: inputCurrencyOnTap,
            child: Container(
              padding: EdgeInsets.all(10.r),
              width: 112.w,
              height: 50.h,
              child: Row(
                children: [
                  CachedNetworkImage(
                    imageUrl: currency.imagePath,
                    width: 26.w,
                    height: 26.h,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    currency.codeTo,
                    style: Styles.currencySectionName,
                  ),
                  const Spacer(),
                  inputCurrencyArrow,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
