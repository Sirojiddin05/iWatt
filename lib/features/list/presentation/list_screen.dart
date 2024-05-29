import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_watt_app/core/config/storage_keys.dart';
import 'package:i_watt_app/core/services/storage_repository.dart';
import 'package:i_watt_app/features/list/data/repository_impl/charge_locations_repository_impl.dart';
import 'package:i_watt_app/features/list/domain/usecases/get_charge_locations_usecase.dart';
import 'package:i_watt_app/features/list/domain/usecases/save_unsave_stream_usecase.dart';
import 'package:i_watt_app/features/list/presentation/blocs/charge_locations_bloc/charge_locations_bloc.dart';
import 'package:i_watt_app/features/list/presentation/widgets/locations_list.dart';
import 'package:i_watt_app/features/list/presentation/widgets/search_filter_list.dart';
import 'package:i_watt_app/service_locator.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  late final ChargeLocationsBloc chargeLocationsBloc;

  @override
  void initState() {
    super.initState();
    chargeLocationsBloc = ChargeLocationsBloc(
        getChargeLocationsUseCase: GetChargeLocationsUseCase(serviceLocator<ChargeLocationsRepositoryImpl>()),
        saveStreamUseCase: SaveUnSaveStreamUseCase(serviceLocator<ChargeLocationsRepositoryImpl>()))
      ..add(const GetChargeLocationsEvent());
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
    return BlocProvider.value(
      value: chargeLocationsBloc,
      child: const Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 84),
          child: SearchFilterList(),
        ),
        body: LocationsList(),
      ),
    );
  }
}
