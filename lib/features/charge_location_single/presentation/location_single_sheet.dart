import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/charge_location_single/data/repository_imlp/charge_location_single_repository_impl.dart';
import 'package:i_watt_app/features/charge_location_single/domain/usecases/get_charge_location_single_usecase.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/blocs/charge_location_single_bloc/charge_location_single_bloc.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/widgets/background_image.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/widgets/charging_points_card.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/widgets/charging_stations_sheet.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/widgets/contacts_card.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/widgets/draggable_head.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/widgets/facilities_card.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/widgets/facilities_sheet.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/widgets/header_address.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/widgets/header_top.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/widgets/location_body_wrapper.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/widgets/location_single_loader_view.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/widgets/location_single_sheet_bottom_widget.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/widgets/min_balance_card.dart';
import 'package:i_watt_app/features/common/data/repositories_impl/socket_repository_impl.dart';
import 'package:i_watt_app/features/common/domain/usecases/connector_status_stream_usecase.dart';
import 'package:i_watt_app/features/common/presentation/blocs/present_bottom_sheet/present_bottom_sheet_bloc.dart';
import 'package:i_watt_app/features/common/presentation/widgets/present_back_wrapper.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_keyboard_dismisser.dart';
import 'package:i_watt_app/service_locator.dart';

class LocationSingleSheet extends StatefulWidget {
  final String title;
  final double avgScore;
  final int commentCount;
  final String address;
  final bool midSize;
  final String distance;
  final int id;
  final String latitude;
  final String longitude;
  final int connectorId;
  final int stationId;

  const LocationSingleSheet({
    super.key,
    this.midSize = false,
    required this.title,
    this.avgScore = -1,
    this.commentCount = -1,
    required this.address,
    this.distance = '',
    required this.id,
    required this.latitude,
    required this.longitude,
    this.connectorId = -1,
    this.stationId = -1,
  });

  @override
  State<LocationSingleSheet> createState() => _LocationSingleSheetState();
}

class _LocationSingleSheetState extends State<LocationSingleSheet> with TickerProviderStateMixin {
  late TabController tabController;
  late DraggableScrollableController draggableScrollableController;
  late ValueNotifier<double> headerOpacity;
  late ValueNotifier<double> dragStickTop;
  late final ChargeLocationSingleBloc chargeLocationSingleBloc;
  late final AnimationController animationController;
  final GlobalKey _key = GlobalKey();
  late final ValueNotifier<int> isStationsSheet;
  double stationSingleSheetHeight = 0;
  late final Animation<double> animation;
  bool isOpened = false;

