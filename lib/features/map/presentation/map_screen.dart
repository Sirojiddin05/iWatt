import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/map_style.dart';
import 'package:i_watt_app/core/config/storage_keys.dart';
import 'package:i_watt_app/core/services/storage_repository.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/blocs/car_on_map_bloc/car_on_map_bloc.dart';
import 'package:i_watt_app/features/common/presentation/blocs/theme_switcher_bloc/theme_switcher_bloc.dart';
import 'package:i_watt_app/features/list/data/repository_impl/charge_locations_repository_impl.dart';
import 'package:i_watt_app/features/list/domain/usecases/get_charge_locations_usecase.dart';
import 'package:i_watt_app/features/list/domain/usecases/save_unsave_stream_usecase.dart';
import 'package:i_watt_app/features/list/presentation/blocs/charge_locations_bloc/charge_locations_bloc.dart';
import 'package:i_watt_app/features/map/presentation/blocs/map_bloc/map_bloc.dart';
import 'package:i_watt_app/features/map/presentation/blocs/map_locations_bloc/map_locations_bloc.dart';
import 'package:i_watt_app/features/map/presentation/widgets/map_controllers.dart';
import 'package:i_watt_app/features/map/presentation/widgets/map_header_widgets.dart';
import 'package:i_watt_app/features/map/presentation/widgets/opacity_container.dart';
import 'package:i_watt_app/service_locator.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with WidgetsBindingObserver, TickerProviderStateMixin {
  late final AnimationController headerSizeController;
  late final ChargeLocationsBloc chargeLocationsBloc;
  late final MapBloc mapBloc;
  late final MapLocationsBloc mapLocationsBloc;
  late final GoogleMapController mapController;
  CameraPosition? cameraPosition;

  @override
  void initState() {
    super.initState();
    chargeLocationsBloc = ChargeLocationsBloc(
      getChargeLocationsUseCase: GetChargeLocationsUseCase(serviceLocator<ChargeLocationsRepositoryImpl>()),
      saveStreamUseCase: SaveUnSaveStreamUseCase(serviceLocator<ChargeLocationsRepositoryImpl>()),
    );
    mapBloc = MapBloc();
    mapLocationsBloc = BlocProvider.of<MapLocationsBloc>(context);
    WidgetsBinding.instance.addObserver(this);
    headerSizeController = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ChargeLocationsBloc>.value(value: chargeLocationsBloc),
        BlocProvider<MapBloc>.value(value: mapBloc),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            MultiBlocListener(
              listeners: [
                BlocListener<MapLocationsBloc, MapLocationsState>(
                  listenWhen: (o, n) => o.chargeLocations != n.chargeLocations,
                  listener: (ctx, state) {
                    mapBloc.add(SetPresentPlaceMarks(state.chargeLocations));
                  },
                ),
                BlocListener<CarOnMapBloc, CarOnMapState>(
                  listenWhen: (o, n) => o.carOnMap != n.carOnMap,
                  listener: (context, state) {
                    mapBloc.add(SetCarOnMapEvent(carOnMap: state.carOnMap));
                  },
                ),
              ],
              child: BlocConsumer<MapBloc, MapState>(
                listenWhen: (o, n) => o.locationSingleOpened != n.locationSingleOpened,
                listener: (context, state) {
                  if (state.locationSingleOpened) {
                    headerSizeController.reverse();
                  } else {
                    headerSizeController.forward();
                  }
                },
                buildWhen: (o, n) {
                  final areChargeLocationsUpdated = o.presentedMapObjects != n.presentedMapObjects;
                  final luminosityUpdated = o.hasLuminosity != n.hasLuminosity;
                  final userLocationUpdated = o.userLocationObject != n.userLocationObject;
                  return areChargeLocationsUpdated || userLocationUpdated || luminosityUpdated;
                },
                builder: (context, mapState) {
                  return BlocBuilder<ThemeSwitcherBloc, ThemeSwitcherState>(
                    builder: (BuildContext context, ThemeSwitcherState themeState) {
                      return GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                            StorageRepository.getDouble(StorageKeys.latitude, defValue: 0),
                            StorageRepository.getDouble(StorageKeys.longitude, defValue: 0),
                          ),
                          zoom: 16,
                        ),
                        onMapCreated: _onMapCreated,
                        markers: _getMapObjects(mapState),
                        onCameraMove: _onCameraMoved,
                        onCameraIdle: _onCameraIdle,
                        style: getMapStyle(themeState, mapState),
                        compassEnabled: false,
                      );
                    },
                  );
                },
              ),
            ),
            const MapOpacityContainer(),
            MapHeaderWidgets(sizeController: headerSizeController),
            MapControllers(headerSizeController: headerSizeController),
            Positioned(
              bottom: context.padding.bottom,
              right: 0,
              left: 0,
              child: BlocBuilder<MapLocationsBloc, MapLocationsState>(
                builder: (context, state) {
                  final drawingObjects =
                      state.getLocationsFromRemoteStatus.isInProgress || state.getChargeLocationsStatus.isInProgress;
                  if (drawingObjects) {
                    return const LinearProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(AppColors.dodgerBlue),
                      color: AppColors.white,
                      minHeight: 2,
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? getMapStyle(ThemeSwitcherState themeState, MapState mapState) {
    if (mapState.hasLuminosity) {
      return MapStyle.withSaturation;
    } else if (themeState.appTheme.isDark) {
      return MapStyle.night;
    }
    return null;
  }

  void _onMapCreated(GoogleMapController controller) async {
    try {
      mapController = controller;
      mapBloc.add(InitializeMapControllerEvent(mapController: controller, context: context));
      await Future.delayed(const Duration(seconds: 1));
      headerSizeController.forward();
      print('error in _onMapCreated: ${headerSizeController.status}');
    } catch (e) {
      print('error in _onMapCreated: $e');
    }
  }

  void _onCameraMoved(CameraPosition position) {
    cameraPosition = position;
    mapBloc.add(CameraMovedEvent(cameraPosition: position));
  }

  void _onCameraIdle() async {
    final visibleRegion = await mapController.getVisibleRegion();
    mapLocationsBloc.add(SetVisibleRegionBounds(bounds: visibleRegion));
  }

  Set<Marker> _getMapObjects(MapState state) {
    final Set<Marker> mapObjects = {};
    if (state.userLocationObject != null) {
      mapObjects.add(state.userLocationObject!);
    }
    mapObjects.addAll(state.presentedMapObjects);
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
