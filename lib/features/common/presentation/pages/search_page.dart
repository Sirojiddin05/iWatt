import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/location_single_sheet.dart';
import 'package:i_watt_app/features/common/presentation/blocs/search_history_bloc/search_history_bloc.dart';
import 'package:i_watt_app/features/common/presentation/widgets/error_state_text.dart';
import 'package:i_watt_app/features/common/presentation/widgets/map_search_app_bar.dart';
import 'package:i_watt_app/features/common/presentation/widgets/paginator.dart';
import 'package:i_watt_app/features/common/presentation/widgets/search_empty_state_widget.dart';
import 'package:i_watt_app/features/common/presentation/widgets/search_history_widget.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_keyboard_dismisser.dart';
import 'package:i_watt_app/features/list/data/repository_impl/charge_locations_repository_impl.dart';
import 'package:i_watt_app/features/list/domain/usecases/get_charge_locations_usecase.dart';
import 'package:i_watt_app/features/list/domain/usecases/save_unsave_stream_usecase.dart';
import 'package:i_watt_app/features/list/presentation/blocs/charge_locations_bloc/charge_locations_bloc.dart';
import 'package:i_watt_app/features/list/presentation/widgets/charge_location_item.dart';
import 'package:i_watt_app/service_locator.dart';

class SearchPage extends StatefulWidget {
  final bool isForMap;

  const SearchPage({super.key, required this.isForMap});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late FocusNode focusNode;
  late ChargeLocationsBloc chargeLocationsBloc;
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    focusNode = FocusNode()..requestFocus();
    chargeLocationsBloc = chargeLocationsBloc = ChargeLocationsBloc(
      getChargeLocationsUseCase: GetChargeLocationsUseCase(serviceLocator<ChargeLocationsRepositoryImpl>()),
      saveStreamUseCase: SaveUnSaveStreamUseCase(serviceLocator<ChargeLocationsRepositoryImpl>()),
    );
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WKeyboardDismisser(
      child: BlocProvider<ChargeLocationsBloc>.value(
        value: chargeLocationsBloc,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            children: [
              SearchAppBar(focusNode: focusNode, controller: _searchController),
              BlocBuilder<ChargeLocationsBloc, ChargeLocationsState>(
                  buildWhen: (o, n) =>
                      o.searchPattern != n.searchPattern ||
                      o.chargeLocations != n.chargeLocations ||
                      o.getChargeLocationsStatus != n.getChargeLocationsStatus,
                  builder: (context, state) {
                    if (state.searchPattern.isEmpty) {
                      return SearchHistoryWidget(
                        onTap: (String value) {
                          _searchController.text = value;
                          context.read<ChargeLocationsBloc>().add(SetSearchPatternEvent(value));
                        },
                      );
                    } else {
                      if (state.getChargeLocationsStatus.isSuccess) {
                        if (state.chargeLocations.isEmpty) {
                          return Expanded(child: SearchEmptyStateWidget(isForMap: widget.isForMap));
                        }
                        return Expanded(
                          child: Paginator(
                            padding: EdgeInsets.fromLTRB(16, 16, 16, MediaQuery.viewInsetsOf(context).bottom + 16),
                            paginatorStatus: FormzSubmissionStatus.success,
                            itemBuilder: (ctx, index) {
                              final location = state.chargeLocations[index];
                              return ChargeLocationCard(
                                location: location,
                                highlightedTitle: state.searchPattern,
                                onTap: () {
                                  context.read<SearchHistoryBloc>().add(PostSearchHistoryEvent(location.id));
                                  showModalBottomSheet(
                                    context: context,
                                    useRootNavigator: true,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    barrierColor: AppColors.black.withOpacity(.52),
                                    builder: (ctx) {
                                      return LocationSingleSheet(
                                        title: '${location.vendorName} "${location.locationName}"',
                                        address: location.address,
                                        distance: location.distance.toString(),
                                        midSize: true,
                                        id: location.id,
                                        latitude: location.latitude,
                                        longitude: location.longitude,
                                      );
                                    },
                                  );
                                  // todo: implement
                                  // showCupertinoModalBottomSheet(
                                  //   isDismissible: true,
                                  //   context: context,
                                  //   useRootNavigator: true,
                                  //   builder: (ctx) {
                                  //     return ChargeLocationSheet(location: location);
                                  //   },
                                  // );
                                },
                              );
                            },
                            separatorBuilder: (ctx, index) => const SizedBox(height: 12),
                            itemCount: state.chargeLocations.length,
                            fetchMoreFunction: () {
                              context.read<ChargeLocationsBloc>().add(const GetMoreChargeLocationsEvent());
                            },
                            hasMoreToFetch: state.fetchMore,
                          ),
                        );
                      } else if (state.getChargeLocationsStatus.isFailure) {
                        return const ErrorStateTextWidget();
                      }
                      return const SizedBox.shrink();
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
