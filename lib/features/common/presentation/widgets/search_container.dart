import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/pages/search_page.dart';
import 'package:i_watt_app/features/common/presentation/widgets/filter_Icon_card.dart';
import 'package:i_watt_app/features/common/presentation/widgets/filter_sheet.dart';
import 'package:i_watt_app/features/common/presentation/widgets/search_filter_wrapper.dart';
import 'package:i_watt_app/features/list/presentation/blocs/charge_locations_bloc/charge_locations_bloc.dart';
import 'package:i_watt_app/features/navigation/presentation/widgets/home_tab_controller_provider.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class SearchFilterContainer extends StatefulWidget {
  final EdgeInsets? padding;
  final bool isForMap;

  const SearchFilterContainer({super.key, this.padding, this.isForMap = false});

  @override
  State<SearchFilterContainer> createState() => _SearchFilterContainerState();
}

class _SearchFilterContainerState extends State<SearchFilterContainer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? EdgeInsets.fromLTRB(16, context.padding.top + 16, 16, 4),
      child: SearchFilterWrapper(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.of(
                  context,
                  rootNavigator: true,
                ).push(
                  MaterialWithModalsPageRoute(
                    builder: (ctx) => HomeTabControllerProvider(
                      controller: HomeTabControllerProvider.of(context).controller,
                      child: SearchPage(isForMap: widget.isForMap),
                    ),
                  ),
                );
              },
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    SvgPicture.asset(AppIcons.plugAlt),
                    const SizedBox(width: 10),
                    Text(
                      LocaleKeys.search_stations.tr(),
                      style: context.textTheme.headlineSmall!.copyWith(color: AppColors.blueBayoux),
                    ),
                    const Spacer(),
                    SvgPicture.asset(AppIcons.search),
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: [
              Container(decoration: const BoxDecoration(color: AppColors.whiteSmoke), width: 0.5, height: 24),
              BlocBuilder<ChargeLocationsBloc, ChargeLocationsState>(
                buildWhen: (o, n) {
                  return o.selectedConnectorTypes != n.selectedConnectorTypes || o.selectedPowerTypes != n.selectedPowerTypes;
                },
                builder: (context, state) {
                  final isActive = (state.selectedPowerTypes.isNotEmpty || state.selectedConnectorTypes.isNotEmpty);
                  return FilterIconCard(
                    isActive: isActive,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        useRootNavigator: true,
                        isScrollControlled: true,
                        constraints: BoxConstraints(maxHeight: context.sizeOf.height - kToolbarHeight),
                        builder: (ctx) {
                          return FilterSheet(
                            onChanged: (List<int> powerTypes, List<int> connectorType) {
                              context.read<ChargeLocationsBloc>().add(SetFilterEvent(powerTypes: powerTypes, connectorTypes: connectorType));
                              Navigator.pop(ctx);
                            },
                            selectedPowerTypes: state.selectedPowerTypes,
                            selectedConnectorTypes: state.selectedConnectorTypes,
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
