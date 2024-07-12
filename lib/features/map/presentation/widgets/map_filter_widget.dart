import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/domain/entities/id_name_entity.dart';
import 'package:i_watt_app/features/common/presentation/widgets/filter_Icon_card.dart';
import 'package:i_watt_app/features/common/presentation/widgets/filter_sheet.dart';
import 'package:i_watt_app/features/map/presentation/blocs/map_locations_bloc/map_locations_bloc.dart';

class MapFilterWidget extends StatelessWidget {
  const MapFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapLocationsBloc, MapLocationsState>(
      buildWhen: (o, n) {
        final isConnectorTypesChanged = o.selectedConnectorTypes != n.selectedConnectorTypes;
        final isPowerTypesChanged = o.selectedPowerTypes != n.selectedPowerTypes;
        final isVendorsChanged = o.selectedVendors != n.selectedVendors;
        final isStatusesChanged = o.selectedStatuses != n.selectedStatuses;
        final isIntegratedChanged = o.integrated != n.integrated;
        return isConnectorTypesChanged || isPowerTypesChanged || isVendorsChanged || isStatusesChanged || isIntegratedChanged;
      },
      builder: (context, state) {
        final isActive = state.selectedPowerTypes.isNotEmpty ||
            state.selectedConnectorTypes.isNotEmpty ||
            state.selectedVendors.isNotEmpty ||
            state.selectedStatuses.isNotEmpty ||
            state.integrated;
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
                  onChanged: (
                    List<int> powerTypes,
                    List<int> connectorType,
                    List<IdNameEntity> vendors,
                    List<String> locationStatuses,
                    bool integrated,
                  ) {
                    context.read<MapLocationsBloc>().add(
                          SetFilterForMapLocationsEvent(
                            powerTypes: powerTypes,
                            connectorTypes: connectorType,
                            vendors: vendors,
                            locationStatuses: locationStatuses,
                            integrated: integrated,
                          ),
                        );
                    Navigator.pop(ctx);
                  },
                  selectedPowerTypes: state.selectedPowerTypes,
                  selectedConnectorTypes: state.selectedConnectorTypes,
                  selectedVendors: state.selectedVendors,
                  locationStatuses: state.selectedStatuses,
                  integrated: state.integrated,
                );
              },
            );
          },
        );
      },
    );
  }
}
