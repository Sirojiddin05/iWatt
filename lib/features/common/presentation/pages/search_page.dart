import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/util/my_functions.dart';
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
  @override
  void initState() {
    super.initState();
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
              SearchAppBar(focusNode: focusNode),
              BlocBuilder<ChargeLocationsBloc, ChargeLocationsState>(
                  buildWhen: (o, n) =>
                      o.searchPattern != n.searchPattern ||
                      o.chargeLocations != n.chargeLocations ||
                      o.getChargeLocationsStatus != n.getChargeLocationsStatus,
                  builder: (context, state) {
                    if (state.searchPattern.isEmpty) {
                      return const SearchHistoryWidget();
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
                              final lat = double.tryParse(location.latitude) ?? 0;
                              final long = double.tryParse(location.longitude) ?? 0;
                              //TODO: Implement distance calculation
                              final distance = '';
                              final powerTypes = location.chargePoints.map((e) => e.type).toList();
                              return ChargeLocationCard(
                                title: location.name,
                                highlightedTitle: state.searchPattern,
                                subtitle: location.address,
                                powerTypes: powerTypes,
                                distanceValue: distance,
                                locationId: location.id,
                                stationsCount: location.chargePoints.length,
                                connectorStatuses: MyFunctions.getConnectorStatuses(location),
                                onTap: () {
                                  // showCupertinoModalBottomSheet(
                                  //   isDismissible: true,
                                  //   context: context,
                                  //   useRootNavigator: true,
                                  //   builder: (ctx) {
                                  //     return ChargeLocationSheet(location: location);
                                  //   },
                                  // );
                                },
                                logo: '',
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
