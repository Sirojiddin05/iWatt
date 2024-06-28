import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_constants.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/blocs/filter_bloc/filter_bloc.dart';
import 'package:i_watt_app/features/common/presentation/widgets/filter_clear_button.dart';
import 'package:i_watt_app/features/common/presentation/widgets/sheet_header_container.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class FilterHeader extends StatefulWidget {
  final bool hasShadow;

  const FilterHeader({super.key, required this.hasShadow});

  @override
  State<FilterHeader> createState() => _FilterHeaderState();
}

class _FilterHeaderState extends State<FilterHeader> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: AppConstants.animationDuration,
      decoration: BoxDecoration(
        color: context.colorScheme.primaryContainer,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(16),
          topLeft: Radius.circular(16),
        ),
        boxShadow: widget.hasShadow
            ? [
                BoxShadow(
                  color: AppColors.baliHai.withOpacity(0.14),
                  blurRadius: 32,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SheetHeadContainer(),
          Stack(
            alignment: Alignment.center,
            children: [
              Row(
                children: [
                  BlocBuilder<FilterBloc, FilterState>(
                    builder: (context, state) {
                      return AnimatedSwitcher(
                        duration: AppConstants.animationDuration,
                        transitionBuilder: (child, animation) {
                          return SizeTransition(
                            axis: Axis.horizontal,
                            axisAlignment: -1,
                            sizeFactor: animation,
                            child: FadeTransition(
                              opacity: animation,
                              child: child,
                            ),
                          );
                        },
                        child: state.page == 0
                            ? const Align(
                                alignment: Alignment.centerLeft,
                                child: FilterClearButton(),
                              )
                            : GestureDetector(
                                onTap: () {
                                  context.read<FilterBloc>().add(const SetPageEvent(page: 0));
                                  WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                                },
                                behavior: HitTestBehavior.opaque,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(16, 12, 8, 18),
                                  child: SvgPicture.asset(AppIcons.backButton),
                                ),
                              ),
                      );
                    },
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                        Navigator.pop(context);
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                        child: SvgPicture.asset(AppIcons.closeBoldGrey),
                      ),
                    ),
                  )
                ],
              ),
              BlocBuilder<FilterBloc, FilterState>(
                buildWhen: (previous, current) => previous.page != current.page,
                builder: (context, state) {
                  final page = state.page;
                  return AnimatedAlign(
                    alignment: page == 1 ? Alignment.centerLeft : Alignment.center,
                    duration: AppConstants.animationDuration,
                    child: GestureDetector(
                      onTap: () {
                        context.read<FilterBloc>().add(const SetPageEvent(page: 0));
                        WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 6, left: page == 1 ? 48 : 0),
                        child: Text(
                          page == 0 ? LocaleKeys.filter.tr() : LocaleKeys.select_company.tr(),
                          style: context.textTheme.displayMedium,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          BlocBuilder<FilterBloc, FilterState>(
            buildWhen: (previous, current) => previous.page != current.page,
            builder: (context, state) {
              final page = state.page;
              return AnimatedSwitcher(
                duration: AppConstants.animationDuration,
                child: page == 0
                    ? const Divider(
                        height: 0,
                        thickness: 1,
                        color: AppColors.fieldBorderZircon,
                      )
                    : const SizedBox.shrink(),
              );
            },
          ),
        ],
      ),
    );
  }
}
