import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/blocs/filter_bloc/filter_bloc.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_scale_animation.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class FilterClearButton extends StatelessWidget {
  const FilterClearButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterBloc, FilterState>(
      buildWhen: (previous, current) {
        final isConnectorTypesChanged = previous.connectorTypes != current.connectorTypes;
        final isPowerTypesChanged = previous.powerTypes != current.powerTypes;
        final isVendorsChanged = previous.vendors != current.vendors;
        return isConnectorTypesChanged || isPowerTypesChanged || isVendorsChanged;
      },
      builder: (context, state) {
        final connectorTypes = state.connectorTypes;
        final powers = state.powerTypes;
        final vendors = state.vendors;
        final isActive = powers.isNotEmpty || connectorTypes.isNotEmpty || vendors.isNotEmpty;
        return IgnorePointer(
          ignoring: !isActive,
          child: WScaleAnimation(
            onTap: () {
              context.read<FilterBloc>().add(const ClearFilterEvent());
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 19),
              child: Text(
                LocaleKeys.clear.tr(),
                style: context.textTheme.headlineSmall!.copyWith(color: !isActive ? AppColors.gullGrey : AppColors.dodgerBlue),
              ),
            ),
          ),
        );
      },
    );
  }
}
