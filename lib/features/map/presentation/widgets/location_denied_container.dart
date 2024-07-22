import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_watt_app/core/config/app_images.dart';
import 'package:i_watt_app/core/util/enums/location_permission_status.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/map/presentation/blocs/map_bloc/map_bloc.dart';
import 'package:i_watt_app/features/map/presentation/widgets/animated_size_scale_map_widget.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class LocationDeniedContainer extends StatefulWidget {
  const LocationDeniedContainer({super.key});

  @override
  State<LocationDeniedContainer> createState() => _LocationDeniedContainerState();
}

class _LocationDeniedContainerState extends State<LocationDeniedContainer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<MapBloc, MapState, LocationPermissionStatus>(
      selector: (state) => state.locationAccessStatus,
      builder: (context, state) {
        return AnimatedScaleSizeWidget(
          buttonText: LocaleKeys.turn_on.tr(),
          onButtonTap: () => context.read<MapBloc>().add(const RequestLocationAccess()),
          iconPath: AppImages.compass,
          body: Text(
            LocaleKeys.location_access_disabled.tr(),
            style: context.textTheme.titleMedium!.copyWith(fontSize: 13),
            maxLines: 2,
          ),
          isVisible: !state.isPermissionGranted,
          width: context.sizeOf.width - 92,
        );
      },
    );
  }
}
