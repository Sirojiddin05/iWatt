import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/config/app_images.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/app_bar_wrapper.dart';
import 'package:i_watt_app/features/common/presentation/widgets/empty_state_widget.dart';
import 'package:i_watt_app/features/common/presentation/widgets/error_state_text.dart';
import 'package:i_watt_app/features/common/presentation/widgets/paginator.dart';
import 'package:i_watt_app/features/list/data/repository_impl/charge_locations_repository_impl.dart';
import 'package:i_watt_app/features/list/domain/usecases/get_charge_locations_usecase.dart';
import 'package:i_watt_app/features/list/domain/usecases/save_unsave_stream_usecase.dart';
import 'package:i_watt_app/features/list/presentation/blocs/charge_locations_bloc/charge_locations_bloc.dart';
import 'package:i_watt_app/features/list/presentation/widgets/charge_location_cards_loader.dart';
import 'package:i_watt_app/features/list/presentation/widgets/charge_location_item.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';
import 'package:i_watt_app/service_locator.dart';

class SavedLocations extends StatefulWidget {
  const SavedLocations({super.key});

  @override
  State<SavedLocations> createState() => _SavedLocationsState();
}

class _SavedLocationsState extends State<SavedLocations> {
  late final ChargeLocationsBloc chargeLocationsBloc;

  @override
  void initState() {
    super.initState();
    chargeLocationsBloc = ChargeLocationsBloc(
      getChargeLocationsUseCase: GetChargeLocationsUseCase(
        serviceLocator<ChargeLocationsRepositoryImpl>(),
      ),
      saveStreamUseCase: SaveUnSaveStreamUseCase(
        serviceLocator<ChargeLocationsRepositoryImpl>(),
      ),
    )..add(const SetFavouriteEvent(isFavourite: true));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: chargeLocationsBloc,
      child: Scaffold(
          appBar: AppBarWrapper(
            hasBackButton: true,
            title: LocaleKeys.saved_stations.tr(),
          ),
          body: BlocBuilder<ChargeLocationsBloc, ChargeLocationsState>(
            buildWhen: (o, n) =>
                o.getChargeLocationsStatus != n.getChargeLocationsStatus || o.chargeLocations != n.chargeLocations,
            builder: (context, state) {
              if (state.getChargeLocationsStatus.isInProgress) {
                return const ChargeLocationCardsLoader();
              } else if (state.getChargeLocationsStatus.isSuccess) {
                if (state.chargeLocations.isEmpty) {
                  return Center(
                    child: EmptyStateWidget(
                      title: LocaleKeys.there_are_no_saved_stations.tr(),
                      subtitle: LocaleKeys.you_have_not_save_stations_yet.tr(),
                      icon: AppImages.emptyStation,
                    ),
                  );
                }
                final itemNumber = state.chargeLocations.length;
                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<ChargeLocationsBloc>().add(const GetChargeLocationsEvent());
                  },
                  child: Paginator(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.fromLTRB(16, 16, 16, context.padding.bottom),
                    paginatorStatus: FormzSubmissionStatus.success,
                    itemCount: itemNumber,
                    fetchMoreFunction: () {
                      context.read<ChargeLocationsBloc>().add(const GetMoreChargeLocationsEvent());
                    },
                    hasMoreToFetch: state.fetchMore,
                    itemBuilder: (ctx, index) {
                      final location = state.chargeLocations[index];
                      return ChargeLocationCard(
                        location: location,
                        highlightedTitle: state.searchPattern,
                        hasSavedIcon: true,
                        onTap: () {
                          // showModalBottomSheet(
                          //   context: context,
                          //   barrierColor: black.withOpacity(.52),
                          //   useRootNavigator: true,
                          //   isScrollControlled: true,
                          //   enableDrag: false,
                          //   backgroundColor: Colors.transparent,
                          //   shape: const RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                          //   ),
                          //   builder: (ctx) {
                          //     return LocationSingleSheet(
                          //       location: location,
                          //       distance: distance,
                          //       midSize: true,
                          //     );
                          //   },
                          // );
                        },
                      );
                    },
                    separatorBuilder: (ctx, index) => const SizedBox(height: 16),
                  ),
                );
              } else if (state.getChargeLocationsStatus.isFailure) {
                return const ErrorStateTextWidget();
              }
              return const SizedBox.shrink();
            },
          )),
    );
  }
}
