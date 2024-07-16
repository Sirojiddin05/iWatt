import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/util/enums/pop_up_status.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/charge_location_single/domain/entities/vendor_entity.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/location_single_sheet.dart';
import 'package:i_watt_app/features/map/presentation/blocs/map_bloc/map_bloc.dart';
import 'package:i_watt_app/features/map/presentation/pages/qr_screen.dart';
import 'package:i_watt_app/features/map/presentation/widgets/location_button.dart';
import 'package:i_watt_app/features/map/presentation/widgets/qr_button.dart';
import 'package:i_watt_app/features/map/presentation/widgets/zoom_buttons.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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
                final isUserLocationAccessingStatusChanged =
                    o.userLocationAccessingStatus != n.userLocationAccessingStatus;
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
                Navigator.of(context, rootNavigator: true)
                    .push(CupertinoPageRoute(builder: (ctx) => const ScanStation()))
                    .then(
                  (result) {
                    if (result is Map) {
                      final isValidLocation = result.containsKey('location_id') && result['location_id'] != 0;
                      final isValidStation = result.containsKey('station_id') && result['station_id'] != 0;
                      final isValidConnector = result.containsKey('connector_id') && result['connector_id'] != 0;
                      if (isValidConnector && isValidLocation && isValidStation) {
                        showCupertinoModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          barrierColor: AppColors.black.withOpacity(0.52),
                          context: context,
                          enableDrag: false,
                          builder: (ctx) {
                            return LocationSingleSheet(
                              id: result['location_id'],
                              stationId: result['station_id'],
                              connectorId: result['connector_id'],
                              title: '',
                              address: '',
                              latitude: '',
                              longitude: '',
                              midSize: true,
                            );
                          },
                        );
                      } else {
                        context.showPopUp(
                          context,
                          PopUpStatus.failure,
                          message: LocaleKeys.sorry_qr_code_is_invalid.tr(),
                        );
                      }
                    }
                  },
                );
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
