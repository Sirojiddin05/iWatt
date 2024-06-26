import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_constants.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/domain/entities/id_name_entity.dart';
import 'package:i_watt_app/features/common/presentation/blocs/filter_bloc/filter_bloc.dart';
import 'package:i_watt_app/features/common/presentation/widgets/option_container.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class SelectedVendorContainer extends StatelessWidget {
  const SelectedVendorContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16).copyWith(bottom: 0),
      child: BlocBuilder<FilterBloc, FilterState>(
        buildWhen: (previous, current) => previous.vendors != current.vendors,
        builder: (context, state) {
          final vendors = getVendors(state.vendors);
          return OptionContainer(
            content: Align(
              alignment: Alignment.centerLeft,
              child: AnimatedSwitcher(
                duration: AppConstants.animationDuration,
                transitionBuilder: (child, animation) => SizeTransition(
                  axisAlignment: 1,
                  sizeFactor: animation,
                  child: child,
                ),
                child: Text(
                  vendors,
                  key: ValueKey(vendors),
                  maxLines: 2,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.headlineSmall?.copyWith(fontSize: 15),
                ),
              ),
            ),
            title: LocaleKeys.companies.tr(),
            titleStyle: context.textTheme.displaySmall,
            icon: AppIcons.chevronRightGrey,
            boxDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.solitude,
            ),
            onTap: () {
              context.read<FilterBloc>().add(const SetTemporaryVendors());
              context.read<FilterBloc>().add(const SetPageEvent(page: 1));
            },
          );
        },
      ),
    );
  }

  String getVendors(List<IdNameEntity> vendors) {
    if (vendors.isEmpty) {
      return LocaleKeys.select_company.tr();
    }
    final vendorIds = List<int>.generate(vendors.length, (index) => vendors[index].id);
    if (vendorIds.contains(0)) {
      return LocaleKeys.all_companies.tr();
    }
    return vendors.map((e) => e.name).join(', ');
  }
}