  @override
  void initState() {
    super.initState();
    isStationsSheet = ValueNotifier(0);
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
      reverseDuration: const Duration(milliseconds: 400),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          context.read<PresentBottomSheetBloc>().add(ShowPresentBottomSheet(isPresented: true));
        } else if (status == AnimationStatus.dismissed) {
          context.read<PresentBottomSheetBloc>().add(ShowPresentBottomSheet(isPresented: false));
        }
      });
    animation = CurvedAnimation(parent: animationController, curve: Curves.decelerate);
    headerOpacity = ValueNotifier(widget.midSize ? 1 : 0);
    dragStickTop = ValueNotifier(widget.midSize ? 20 : 0);
    draggableScrollableController = DraggableScrollableController()..addListener(draggableListener);
    chargeLocationSingleBloc = ChargeLocationSingleBloc(
      getChargeLocationSingleUseCase: GetChargeLocationSingleUseCase(
        serviceLocator<ChargeLocationSingleRepositoryImpl>(),
      ),
      connectorStatusStreamUseCase: ConnectorStatusStreamUseCase(
        serviceLocator<SocketRepositoryImpl>(),
      ),
      latitude: widget.latitude,
      longitude: widget.longitude,
    )..add(GetLocationSingle(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light,
      child: BlocProvider(
        create: (ctx) => chargeLocationSingleBloc,
        child: AnimatedBuilder(
          animation: animationController,
          builder: (context, child) {
            double scaleAnimation = 1 - (animationController.value * .1);
            final h = context.sizeOf.height - context.padding.top;
            double transformY = context.sizeOf.height - (h * animationController.value);
            double transformY2 = animationController.value;
            double opacity = 0;
            if (animationController.value > .3) {
              opacity = animationController.value * .8;
            } else {
              opacity = 0;
            }
            double borderRadius = 20 * animationController.value;
            return Stack(
              children: [
                PresentSheetBackPageWrapper(
                  transformY2: transformY2,
                  scaleAnimation: scaleAnimation,
                  borderRadius: borderRadius,
                  child: child ?? const SizedBox.shrink(),
                ),
                ValueListenableBuilder(
                  valueListenable: isStationsSheet,
                  builder: (ctx, val, child) {
                    return Transform.translate(
                      offset: Offset(0, transformY),
                      child: GestureDetector(
                        onVerticalDragStart: _onDragStart,
                        onVerticalDragUpdate: _onDragUpdate,
                        onVerticalDragEnd: _onDragEnd,
                        child: val == 1
                            ? StationSingleSheet(
                                onClose: () {
                                  onToggled();
                                },
                                isSelected: isStationsSheet.value,
                              )
                            : FacilitiesSheet(
                                onClose: () {
                                  onToggled();
                                },
                              ),
                      ),
                    );
                  },
                )
              ],
            );
          },
          child: WKeyboardDismisser(
            child: Stack(
              children: [
                BackgroundImage(headerOpacity: headerOpacity),
                Positioned.fill(
                  top: MediaQueryData.fromView(View.of(context)).padding.top,
                  child: DraggableScrollableSheet(
                    snap: true,
                    snapSizes: const [.5, .83, 1],
                    minChildSize: .5,
                    initialChildSize: widget.midSize ? .83 : .5,
                    controller: draggableScrollableController,
                    builder: (context, controller) {
                      return SizedBox(
                        height: context.sizeOf.height,
                        child: NotificationListener(
                          onNotification: (OverscrollIndicatorNotification notification) {
                            notification.disallowIndicator();
                            return false;
                          },
                          child: Stack(
                            children: [
                              LocationSingleBodyWrapper(
                                child: BlocConsumer<ChargeLocationSingleBloc, ChargeLocationSingleState>(
                                  listenWhen: (o, n) => o.getSingleStatus != n.getSingleStatus,
                                  listener: (context, state) {
                                    if (state.getSingleStatus.isSuccess &&
                                        widget.connectorId != -1 &&
                                        widget.stationId != -1 &&
                                        widget.id != -1 &&
                                        !isOpened) {
                                      context.read<ChargeLocationSingleBloc>().add(ChangeSelectedStationIndexByConnectorId(widget.connectorId));
                                      isStationsSheet.value = 1;
                                      onToggled();
                                    }
                                  },
                                  buildWhen: (o, n) => o.getSingleStatus != n.getSingleStatus,
                                  builder: (context, state) {
                                    final location = state.location;
                                    final vendor = location.vendor;
                                    final chargers = location.chargers;
                                    final facilities = location.facilities;
                                    return CustomScrollView(
                                      physics: const BouncingScrollPhysics(),
                                      controller: controller,
                                      slivers: [
                                        SliverPersistentHeader(
                                          pinned: true,
                                          delegate: LocationSingleHeaderTop(
                                            locationName: widget.title,
                                          ),
                                        ),
                                        SliverPersistentHeader(
                                          delegate: LocationSingleHeaderAddress(
                                            locationAddress: widget.address,
                                            distance: widget.distance,
                                          ),
                                        ),
                                        //TODO next version
                                        // SliverPersistentHeader(
                                        //   pinned: true,
                                        //   delegate: LocationSingleHeaderTabBar(tabController: tabController),
                                        // ),
                                        SliverList.list(
                                          children: [
                                            if (state.getSingleStatus.isSuccess) ...{
                                              if (vendor.minimumBalance.isNotEmpty) ...{
                                                MinBalanceCard(minBalance: vendor.minimumBalance),
                                              },
                                              ConnectorsCard(
                                                chargers: chargers,
                                                onTap: () {
                                                  isStationsSheet.value = 1;
                                                  context.read<PresentBottomSheetBloc>().add(ShowPresentBottomSheet(isPresented: true));
                                                  onToggled();
                                                },
                                              ),
                                              FacilitiesCard(
                                                facilities: facilities,
                                                onAll: () {
                                                  isStationsSheet.value = 2;
                                                  context.read<PresentBottomSheetBloc>().add(ShowPresentBottomSheet(isPresented: true));
                                                  onToggled();
                                                  //
                                                },
                                              ),
                                              ContactsCard(
                                                email: vendor.name,
                                                phone: vendor.phone,
                                                website: vendor.website,
                                                socialMedia: vendor.socialMedia,
                                              ),
                                              const SizedBox(height: 70),
                                            } else if (state.getSingleStatus.isInProgress) ...{
                                              const LocationSingleLoaderView()
                                            }
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                              DraggableHead(dragStickTop: dragStickTop)
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                LocationSingleSheetBottomWidget(
                  onChargeTap: () {
                    isStationsSheet.value = 1;
                    context.read<PresentBottomSheetBloc>().add(ShowPresentBottomSheet(isPresented: true));
                    onToggled();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  onToggled() async {
    if (animationController.isDismissed) {
      animationController.forward();
    } else {
      animationController.reverse();
    }
  }

  bool _canBeDragged = false;

  void _onDragStart(DragStartDetails details) {
    bool isDragOpenFromLeft = animationController.isDismissed && details.globalPosition.dy < stationSingleSheetHeight;
    bool isDragCloseFromRight = animationController.isCompleted && details.globalPosition.dy > context.sizeOf.height - stationSingleSheetHeight;
    _canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged) {
      double delta = details.primaryDelta! / (context.sizeOf.height * .5);
      animationController.value -= delta;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    if (animationController.isDismissed || animationController.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dy >= 365.0) {
      animationController.fling(velocity: -1);
    } else if (details.velocity.pixelsPerSecond.dy <= -365.0) {
      animationController.fling(velocity: 1);
    } else if (animationController.value < 0.7) {
      // close();
      animationController.reverse();
    } else {
      animationController.forward();
      // open();
    }
  }

  draggableListener() {
    if (draggableScrollableController.isAttached) {
      setPos(draggableScrollableController.pixels);
      setOpacity(draggableScrollableController.pixels);
    }
  }

  setOpacity(double pixels) {
    double min = draggableScrollableController.sizeToPixels(.78);
    double max = draggableScrollableController.sizeToPixels(.83);
    double opacityPercent = (pixels - min) / (max - min);
    if (pixels < min) {
      opacityPercent = 0;
    } else if (pixels >= max) {
      opacityPercent = 1;
    }
    headerOpacity.value = opacityPercent;
  }

  setPos(double pixels) {
    double min = 415.6363636363636;
    double max = 692.7272727272727;
    double posPercent = (pixels - min) / (max - min);
    double top = 20 * posPercent;
    if (pixels < min) {
      top = 0;
    } else if (pixels >= max) {
      top = 20;
    }
    dragStickTop.value = top;
  }
}
