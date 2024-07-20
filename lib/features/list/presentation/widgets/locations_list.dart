import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_constants.dart';
import 'package:i_watt_app/core/config/app_images.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/location_single_sheet.dart';
import 'package:i_watt_app/features/common/presentation/widgets/empty_state_widget.dart';
import 'package:i_watt_app/features/common/presentation/widgets/error_state_text.dart';
import 'package:i_watt_app/features/common/presentation/widgets/info_container.dart';
import 'package:i_watt_app/features/common/presentation/widgets/paginator.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_button.dart';
import 'package:i_watt_app/features/list/presentation/blocs/charge_locations_bloc/charge_locations_bloc.dart';
import 'package:i_watt_app/features/list/presentation/widgets/charge_location_cards_loader.dart';
import 'package:i_watt_app/features/list/presentation/widgets/charge_location_item.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class LocationsList extends StatelessWidget {
  const LocationsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<ChargeLocationsBloc, ChargeLocationsState>(
          buildWhen: (o, n) {
            final oldPowerTypes = o.selectedPowerTypes;
            final oldConnectorTypes = o.selectedConnectorTypes;
            final newPowerTypes = n.selectedPowerTypes;
            final newConnectorTypes = n.selectedConnectorTypes;
            final oldVendors = o.selectedVendors;
            final newVendors = n.selectedVendors;
            final isPowersChanged = oldPowerTypes != newPowerTypes;
            final isTypesChanged = oldConnectorTypes != newConnectorTypes;
            final isVendorsChanged = oldVendors != newVendors;
            return isPowersChanged || isTypesChanged || isVendorsChanged;
          },
          builder: (context, state) {
            return AnimatedCrossFade(
              firstChild: InfoContainer(
                infoText: LocaleKeys.filter_is_active.tr(),
                color: AppColors.geyser.withOpacity(0.32),
                iconColor: AppColors.taxBreak,
                margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                suffix: WButton(
                  height: 32,
                  rippleColor: AppColors.cyprus.withAlpha(10),
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                  text: LocaleKeys.clear.tr(),
                  textStyle: context.textTheme.bodySmall!.copyWith(fontSize: 12),
                  color: context.colorScheme.primaryContainer,
                  onTap: () {
                    context.read<ChargeLocationsBloc>().add(const SetFilterEvent(
                          powerTypes: [],
                          connectorTypes: [],
                          vendors: [],
                          locationStatuses: [],
                          integrated: false,
                        ));
                  },
                ),
              ),
              secondChild: SizedBox(width: MediaQuery.sizeOf(context).width),
              crossFadeState: state.selectedConnectorTypes.isNotEmpty ||
                      state.selectedPowerTypes.isNotEmpty ||
                      state.selectedVendors.isNotEmpty
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: AppConstants.animationDuration,
            );
          },
        ),
        Expanded(
          child: BlocBuilder<ChargeLocationsBloc, ChargeLocationsState>(
            buildWhen: (o, n) =>
                o.getChargeLocationsStatus != n.getChargeLocationsStatus || o.chargeLocations != n.chargeLocations,
            builder: (context, state) {
              if (state.getChargeLocationsStatus.isInProgress) {
                return const ChargeLocationCardsLoader();
              } else if (state.getChargeLocationsStatus.isSuccess) {
                if (state.chargeLocations.isEmpty) {
                  return Center(
                    child: EmptyStateWidget(
                      title: LocaleKeys.there_are_not_stations.tr(),
                      subtitle: LocaleKeys.there_is_nothing_here_yet.tr(),
                      icon: AppImages.emptyStation,
                    ),
                  );
                }
                final itemNumber = state.chargeLocations.length;
                return RefreshIndicator(
                  backgroundColor: context.colorScheme.primaryContainer,
                  onRefresh: () async {
                    context.read<ChargeLocationsBloc>().add(const GetChargeLocationsEvent());
                  },
                  child: Paginator(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.fromLTRB(16, 16, 16, context.padding.bottom),
                    paginatorStatus: FormzSubmissionStatus.success,
                    itemCount: itemNumber,
                    fetchMoreFunction: () {
                      context.read<ChargeLocationsBloc>().add(const GetMoreChargeLocationsEvent());
                    },
                    hasMoreToFetch: state.fetchMore,
                    itemBuilder: (ctx, index) {
                      final location = state.chargeLocations[index];
                      return ChargeLocationCard(
                        location: location,
                        highlightedTitle: state.searchPattern,
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            useRootNavigator: true,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            barrierColor: AppColors.black.withOpacity(.52),
                            builder: (ctx) {
                              return LocationSingleSheet(
                                title: '${location.vendorName} "${location.locationName}"',
                                address: location.address,
                                distance: location.distance.toString(),
                                midSize: true,
                                id: location.id,
                                latitude: location.latitude,
                                longitude: location.longitude,
                              );
                            },
                          );
                        },
                      );
                    },
                    separatorBuilder: (ctx, index) => const SizedBox(height: 16),
                  ),
                );
              } else if (state.getChargeLocationsStatus.isFailure) {
                return Center(
                  child: Text(
                    LocaleKeys.failure_in_loading.tr(),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }
}
