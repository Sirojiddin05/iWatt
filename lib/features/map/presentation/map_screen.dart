import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/map_style.dart';
import 'package:i_watt_app/core/config/storage_keys.dart';
import 'package:i_watt_app/core/services/storage_repository.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/location_single_sheet.dart';
import 'package:i_watt_app/features/common/presentation/blocs/car_on_map_bloc/car_on_map_bloc.dart';
import 'package:i_watt_app/features/common/presentation/blocs/theme_switcher_bloc/theme_switcher_bloc.dart';
import 'package:i_watt_app/features/list/data/repository_impl/charge_locations_repository_impl.dart';
import 'package:i_watt_app/features/list/domain/usecases/get_charge_locations_usecase.dart';
import 'package:i_watt_app/features/list/domain/usecases/save_unsave_stream_usecase.dart';
import 'package:i_watt_app/features/list/presentation/blocs/charge_locations_bloc/charge_locations_bloc.dart';
import 'package:i_watt_app/features/map/presentation/blocs/map_bloc/map_bloc.dart';
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
  CameraPosition? cameraPosition;

  @override
  void initState() {
    super.initState();
    chargeLocationsBloc = ChargeLocationsBloc(
      isForMap: true,
      getChargeLocationsUseCase: GetChargeLocationsUseCase(serviceLocator<ChargeLocationsRepositoryImpl>()),
      saveStreamUseCase: SaveUnSaveStreamUseCase(serviceLocator<ChargeLocationsRepositoryImpl>()),
    );
    mapBloc = BlocProvider.of<MapBloc>(context);
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
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            MultiBlocListener(
              listeners: [
                BlocListener<ChargeLocationsBloc, ChargeLocationsState>(
                  listenWhen: (o, n) => o.chargeLocations != n.chargeLocations,
                  listener: (context, state) {
                    mapBloc.add(SetFilteredLocations(state.chargeLocations));
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
                listenWhen: (o, n) {
                  final areChargeLocationsUpdated = o.locations != n.locations;
                  // final isLuminosityUpdated = o.hasLuminosity != n.hasLuminosity;
                  return areChargeLocationsUpdated;
                },
                listener: (context, state) {
                  if (state.isMapInitialized) {
                    mapBloc.add(
                      DrawChargeLocationsEvent(
                        onLocationTap: (location) {
                          headerSizeController.reverse();
                          showModalBottomSheet(
                            context: context,
                            useRootNavigator: true,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            barrierColor: Colors.transparent,
                            builder: (ctx) {
                              return LocationSingleSheet(
                                title: '${location.vendorName} "${location.locationName}"',
                                address: location.address,
                                distance: location.distance.toString(),
                                midSize: false,
                                id: location.id,
                                latitude: location.latitude,
                                longitude: location.longitude,
                              );
                            },
                          ).then((value) {
                            headerSizeController.forward();
                          });
                        },
                      ),
                    );
                  }
                },
                buildWhen: (o, n) {
                  final areChargeLocationsUpdated = o.presentedMapObjects != n.presentedMapObjects;
                  final userLocationUpdated = o.userLocationObject != n.userLocationObject;
                  return areChargeLocationsUpdated || userLocationUpdated;
                },
                builder: (context, state) {
                  return BlocBuilder<ThemeSwitcherBloc, ThemeSwitcherState>(
                    builder: (context, themeState) {
                      return GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                            StorageRepository.getDouble(StorageKeys.latitude, defValue: 0),
                            StorageRepository.getDouble(StorageKeys.longitude, defValue: 0),
                          ),
                          zoom: 18,
                        ),
                        onMapCreated: _onMapCreated,
                        markers: _getMapObjects(state),
                        onCameraMove: (position) {
                          cameraPosition = position;
                          mapBloc.add(const ChangeLuminosityStateEvent(hasLuminosity: false));
                        },
                        onCameraIdle: _onCameraIdle,
                        style: themeState.appTheme.isLight ? null : MapStyle.night,
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
              child: BlocBuilder<MapBloc, MapState>(
                builder: (context, state) {
                  if (state.drawingObjects) {
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

  void _onMapCreated(GoogleMapController controller) async {
    mapBloc.add(InitializeMapControllerEvent(mapController: controller, context: context));
    await Future.delayed(const Duration(seconds: 1));
    headerSizeController.forward();
  }

  void _onCameraIdle() {
    mapBloc.add(
      SetPresentPlaceMarks(
        zoom: cameraPosition!.zoom,
        point: cameraPosition!.target,
      ),
    );
  }

  // void _onMapTap(Point point) {}
  //
  Set<Marker> _getMapObjects(MapState state) {
    final Set<Marker> mapObjects = {};
    if (state.userLocationObject != null) {
      mapObjects.add(state.userLocationObject!);
    }
    mapObjects.addAll(state.presentedMapObjects);
    print('Map objects: $mapObjects');
    print('Map objects: ${mapObjects.length}');
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
