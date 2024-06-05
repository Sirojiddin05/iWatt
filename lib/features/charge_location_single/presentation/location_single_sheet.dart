import 'package:flutter/material.dart';
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
import 'package:i_watt_app/features/charge_location_single/presentation/widgets/header_address.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/widgets/header_top.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/widgets/location_body_wrapper.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/widgets/location_single_sheet_bottom_widget.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/widgets/min_balance_card.dart';
import 'package:i_watt_app/features/common/data/repositories_impl/socket_repository_impl.dart';
import 'package:i_watt_app/features/common/domain/usecases/connector_status_stream_usecase.dart';
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
  double contentHeight = 0;

  @override
  void initState() {
    super.initState();
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
    headerOpacity = ValueNotifier(widget.midSize ? 1 : 0);
    dragStickTop = ValueNotifier(widget.midSize ? 20 : 0);
    draggableScrollableController = DraggableScrollableController()..addListener(draggableListener);
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      RenderBox renderBox = _key.currentContext?.findRenderObject() as RenderBox;
      Size size = renderBox.size;
      contentHeight = size.height;
    });
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    RenderBox renderBox = _key.currentContext?.findRenderObject() as RenderBox;
    Size size = renderBox.size;
    contentHeight = size.height;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: chargeLocationSingleBloc,
      child: WKeyboardDismisser(
        child: AnimatedBuilder(
            animation: animationController,
            builder: (context, child) {
              double scaleAnimation = 1 - (animationController.value * .1);
              double transformY = context.sizeOf.height - (contentHeight * animationController.value);
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
                  Transform.translate(
                    offset: Offset(0, transformY2),
                    child: Transform(
                      transform: Matrix4.identity()..scale(scaleAnimation),
                      alignment: Alignment.center,
                      child: Container(
                        width: context.sizeOf.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(borderRadius),
                        ),
                        clipBehavior: Clip.hardEdge,
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
                                            child: BlocBuilder<ChargeLocationSingleBloc, ChargeLocationSingleState>(
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
                                                          ChargingPointsCard(chargers: chargers),
                                                          FacilitiesCard(facilities: facilities),
                                                          ContactsCard(
                                                            email: vendor.name,
                                                            phone: vendor.phone,
                                                            website: vendor.website,
                                                            socialMedia: vendor.socialMedia,
                                                          ),
                                                          // LoaderSwitcherWidget(
                                                          //   loading: state.getSingleChargeLocationStatus ==
                                                          //       FormzSubmissionStatus.inProgress,
                                                          //   loaderWidget: const MinBalanceCardLoader(),
                                                          //   child: const MinBalanceCard(),
                                                          // ),
                                                          // LoaderSwitcherWidget(
                                                          //   loading: state.getSingleChargeLocationStatus ==
                                                          //       FormzSubmissionStatus.inProgress,
                                                          //   loaderWidget: const ChargingPointsCardLoader(),
                                                          //   child: ChargingPointsCard(location: widget.location),
                                                          // ),
                                                          // LoaderSwitcherWidget(
                                                          //   loading: state.getSingleChargeLocationStatus ==
                                                          //       FormzSubmissionStatus.inProgress,
                                                          //   loaderWidget: const FacilitiesCardLoader(),
                                                          //   child: const FacilitiesCard(),
                                                          // ),
                                                          // LoaderSwitcherWidget(
                                                          //   loading: state.getSingleChargeLocationStatus ==
                                                          //       FormzSubmissionStatus.inProgress,
                                                          //   loaderWidget: const ContactsCardLoader(),
                                                          //   child: const ContactsCard(),
                                                          // ),
                                                          const SizedBox(height: 70),
                                                        } else ...{
                                                          const CircularProgressIndicator.adaptive()
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
                              onChargeTap: onToggled,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(0, transformY),
                    child: GestureDetector(
                      onVerticalDragStart: _onDragStart,
                      onVerticalDragUpdate: _onDragUpdate,
                      onVerticalDragEnd: _onDragEnd,
                      child: StationSingleSheet(
                        key: _key,
                        onClose: onToggled,
                      ),
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }

  onToggled() {
    if (animationController.isDismissed) {
      animationController.forward();
    } else {
      animationController.reverse();
    }
  }

  bool _canBeDragged = false;

  void _onDragStart(DragStartDetails details) {
    bool isDragOpenFromLeft = animationController.isDismissed && details.globalPosition.dy < contentHeight;
    bool isDragCloseFromRight = animationController.isCompleted && details.globalPosition.dy > context.sizeOf.height - contentHeight;
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
