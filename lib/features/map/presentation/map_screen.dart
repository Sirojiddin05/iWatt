import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_watt_app/core/config/storage_keys.dart';
import 'package:i_watt_app/core/services/storage_repository.dart';
import 'package:i_watt_app/core/util/present_sheet.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/location_single_sheet.dart';
import 'package:i_watt_app/features/common/presentation/blocs/car_on_map_bloc/car_on_map_bloc.dart';
import 'package:i_watt_app/features/list/data/repository_impl/charge_locations_repository_impl.dart';
import 'package:i_watt_app/features/list/domain/usecases/get_charge_locations_usecase.dart';
import 'package:i_watt_app/features/list/domain/usecases/save_unsave_stream_usecase.dart';
import 'package:i_watt_app/features/list/presentation/blocs/charge_locations_bloc/charge_locations_bloc.dart';
import 'package:i_watt_app/features/map/presentation/blocs/map_bloc/map_bloc.dart';
import 'package:i_watt_app/features/map/presentation/widgets/map_controllers.dart';
import 'package:i_watt_app/features/map/presentation/widgets/map_header_widgets.dart';
import 'package:i_watt_app/features/map/presentation/widgets/opacity_container.dart';
import 'package:i_watt_app/service_locator.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with WidgetsBindingObserver, TickerProviderStateMixin {
  late final AnimationController headerSizeController;
  late final ChargeLocationsBloc chargeLocationsBloc;
  late final MapBloc mapBloc;

  @override
  void initState() {
    super.initState();
    chargeLocationsBloc = ChargeLocationsBloc(
        getChargeLocationsUseCase: GetChargeLocationsUseCase(serviceLocator<ChargeLocationsRepositoryImpl>()),
        saveStreamUseCase: SaveUnSaveStreamUseCase(serviceLocator<ChargeLocationsRepositoryImpl>()))
      ..add(const GetChargeLocationsEvent());
    mapBloc = MapBloc();
    WidgetsBinding.instance.addObserver(this);
    headerSizeController = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
  }

  @override
  Future<void> didChangeDependencies() async {
    final previousLocale = StorageRepository.getString(StorageKeys.previousLanguage);
    final currentLocale = context.locale.languageCode;
    if (previousLocale != currentLocale) {
      chargeLocationsBloc.add(const GetChargeLocationsEvent());
      await StorageRepository.putString(StorageKeys.previousLanguage, currentLocale);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ChargeLocationsBloc>.value(value: chargeLocationsBloc),
        BlocProvider<MapBloc>.value(value: mapBloc),
      ],
      child: Scaffold(
        body: Stack(
          children: [
            MultiBlocListener(
              listeners: [
                BlocListener<ChargeLocationsBloc, ChargeLocationsState>(
                  listenWhen: (o, n) => o.chargeLocations != n.chargeLocations,
                  listener: (context, state) {
                    mapBloc.add(SetChargeLocations(state.chargeLocations));
                  },
                ),
                BlocListener<CarOnMapBloc, CarOnMapState>(
                  listenWhen: (o, n) => o.carOnMap != n.carOnMap,
                  listener: (context, state) {
                    print('state.carOnMap: ${state.carOnMap}');
                    print('state.carOnMap: ${state.carOnMap.imageOnMap}');
                    mapBloc.add(SetCarOnMapEvent(state.carOnMap));
                  },
                ),
              ],
              child: BlocConsumer<MapBloc, MapState>(
                listenWhen: (o, n) {
                  final areChargeLocationsUpdated = o.chargeLocations != n.chargeLocations;
                  final isLuminosityUpdated = o.hasLuminosity != n.hasLuminosity;
                  // final isMapInitialized = o.isMapInitialized != n.isMapInitialized;
                  return areChargeLocationsUpdated || isLuminosityUpdated;
                },
                buildWhen: (o, n) {
                  final arePlacemarksUpdated = o.locationsMapObjects != n.locationsMapObjects;
                  final isUserLocationUpdated = o.userLocationObject != n.userLocationObject;
                  final isSelectedChargeLocationUpdated = o.selectedLocation != n.selectedLocation;
                  return arePlacemarksUpdated || isUserLocationUpdated || isSelectedChargeLocationUpdated;
                },
                listener: (context, state) {
                  if (state.isMapInitialized) {
                    mapBloc.add(
                      DrawChargeLocationsEvent(
                        withLuminosity: state.hasLuminosity,
                        state.chargeLocations,
                        onLocationTap: (location) {
                          headerSizeController.reverse();
                          Navigator.push(context, CustomMaterialWithModalsPageRoute(builder: (ctx) {
                            return LocationSingleSheet(
                              id: location.id,
                              title: '${location.vendorName} "${location.locationName}"',
                              address: location.address,
                              distance: location.distance.toString(),
                              latitude: location.latitude,
                              longitude: location.longitude,
                            );
                          }));
                          // showModalBottomSheet(
                          //     context: context,
                          //     useRootNavigator: true,
                          //     isScrollControlled: true,
                          //     backgroundColor: AppColors.black.withOpacity(.001),
                          //     barrierColor: AppColors.black.withOpacity(.001),
                          //     builder: (ctx) {
                          //       return LocationSingleSheet(
                          //         id: location.id,
                          //         title: '${location.vendorName} "${location.locationName}"',
                          //         address: location.address,
                          //         distance: location.distance.toString(),
                          //         latitude: location.latitude,
                          //         longitude: location.longitude,
                          //       );
                          //     }).then((value) {
                          //   headerSizeController.forward();
                          //   mapBloc.add(SelectUnSelectMapObject(locationId: location.id));
                          // });
                        },
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return YandexMap(
                    rotateGesturesEnabled: true,
                    mapObjects: _getMapObjects(state),
                    onMapCreated: _onMapCreated,
                    onCameraPositionChanged: _onCameraPositionChanged,
                    onMapTap: _onMapTap,
                  );
                },
              ),
            ),
            const MapOpacityContainer(),
            MapHeaderWidgets(sizeController: headerSizeController),
            MapControllers(headerSizeController: headerSizeController)
          ],
        ),
      ),
    );
  }

  void _onMapCreated(YandexMapController controller) async {
    mapBloc.add(InitializeMapControllerEvent(mapController: controller, context: context));
    await Future.delayed(const Duration(seconds: 1));
    headerSizeController.forward();
  }

  void _onCameraPositionChanged(CameraPosition position, CameraUpdateReason reason, bool isFinished) {
    mapBloc.add(SaveZoomOnCameraPositionChanged(position.zoom));
    if (reason == CameraUpdateReason.gestures) {
      mapBloc.add(const ChangeLuminosityStateEvent(hasLuminosity: false));
    }
  }

  void _onMapTap(Point point) {}

  List<MapObject> _getMapObjects(MapState state) {
    final List<MapObject> mapObjects = [];
    if (state.userLocationObject != null) {
      mapObjects.add(state.userLocationObject!);
    }
    if (state.locationsMapObjects != null) {
      mapObjects.add(state.locationsMapObjects!);
    }
    return mapObjects;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      mapBloc.add(CheckIfSettingsTriggered());
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
