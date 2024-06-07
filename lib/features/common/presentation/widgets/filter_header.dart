import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_constants.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/filter_clear_button.dart';
import 'package:i_watt_app/features/common/presentation/widgets/sheet_header_container.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class FilterHeader extends StatefulWidget {
  final ValueNotifier<List<int>> connectorTypes;
  final ValueNotifier<List<int>> powerTypes;
  final VoidCallback onClearTap;
  final bool hasShadow;
  const FilterHeader({super.key, required this.connectorTypes, required this.powerTypes, required this.onClearTap, required this.hasShadow});

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
          Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: ValueListenableBuilder<List<int>>(
                      builder: (context, connectors, child) {
                        return ValueListenableBuilder<List<int>>(
                          builder: (context, powers, child) {
                            return FilterClearButton(
                              isActive: powers.isNotEmpty || connectors.isNotEmpty,
                              onTap: widget.onClearTap,
                            );
                          },
                          valueListenable: widget.powerTypes,
                        );
                      },
                      valueListenable: widget.connectorTypes),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  LocaleKeys.filter.tr(),
                  style: context.textTheme.displayMedium,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    behavior: HitTestBehavior.opaque,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                      child: SvgPicture.asset(AppIcons.closeBoldGrey),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
