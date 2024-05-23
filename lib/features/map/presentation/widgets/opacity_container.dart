import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/features/map/presentation/blocs/map_bloc/map_bloc.dart';

class MapOpacityContainer extends StatelessWidget {
  const MapOpacityContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      left: 0,
      child: BlocConsumer<MapBloc, MapState>(
        listenWhen: (o, n) {
          final isLocationAccessStatusChanged = o.locationAccessStatus != n.locationAccessStatus;
          return isLocationAccessStatusChanged;
        },
        listener: (context, state) {
          final locationAccessStatus = state.locationAccessStatus;
          final includeLuminosity = locationAccessStatus.isLocationServiceDisabled || locationAccessStatus.isPermissionDenied;
          context.read<MapBloc>().add(ChangeLuminosityStateEvent(hasLuminosity: includeLuminosity));
        },
        builder: (context, state) {
          return AnimatedContainer(
            height: 188,
            decoration: BoxDecoration(
              gradient: state.hasLuminosity
                  ? const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [AppColors.black, Colors.transparent],
                    )
                  : null,
            ),
            duration: const Duration(milliseconds: 400),
          );
        },
      ),
    );
  }
}
