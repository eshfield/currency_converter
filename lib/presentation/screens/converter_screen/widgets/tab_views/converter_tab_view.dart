import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../domain/cubits/converter_cubit.dart';
import '../../../../../utils/timestamps.dart';
import '../../../../common/repeat_button.dart';
import '../../../../styles.dart';
import '../exchanger.dart';
import '../message_box.dart';

class ConverterTabView extends StatelessWidget {
  const ConverterTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConverterCubit, ConverterState>(
      builder: (context, state) {
        if (state is ConverterLoadInProgress) {
          return const Center(child: CircularProgressIndicator());
        }
        return LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: switch (state) {
                    ConverterLoadSuccess() => SuccessView(state),
                    ConverterLoadFailure() => const FailureView(),
                    _ => null,
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class SuccessView extends StatelessWidget {
  final ConverterLoadSuccess state;

  const SuccessView(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      children: [
        Text(l10n.title, style: Styles.title),
        SizedBox(height: 14.h),
        MessageBox(
          level: Level.warning,
          text: l10n.warningMessage,
        ),
        SizedBox(height: 20.h),
        const Exchanger(),
        const Spacer(),
        Align(
          alignment: Alignment.center,
          child: Text(
            '${l10n.fetchedAt} ${formatter.format(state.fetchedAt)} ${gmtStamp(state.fetchedAt)}',
            style: Styles.footer,
          ),
        ),
      ],
    );
  }
}

class FailureView extends StatelessWidget {
  const FailureView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      children: [
        Text(l10n.title, style: Styles.title),
        SizedBox(height: 14.h),
        MessageBox(
          level: Level.error,
          text: l10n.errorMessage,
        ),
        SizedBox(height: 26.h),
        RepeatButton(
          label: l10n.repeatButtonLabel,
          onTap: () {
            context.read<ConverterCubit>().loadCurrencies();
          },
        ),
      ],
    );
  }
}
