import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:currency_converter/domain/models/currency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../domain/cubits/converter_cubit.dart';
import '../../../common/apply_button.dart';
import '../../../styles.dart';

var selectedIndex = 0;

void showCurrencyBottomSheet(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    barrierColor: Styles.bottomSheetBarrierColor,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return BlocBuilder<ConverterCubit, ConverterState>(
            builder: (context, converterState) {
              final l10n = AppLocalizations.of(context);
              final state = converterState as ConverterLoadSuccess;
              return BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 6,
                  sigmaY: 6,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16.r),
                    ),
                    color: Colors.white,
                  ),
                  width: double.infinity,
                  height: 694.h,
                  padding: EdgeInsets.all(20.r),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            l10n.bottomSheetTitle,
                            style: Styles.bottomSheetTitle,
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: SvgPicture.asset(
                              'assets/images/cross.svg',
                              width: 20.w,
                              height: 20.h,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            final currency = state.currencies[index];
                            return CurrencyListItem(
                              currency: currency,
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                });
                              },
                              isSelected: selectedIndex == index,
                            );
                          },
                          separatorBuilder: (_, __) => SizedBox(height: 14.h),
                          itemCount: state.currencies.length,
                        ),
                      ),
                      SizedBox(height: 14.h),
                      ApplyButton(
                        label: l10n.applyButtonLabel,
                        onTap: () {
                          final currency = state.currencies[selectedIndex];
                          context
                              .read<ConverterCubit>()
                              .selectCurrency(currency);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      );
    },
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(16.r),
      ),
    ),
    useRootNavigator: true,
  );
}

class CurrencyListItem extends StatelessWidget {
  final Currency currency;
  final VoidCallback onTap;
  final bool isSelected;

  const CurrencyListItem({
    super.key,
    required this.currency,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10.r),
      color: isSelected ? Colors.white : Styles.currencyRadioItemColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(10.r),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            border: isSelected ? Border.all(color: Styles.accentColor) : null,
            borderRadius: BorderRadius.circular(10.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 13.h),
          height: 56.h,
          child: Row(
            children: [
              CachedNetworkImage(
                imageUrl: currency.imagePath,
                width: 30.w,
                height: 30.h,
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: RichText(
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    text: currency.codeTo,
                    style: Styles.currencyRadioName,
                    children: [
                      TextSpan(
                        text: ' / ${currency.name}',
                        style: Styles.currencyRadioName.copyWith(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              isSelected
                  ? Container(
                      alignment: Alignment.center,
                      width: 26.w,
                      height: 26.h,
                      decoration: const BoxDecoration(
                        color: Styles.accentColor,
                        shape: BoxShape.circle,
                      ),
                      child: Container(
                        width: 12.w,
                        height: 12.h,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : Container(
                      width: 26.w,
                      height: 26.h,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black.withOpacity(0.2),
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
