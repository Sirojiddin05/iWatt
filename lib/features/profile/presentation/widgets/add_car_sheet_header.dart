import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_constants.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/sheet_close_button.dart';
import 'package:i_watt_app/features/profile/presentation/blocs/add_car_bloc/add_car_bloc.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/step_representing_divider.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class AddCarSheetHeader extends StatefulWidget {
  const AddCarSheetHeader({super.key});

  @override
  State<AddCarSheetHeader> createState() => _AddCarSheetHeaderState();
}

class _AddCarSheetHeaderState extends State<AddCarSheetHeader> with TickerProviderStateMixin {
  late final AnimationController backButtonController;

  final List<String> titles = [
    LocaleKeys.add_car,
    LocaleKeys.choose_model,
    LocaleKeys.connector_type,
    LocaleKeys.additional_information,
  ];

  @override
  void initState() {
    super.initState();
    backButtonController = AnimationController(vsync: this, duration: AppConstants.animationDuration);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddCarBloc, AddCarState>(
      listenWhen: (o, n) => o.currentStep != n.currentStep,
      buildWhen: (o, n) => o.currentStep != n.currentStep,
      listener: (ctx, state) {
        if (state.currentStep == 0) {
          backButtonController.reverse();
        } else if (state.currentStep == 1) {
          backButtonController.forward();
        }
      },
      builder: (context, state) {
        final step = state.currentStep;
        return Column(
          children: [
            Row(
              children: [
                AnimatedSwitcher(
                  duration: AppConstants.animationDuration,
                  transitionBuilder: (child, animation) {
                    return SizeTransition(
                      axis: Axis.horizontal,
                      sizeFactor: animation,
                      child: child,
                    );
                  },
                  child: step > 0
                      ? GestureDetector(
                          onTap: () {
                            if (step > 0) {
                              context.read<AddCarBloc>().add(SwitchToPreviousStep());
                            }
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 16, 4, 16),
                            child: SvgPicture.asset(
                              AppIcons.chevronLeftBlack,
                            ),
                          ),
                        )
                      : const SizedBox(
                          width: 16,
                        ),
                ),
                GestureDetector(
                  onTap: () {
                    if (step > 0) {
                      context.read<AddCarBloc>().add(SwitchToPreviousStep());
                    }
                  },
                  behavior: HitTestBehavior.opaque,
                  child: AnimatedSwitcher(
                    duration: AppConstants.animationDuration,
                    transitionBuilder: (child, animation) {
                      return SizeTransition(
                        axis: Axis.horizontal,
                        sizeFactor: animation,
                        child: FadeTransition(
                          opacity: animation,
                          child: child,
                        ),
                      );
                    },
                    child: Text(
                      getTitle(state).tr(),
                      key: ValueKey(titles[state.currentStep]),
                      style: context.textTheme.displayMedium,
                    ),
                  ),
                ),
                const Spacer(),
                SheetCloseButton(
                  onTap: () => Navigator.pop(context),
                  padding: const EdgeInsets.all(16),
                )
              ],
            ),
            StepRepresentingDivider(
              step: state.currentStep,
            ),
          ],
        );
      },
    );
  }

  String getTitle(AddCarState state) {
    if (state.currentStep == 1 && state.car.model == 0) {
      return "${LocaleKeys.other_feminine.tr()} ${LocaleKeys.brand_small.tr()}";
    }
    return titles[state.currentStep];
  }
}
