import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/map/presentation/blocs/map_bloc/map_bloc.dart';
import 'package:i_watt_app/features/map/presentation/widgets/location_button.dart';
import 'package:i_watt_app/features/map/presentation/widgets/qr_button.dart';
import 'package:i_watt_app/features/map/presentation/widgets/zoom_buttons.dart';

class MapControllers extends StatelessWidget {
  final AnimationController headerSizeController;
  const MapControllers({super.key, required this.headerSizeController});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      bottom: context.padding.bottom,
      child: SizeTransition(
        axis: Axis.horizontal,
        sizeFactor: headerSizeController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const MapZoomButtons(),
            BlocConsumer<MapBloc, MapState>(
              listenWhen: (o, n) => o.isMapInitialized != n.isMapInitialized,
              listener: (BuildContext context, MapState state) {
                if (state.isMapInitialized) {
                  context.read<MapBloc>().add(const SetMyPositionEvent());
                }
              },
              buildWhen: (o, n) {
                final isLocationAccessStatusChanged = o.locationAccessStatus != n.locationAccessStatus;
                final isUserLocationAccessingStatusChanged = o.userLocationAccessingStatus != n.userLocationAccessingStatus;
                return isLocationAccessStatusChanged || isUserLocationAccessingStatusChanged;
              },
              builder: (context, state) {
                return LocateMeButton(
                  onTap: () => _currentLocationTap(context, state),
                  isLoading: state.userLocationAccessingStatus.isInProgress,
                );
              },
            ),
            QrButton(
              onTap: () {
                // Navigator.of(context, rootNavigator: true).push(CupertinoPageRoute(builder: (ctx) => const QrGenerationScreen())).then(
                //   (result) {
                //     if (result is int) {
                //       if (result != -1 && result != 0) {
                //         showCupertinoModalBottomSheet(
                //           backgroundColor: Colors.transparent,
                //           context: context,
                //           enableDrag: false,
                //           builder: (ctx) {
                //             return ChargeLocationSheet(location: const ChargeLocationEntity().copyWith(id: result));
                //           },
                //         );
                //       } else {
                //         context.showPopUp(status: PopUpStatus.error, context: context, message: LocaleKeys.sorry_qr_code_is_invalid.tr());
                //       }
                //     }
                //   },
                // );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _currentLocationTap(BuildContext context, MapState state) {
    if (state.locationAccessStatus.isLocationServiceDisabled) {
      context.read<MapBloc>().add(const RequestLocationAccess());
    } else {
      context.read<MapBloc>().add(const SetMyPositionEvent());
    }
  }
}
